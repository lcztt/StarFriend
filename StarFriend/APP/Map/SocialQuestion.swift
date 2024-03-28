//
//  SocialQuestion.swift
//  SwiftUISocial
//
//  Created by vitas on 2024/1/9.
//

import Foundation

struct SocialQuestionData {
    static let allQuests = [
    SocialQuestion(index: 0,
                   question_en: "What is your favorite social activity?",
                   question_zh: "你最喜欢的社交活动是什么？",
                   answer: "My favorite social activity is attending live music concerts. I love the music and sharing the experience with friends."),
    SocialQuestion(index: 1,
                   question_en: "What do you consider the most enjoyable type of gathering?", 
                   question_zh: "你认为怎样的聚会是最有趣的？", 
                   answer: "I consider the most enjoyable type of gathering to be when friends come together to cook, and then we all share the meal. It combines the joy of food with building friendships."),
    SocialQuestion(index: 2,
                   question_en: "Can you share a memorable social experience you've had?", 
                   question_zh: "你最难忘的社交经历是什么？", 
                   answer: "One of my most memorable social experiences was meeting a group of like-minded people during a trip. We spent wonderful times together, creating strong bonds of friendship."),
    SocialQuestion(index: 3,
                   question_en: "Do you prefer small group get-togethers or large events?", 
                   question_zh: "你更喜欢小团体聚会还是大型活动？", 
                   answer: "I prefer small group get-togethers because they allow for more in-depth conversations, and everyone tends to be more relaxed."),
    SocialQuestion(index: 4,
                   question_en: "Have you ever been in a social situation that made you uncomfortable or nervous?", 
                   question_zh: "你有没有参加过令你感到不适或紧张的社交场合？", 
                   answer: "Yes, I once attended an important business dinner where I initially felt a bit nervous, but gradually eased into it through engaging conversations with others."),
    SocialQuestion(index: 5,
                   question_en: "How do you maintain a balance between enjoying social activities and having time alone?", 
                   question_zh: "你如何保持社交平衡，既能享受社交活动又能独处？", 
                   answer: "I maintain a balance by scheduling alone time in my calendar. This allows me to unwind and recharge, ensuring I have the energy to fully enjoy social activities."),
    SocialQuestion(index: 6,
                   question_en: "In your opinion, is the impact of social media on our social lives positive or negative?", 
                   question_zh: "你认为社交媒体对我们社交生活的影响是正面还是负面的？", 
                   answer: "In my opinion, the impact of social media on our social lives is mixed. While it helps us stay connected, it can also lead to feelings of isolation. It depends on how it's used."),
    SocialQuestion(index: 7,
                   question_en: "How do you go about making new friends?", 
                   question_zh: "你是如何结识新朋友的？", 
                   answer: "I often make new friends by joining interest groups, attending events, or through mutual friends. Being open to new experiences and initiating conversations has been key for me."),
    SocialQuestion(index: 8,
                   question_en: "What qualities do you appreciate most in others during social activities?", 
                   question_zh: "社交活动中，你最欣赏别人的什么品质？", 
                   answer: "During social activities, I appreciate qualities like authenticity and kindness. Genuine conversations and people who genuinely care about others make the experience more enjoyable."),
    SocialQuestion(index: 9,
                   question_en: "In your view, what makes the best social gathering?",
                   question_zh: "你觉得最好的社交场合是怎样的？", 
                   answer: "The best social gathering, in my view, is one where people feel comfortable, there's positive energy, and everyone is engaged. A mix of good company, interesting conversations, and perhaps some shared activities creates a memorable experience.")
    ]
    
