//
//  Question.swift
//  New Quiz Update
//
//  Created by Давид on 08/02/2019.
//  Copyright © 2019 Давид. All rights reserved.
//

struct Question {
    var text: String
    var type: ResponseType
    var answers: [Answer]
}

enum ResponseType {
    case single, multiple, ranged
}

struct Answer {
    var text: String
    var type: AnswerType
}

enum AnswerType: String {
    case solobolev = "sobolev", larin = "larin", hovansky = "hovansky", wylsa = "wylsa"
    
    var defenition: String {
        switch self {
        case .solobolev:
            return "Вы любите быть в центре внимания, не упускаете возможность похайпить на самых горячих новостях."
        case .larin:
            return "Вы любите своеобразные вещи которые могут понравиться не каждому. Любите отвечать на любые конфликты, провокации и споры, даже если они являются для вас невыигрыишными"
        case .hovansky:
            return "Любите жить в кайф, вас не волнует мнение других людей. Любите вступать в конфликты, прежде взвесив все за и против"
        case .wylsa:
            return "Вы прокаченный чел в сфере технологий, любите обозревать гаджеты и машины"
        }
    }
}
