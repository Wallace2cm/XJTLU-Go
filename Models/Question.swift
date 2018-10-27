 //
//  Question.swift
//  XJTLU
//
//  Created by Wallace Wu on 2018/4/27.
//  Copyright © 2018年 Wallace Wu. All rights reserved.
//

import Foundation

 class Question {
    let question : String
    let A : String
    let B : String
    let C : String
    let D : String
    let correctAnswer : Int
    
    init(questionText : String, choiceA : String, choiceB : String, choiceC : String, choiceD : String, answer : Int){
        question = questionText
        A = choiceA
        B = choiceB
        C = choiceC
        D = choiceD
        correctAnswer = answer
    }
 }
