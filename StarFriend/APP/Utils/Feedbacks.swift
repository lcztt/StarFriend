//
//  Feedbacks.swift
//  SwiftTest
//
//  Created by chao luo on 2023/12/6.
//

import Foundation
import RxSwift
import RxCocoa

// taken from RxFeedback repo

extension ObservableType where Element == Any {
    /// Feedback loop
    public typealias Feedback<State, Event> = (ObservableSchedulerContext<State>) -> Observable<Event>
    public typealias FeedbackLoop = Feedback

    /**
     System simulation will be started upon subscription and stopped after subscription is disposed.

     System state is represented as a `State` parameter.
     Events are represented by `Event` parameter.

     - parameter initialState: Initial state of the system.
     - parameter reduce: Calculates new system state from existing state and a transition event (system integrator, reducer).
     - parameter scheduler: Scheduler on which observable sequence receives elements
     - parameter scheduledFeedback: Feedback loops that produce events depending on current system state.
     - returns: Current state of the system.
     */
    public static func system<State, Event>(
        initialState: State,
        reduce: @escaping (State, Event) -> State,
        scheduler: ImmediateSchedulerType,
        scheduledFeedback: [Feedback<State, Event>]
        ) -> Observable<State> {
        return Observable<State>.deferred {
            let replaySubject = ReplaySubject<State>.create(bufferSize: 1)

            let asyncScheduler = scheduler.async

            let events: Observable<Event> = Observable.merge(scheduledFeedback.map { feedback in
                let state = ObservableSchedulerContext(source: replaySubject.asObservable(), scheduler: asyncScheduler)
                return feedback(state)
            })
                // This is protection from accidental ignoring of scheduler so
                // reentracy errors can be avoided
                .observe(on:CurrentThreadScheduler.instance)

            return events.scan(initialState, accumulator: reduce)
                .do(onNext: { output in
                    replaySubject.onNext(output)
                }, onSubscribed: {
                    replaySubject.onNext(initialState)
                })
                .subscribe(on: scheduler)
                .startWith(initialState)
                .observe(on:scheduler)
        }
    }

    public static func system<State, Event>(
        initialState: State,
        reduce: @escaping (State, Event) -> State,
        scheduler: ImmediateSchedulerType,
        scheduledFeedback: Feedback<State, Event>...
        ) -> Observable<State> {
        system(initialState: initialState, reduce: reduce, scheduler: scheduler, scheduledFeedback: scheduledFeedback)
    }
}

extension Observable {
    fileprivate func enqueue(_ scheduler: ImmediateSchedulerType) -> Observable<Element> {
        return self
            // observe on is here because results should be cancelable
            .observe(on:scheduler.async)
            // subscribe on is here because side-effects also need to be cancelable
            // (smooths out any glitches caused by start-cancel immediately)
            .subscribe(on: scheduler.async)
    }
}

/**
 Bi-directional binding of a system State to external state machine and events from it.
 Strongify owner.
 */
public func bind<State, Event, WeakOwner>(_ owner: WeakOwner, _ bindings: @escaping (WeakOwner, ObservableSchedulerContext<State>) -> (Bindings<Event>))
    -> (ObservableSchedulerContext<State>) -> Observable<Event> where WeakOwner: AnyObject {
        return bind(bindingsStrongify(owner, bindings))
}

/**
 Bi-directional binding of a system State to external state machine and events from it.
 */
public func bind<State, Event>(_ bindings: @escaping (ObservableSchedulerContext<State>) -> (Bindings<Event>)) -> (ObservableSchedulerContext<State>) -> Observable<Event> {
    return { (state: ObservableSchedulerContext<State>) -> Observable<Event> in
        return Observable<Event>.using({ () -> Bindings<Event> in
            return bindings(state)
        }, observableFactory: { (bindings: Bindings<Event>) -> Observable<Event> in
            return Observable<Event>.merge(bindings.events)
                .enqueue(state.scheduler)
        })
    }
}


///**
// Bi-directional binding of a system State to external state machine and events from it.
// Strongify owner.
// */
//public func bind<State, Event, WeakOwner>(_ owner: WeakOwner, _ bindings: @escaping (WeakOwner, Driver<State>) -> (Bindings<Event>))
//    -> (Driver<State>) -> Signal<Event> where WeakOwner: AnyObject {
//        return bind(bindingsStrongify(owner, bindings))
//}
//
///**
// Bi-directional binding of a system State to external state machine and events from it.
// */
//public func bind<State, Event>(_ bindings: @escaping (Driver<State>) -> (Bindings<Event>)) -> (Driver<State>) -> Signal<Event> {
//    return { (state: Driver<State>) -> Signal<Event> in
//        return Observable<Event>.using({ () -> Bindings<Event> in
//            return bindings(state)
//        }, observableFactory: { (bindings: Bindings<Event>) -> Observable<Event> in
//            return Observable<Event>.merge(bindings.events)
//        })
//            .enqueue(Signal<Event>.SharingStrategy.scheduler)
//            .asSignal(onErrorSignalWith: .empty())
//    }
//}

private func bindingsStrongify<Event, O, WeakOwner>(_ owner: WeakOwner, _ bindings: @escaping (WeakOwner, O) -> (Bindings<Event>))
    -> (O) -> (Bindings<Event>) where WeakOwner: AnyObject {
        return { [weak owner] state -> Bindings<Event> in
            guard let strongOwner = owner else {
//                return Bindings(subscriptions: [], events: [Observable<Event>]())
                return Bindings(subscriptions: [], events: [RxSwift.Observable<Event>]())
            }
            return bindings(strongOwner, state)
        }
}

/**
 Contains subscriptions and events.
 - `subscriptions` map a system state to UI presentation.
 - `events` map events from UI to events of a given system.
 */
public class Bindings<Event>: Disposable {
    private let subscriptions: [Disposable]
    fileprivate let events: [Observable<Event>]

    /**
     - parameters:
     - subscriptions: mappings of a system state to UI presentation.
     - events: mappings of events from UI to events of a given system
     */
    public init(subscriptions: [Disposable], events: [Observable<Event>]) {
        self.subscriptions = subscriptions
        self.events = events
    }

    /**
     - parameters:
     - subscriptions: mappings of a system state to UI presentation.
     - events: mappings of events from UI to events of a given system
     */
    public init(subscriptions: [Disposable], events: [Signal<Event>]) {
        self.subscriptions = subscriptions
        self.events = events.map { $0.asObservable() }
    }

    public func dispose() {
        for subscription in subscriptions {
            subscription.dispose()
        }
    }
}
