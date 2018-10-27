//
//  QuestionBank.swift
//  XJTLU
//
//  Created by Wallace Wu on 2018/4/27.
//  Copyright © 2018年 Wallace Wu. All rights reserved.
//

import Foundation

class QuestionBank {
    var list = [Question]()
    
    init(){
//        list.append(Question(questionText: "What's my name", choiceA: "askjdh", choiceB: "asd", choiceC: "shit", choiceD: "lkjlkj", answer: 3))
//        list.append(Question(questionText: "dssfdf", choiceA: "af", choiceB: "asd", choiceC: "shit", choiceD: "fd", answer: 2))
//        list.append(Question(questionText: "alkjsdfh", choiceA: "f", choiceB: "afsd", choiceC: "shit", choiceD: "asd", answer: 1))
//        list.append(Question(questionText: "alkdsjfh", choiceA: "d", choiceB: "asd", choiceC: "shit", choiceD: "asd", answer: 4))
//
    
   }
    func add(array: [BmobObject]){
        for obj in array {
            list.append(Question(questionText: obj.object(forKey: "title") as! String,
                                 choiceA: obj.object(forKey: "optionA") as! String,
                                 choiceB: obj.object(forKey: "optionB") as! String,
                                 choiceC: obj.object(forKey: "optionC") as! String,
                                 choiceD: obj.object(forKey: "optionD") as! String,
                                 answer: obj.object(forKey: "answer") as! Int))
        }
    }
}