    static let allAnswers = [SocialQuestionAnswers(index: 0,
                                                   answer: ["My favorite social activity is going to trivia nights with friends. It's a fun way to challenge our knowledge and enjoy each other's company.",
                                                            "I really enjoy participating in community service events as my favorite social activity. It's not only a chance to give back but also an opportunity to connect with like-minded individuals.",
                                                            "Going to live music concerts is my absolute favorite social activity. There's something magical about the energy of a live performance shared with friends.",
                                                            "I love organizing and attending game nights with friends. Board games, card games, and lots of laughter make for an entertaining and social evening.",
                                                            "Exploring new restaurants with friends is what I enjoy the most. It combines good food, great company, and the chance to discover hidden culinary gems in the city.",
                                                            "Engaging in outdoor activities like hiking and camping with friends is my favorite social activity. It allows us to bond in a natural setting while enjoying some physical activity.",
                                                            "Attending art classes with friends is something I find really enjoyable. It's a creative and social outlet that lets us express ourselves together.",
                                                            "I find attending book clubs to be a wonderful social activity. It combines my love for reading with insightful discussions and the chance to meet new people.",
                                                            "Traveling with friends is my absolute favorite social activity. Exploring new places together creates lasting memories and strengthens our friendships.",
                                                            "I love participating in sports leagues as my favorite social activity. Whether it's soccer, volleyball, or any team sport, it's a great way to stay active and build camaraderie with others."]),
                             SocialQuestionAnswers(index: 1,
                                                   answer: ["I find small dinner parties with close friends to be the most enjoyable type of gathering. It allows for meaningful conversations and a relaxed atmosphere.",
                                                            "Outdoor picnics are my favorite type of gathering. Enjoying good food and nature with friends or family creates a delightful and laid-back experience.",
                                                            "I consider game nights with a mix of board games and card games to be the most enjoyable gathering. It brings out laughter and friendly competition.",
                                                            "Attending live performances, such as theater plays or musicals, is what I find most enjoyable. It combines entertainment with the opportunity to share the experience with others.",
                                                            "I enjoy themed costume parties the most. Dressing up and seeing others in creative costumes adds a playful and festive element to the gathering.",
                                                            "Potluck dinners where everyone contributes a dish are my favorite. It creates a sense of community and allows everyone to showcase their culinary skills.",
                                                            "Networking events in my professional field are the most enjoyable gatherings for me. It's an opportunity to connect with colleagues, share insights, and build professional relationships.",
                                                            "Art exhibitions or gallery openings are gatherings I find most enjoyable. It combines appreciation for creativity with the chance to discuss and interpret artworks.",
                                                            "Music festivals are my favorite type of gathering. The vibrant atmosphere, diverse performances, and the shared love for music make it a memorable experience.",
                                                            "I consider family reunions to be the most enjoyable type of gathering. It's a time to reconnect, share stories, and strengthen familial bonds."]),
                             SocialQuestionAnswers(index: 2,
                                                   answer: ["One of my most memorable social experiences was a spontaneous road trip with friends. We explored new places, created lasting memories, and deepened our friendships.",
                                                            "Attending a surprise birthday party thrown by my friends is a memorable social experience. The effort they put into organizing it made me feel truly valued.",
                                                            "A memorable social experience for me was participating in a volunteer project abroad. It not only allowed me to make a positive impact but also introduced me to incredible people with shared values.",
                                                            "Joining a local hiking club and summiting a challenging peak with fellow members is a social experience I'll always cherish. The shared accomplishment created strong bonds.",
                                                            "Attending a live concert of my favorite band with a group of friends is a social experience I'll never forget. The music, the energy, and the camaraderie made it unforgettable.",
                                                            "Celebrating cultural festivals with a diverse group of friends stands out as a memorable social experience. Experiencing different traditions and cuisines together was enriching.",
                                                            "A memorable social experience was a themed costume party where everyone went all out with creative costumes. The laughter and vibrant atmosphere made it a fantastic evening.",
                                                            "Participating in a team-building retreat with colleagues was a memorable social experience. It strengthened our professional relationships and created a more cohesive work environment.",
                                                            "Traveling solo and making spontaneous connections with locals and fellow travelers is a social experience that has left a lasting impact on me.",
                                                            "Hosting a potluck dinner where friends brought dishes from their cultural backgrounds was a memorable social experience. It showcased the diversity of our friendships and the joy of sharing food."]),
                             SocialQuestionAnswers(index: 3,
                                                   answer: ["I prefer small group get-togethers. The intimate setting allows for deeper conversations and meaningful connections.",
                                                            "I enjoy both, but if I had to choose, I lean towards small group get-togethers. They feel more relaxed and personal.",
                                                            "Small group get-togethers are my preference. They create a comfortable atmosphere where everyone can actively participate in the conversation.",
                                                            "I have a preference for large events. The energy and excitement of a big crowd add to the overall experience.",
                                                            "I prefer small group get-togethers. They offer a chance to really get to know people, and everyone's contributions are valued.",
                                                            "Large events have their appeal, but I find myself more comfortable in small group settings. It allows for a stronger sense of camaraderie.",
                                                            "Small group get-togethers are my choice. They provide a more intimate space to share ideas and connect on a personal level.",
                                                            "I enjoy the diversity of large events, so they're usually my preference. The variety of people and activities make it exciting.",
                                                            "Small group get-togethers suit me better. It's easier to engage with everyone, and the atmosphere is generally more relaxed.",
                                                            "It depends on the occasion, but I generally prefer small group get-togethers. They allow for more meaningful interactions and a closer bond with those present."]),
                             SocialQuestionAnswers(index: 4,
                                                   answer: ["Yes, I once attended a networking event where I didn't know anyone, and the unfamiliarity of the situation made me quite nervous initially.",
                                                            "There was a time when I had to give a presentation in front of a large audience, and the fear of public speaking made me uncomfortable.",
                                                            "Attending a formal dinner with high-profile individuals made me uncomfortable. The pressure to make a good impression added a level of nervousness.",
                                                            "I felt uncomfortable at a family gathering where there was tension between relatives. Navigating through the strained atmosphere was challenging.",
                                                            "Joining a new workplace where I didn't know anyone initially made me feel quite nervous. It took some time to adjust and build relationships.",
                                                            "I once attended a social event where people were discussing a topic I wasn't familiar with, and I felt out of place, making me uncomfortable.",
                                                            "Participating in a team-building exercise with colleagues made me nervous. I wanted to contribute but was uncertain about how I would be perceived.",
                                                            "There was a party with a large guest list, and being an introvert, I found it overwhelming and felt uncomfortable in the crowded space.",
                                                            "I attended a job interview where the panel was more intimidating than I expected, leading to a nervous experience throughout the interview.",
                                                            "Joining a meetup group where everyone seemed to already know each other made me uncomfortable. Over time, I learned to break the ice and integrate into the group."]),
                             SocialQuestionAnswers(index: 5,
                                                   answer: ["I maintain balance by scheduling \"me time\" in my calendar. This ensures I have dedicated periods for self-reflection and relaxation.",
                                                            "To strike a balance, I prioritize self-care and set boundaries. I communicate my need for alone time to friends and family, and they respect it.",
                                                            "Balancing social and alone time is crucial for me. I achieve this by having regular quiet evenings at home, engaging in hobbies, and making time for close friends.",
                                                            "I schedule social events and alone time strategically. It helps me maintain a healthy balance, ensuring I enjoy the best of both worlds.",
                                                            "Maintaining balance involves being mindful of my energy levels. If I feel drained, I prioritize alone time to recharge, ensuring I'm ready for social activities when I'm at my best.",
                                                            "I've found that creating a routine helps maintain balance. Designating specific days for socializing and others for personal time provides structure.",
                                                            "Communication is key. I openly communicate with friends about my need for occasional solitude, and they understand and respect my boundaries.",
                                                            "Balancing social and alone time involves listening to my own needs. If I sense the need for solitude, I prioritize it without feeling guilty.",
                                                            "I use mindfulness techniques to stay present during social activities, and I incorporate regular meditation and alone time to ensure a balanced lifestyle.",
                                                            "Striking a balance means being intentional about the activities I commit to. I prioritize quality social interactions and ensure I have adequate alone time for self-reflection."]),
                             SocialQuestionAnswers(index: 6,
                                                   answer: ["In my opinion, the impact of social media is largely positive, as it facilitates easy communication, connection with friends and family, and the sharing of experiences.",
                                                            "I believe social media has both positive and negative aspects. While it helps us stay connected, it can also contribute to feelings of isolation and comparison.",
                                                            "Social media has a positive impact by allowing us to connect with people globally and share diverse perspectives. However, its negative side includes issues like online harassment.",
                                                            "I lean towards the positive side. Social media enhances our ability to stay informed, share moments, and maintain relationships, even over long distances.",
                                                            "The impact of social media is, in my opinion, mostly negative. It can lead to addiction, anxiety, and a sense of disconnection from real-life experiences.",
                                                            "I see social media as having a positive impact, providing a platform for self-expression, community building, and staying connected with friends and family.",
                                                            "Social media can be both positive and negative. While it helps in networking and staying updated, excessive use can lead to issues like FOMO (fear of missing out) and cyberbullying.",
                                                            "I believe social media has a more negative impact. It can contribute to a superficial sense of connection and may lead to a decline in face-to-face interactions.",
                                                            "Social media's impact is largely positive, enabling instant communication and the sharing of diverse content. However, managing screen time is crucial to maintain a healthy balance.",
                                                            "The impact of social media is mixed. It has improved communication but also raised concerns like privacy issues and the spread of misinformation."]),
                             SocialQuestionAnswers(index: 7,
                                                   answer: ["I make new friends by actively participating in social events and striking up conversations with people who share common interests.",
                                                            "Joining clubs or interest groups is my go-to strategy for making new friends. It allows me to meet like-minded individuals who share my passions.",
                                                            "I'm a believer in the power of mutual connections. Often, I make new friends through introductions from existing friends or acquaintances.",
                                                            "Making new friends for me involves attending networking events, whether professional or social, where I can meet diverse groups of people.",
                                                            "I utilize online platforms, such as meetup groups or social apps, to connect with people who share similar hobbies or activities.",
                                                            "Being open to spontaneous interactions has helped me make new friends. Whether it's striking up a conversation in a coffee shop or at an event, I embrace opportunities to connect.",
                                                            "Taking classes or workshops is a great way for me to make new friends. Shared learning experiences provide a natural setting for building connections.",
                                                            "I engage in volunteer activities to meet new people. Doing something meaningful together fosters a sense of camaraderie and often leads to lasting friendships.",
                                                            "Attending social gatherings hosted by friends or colleagues is my approach to making new connections. Shared acquaintances create a comfortable environment.",
                                                            "Traveling is a unique way for me to make new friends. Whether it's meeting fellow travelers or connecting with locals, it often leads to memorable friendships."]),
                             SocialQuestionAnswers(index: 8,
                                                   answer: ["I appreciate authenticity in others during social activities. Genuine conversations and interactions make the experience more enjoyable.",
                                                            "Empathy is a quality I value during social activities. People who listen actively and show understanding contribute to a positive and inclusive atmosphere.",
                                                            "Humor is something I appreciate a lot. During social activities, laughter and lightheartedness create a vibrant and enjoyable environment.",
                                                            "Respect for diverse opinions and perspectives is a quality I highly value. It fosters open-mindedness and enriches the conversation during social interactions.",
                                                            "I appreciate people who are good listeners. Being able to engage in meaningful conversations and show genuine interest in others enhances the social experience.",
                                                            "Confidence is a quality I find admirable. It helps create a positive and energetic atmosphere during social activities.",
                                                            "I value individuals who are considerate of others' feelings. Thoughtfulness and kindness contribute to a harmonious social environment.",
                                                            "Open-mindedness is a quality that enhances social interactions for me. Embracing different perspectives and ideas enriches the overall experience.",
                                                            "I appreciate individuals who bring a sense of enthusiasm and positivity to social activities. Their energy is contagious and uplifts the mood of the group.",
                                                            "Reliability is a quality I look for during social activities. People who follow through on commitments and contribute to the group's dynamics positively impact the experience."]),
                             SocialQuestionAnswers(index: 9,
                                                   answer: ["The best social gathering, in my view, is one where there's a diverse group of people, fostering interesting conversations and connections.",
                                                            "I believe the best social gathering is characterized by a relaxed atmosphere, good food, and the presence of close friends or family.",
                                                            "For me, the best social gathering is one infused with positive energy, laughter, and shared activities that everyone can enjoy.",
                                                            "What makes the best social gathering is a combination of a welcoming environment, engaging activities, and a mix of familiar faces and new acquaintances.",
                                                            "In my view, the best social gathering involves a balance between planned activities and spontaneous interactions, creating a dynamic and enjoyable experience.",
                                                            "The best social gathering is one where everyone feels included, there's a sense of camaraderie, and people are free to express themselves without judgment.",
                                                            "I consider the best social gathering to be one with a theme or purpose that brings people together, fostering a sense of unity and shared enjoyment.",
                                                            "What makes a social gathering the best for me is when it provides an opportunity for both deep conversations and moments of lighthearted fun.",
                                                            "A well-planned social gathering with attention to detail, such as decorations and ambiance, contributes to creating the best atmosphere for socializing.",
                                                            "The best social gathering, in my opinion, is one where people are encouraged to be themselves, creating an environment of authenticity, warmth, and mutual enjoyment."])]
}

struct SocialQuestion: Identifiable {
    var id: Int = 0
    var question_en: String = ""
    var question_zh: String = ""
    var answer: String = ""
    
    init(index: Int, question_en: String, question_zh: String, answer: String) {
        self.id = index
        self.question_en = question_en
        self.question_zh = question_zh
        self.answer = answer
    }
}

struct SocialQuestionAnswers: Identifiable {
    var id: Int = 0
    var answer = [String]()
    
    init(index: Int, answer: [String] = [String]()) {
        self.id = index
        self.answer = answer
    }
}
