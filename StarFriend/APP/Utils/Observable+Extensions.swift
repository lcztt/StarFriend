//
//  Observable+Extensions.swift
//  SwiftTest
//
//  Created by chao luo on 2023/12/6.
//

import Foundation
import RxSwift

/// Tuple of observable sequence and corresponding scheduler context on which that observable
/// sequence receives elements.
public struct ObservableSchedulerContext<Element>: ObservableType {
    public typealias Element = Element

    /// Source observable sequence
    public let source: Observable<Element>

    /// Scheduler on which observable sequence receives elements
    public let scheduler: ImmediateSchedulerType

    /// Initializes self with source observable sequence and scheduler
    ///
    /// - parameter source: Source observable sequence.
    /// - parameter scheduler: Scheduler on which source observable sequence receives elements.
    public init(source: Observable<Element>, scheduler: ImmediateSchedulerType) {
        self.source = source
        self.scheduler = scheduler
    }

    public func subscribe<Observer: ObserverType>(_ observer: Observer) -> Disposable where Observer.Element == Element {
        self.source.subscribe(observer)
    }
}

extension ImmediateSchedulerType {
    var async: ImmediateSchedulerType {
        // This is a hack because of reentrancy. We need to make sure events are being sent async.
        // In case MainScheduler is being used MainScheduler.asyncInstance is used to make sure state is modified async.
        // If there is some unknown scheduler instance (like TestScheduler), just use it.
        return (self as? MainScheduler).map { _ in MainScheduler.asyncInstance } ?? self
    }
}

