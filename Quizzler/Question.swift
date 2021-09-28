//
//  Question.swift
//  Quizzler
//
//  Created by OnlyBei on 2021/8/7.
//  Copyright © 2021 rongcosme. All rights reserved.
//

import Foundation


class Question {
    let answer: Bool
    let questionText: String
    
    init(text: String, corretAnswer: Bool) {
        questionText = text
        answer = corretAnswer
    }
}
