//
//  questionBank.swift
//  XJTLU
//
//  Created by Wallace Wu on 2018/5/5.
//  Copyright © 2018年 Wallace Wu. All rights reserved.
//

import UIKit

class qBank : UIViewController {
    
    @IBOutlet weak var darkFill: UpButtonView!
    @IBOutlet weak var toggleButton: UIButton!
    @IBOutlet weak var menuView: UIView!
    var praticeQuestions = QuestionBank()
    var numberOfQuestions = 0
    var correctAns = 0
    var practicing = Ranking()
    @IBOutlet weak var previous: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    override func viewDidLoad() {
        let waitingForQuestion = MBProgressHUD.showAdded(to: self.view, animated: true)
        waitingForQuestion.label.text = "Accessing to Databse..."
        getQuestions()
        self.navigationItem.hidesBackButton = true
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "exit.png"), style: .plain, target: self, action: #selector(handleBack))
        super.viewDidLoad()
        A.backgroundColor = UIColor.orange.withAlphaComponent(0.5)
        B.backgroundColor = UIColor.orange.withAlphaComponent(0.5)
        C.backgroundColor = UIColor.orange.withAlphaComponent(0.5)
        D.backgroundColor = UIColor.orange.withAlphaComponent(0.5)
        
    }
    
    @objc func handleBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func toggleButtonTapped(_ sender: UIButton) {
        if darkFill.transform == CGAffineTransform.identity {
            
            UIView.animate(withDuration: 0.5, animations: {
                self.darkFill.transform = CGAffineTransform(scaleX: 12, y: 12)
                self.menuView.transform = CGAffineTransform(translationX: 0, y: -60)
                self.toggleButton.transform = CGAffineTransform(rotationAngle: 180 * .pi / 180)
            }) { (true) in
                
            }
        }else {
            UIView.animate(withDuration: 0.5, animations: {
                self.darkFill.transform = .identity
                self.menuView.transform = .identity
                self.toggleButton.transform = .identity
            }) { (true) in
                
            }
        }
    }
    
    @IBOutlet weak var heart: UIButton!
    @IBOutlet weak var trash: UIButton!
    @IBOutlet weak var questionlbl: UILabel!
    @IBOutlet weak var A: ButtonCustomer!
    @IBOutlet weak var B: ButtonCustomer!
    @IBOutlet weak var C: ButtonCustomer!
    @IBOutlet weak var D: ButtonCustomer!
    
    @IBAction func nextTapped(_ sender: UIButton) {
        updatePracticeQuestions()
    }
    
    @IBAction func previousTapped(_ sender: UIButton) {
        
       previousQuestion()
       print("?")
        
    }

    
    @IBAction func choiceTapped(_ sender: UIButton) {
        
        
        if sender.tag == correctAns {
            A.isEnabled = false
            B.isEnabled = false
            C.isEnabled = false
            D.isEnabled = false
            showCorrectAnswers()
            UIView.animate(withDuration: 0.1, animations: {
                sender.backgroundColor = UIColor.green.withAlphaComponent(0.5)
            },completion: { _ in
                sender.backgroundColor = UIColor.green.withAlphaComponent(0.5)
            })
        }else {
            A.isEnabled = false
            B.isEnabled = false
            C.isEnabled = false
            D.isEnabled = false
            UIView.animate(withDuration: 0.1, animations: {
                sender.backgroundColor = UIColor.red.withAlphaComponent(0.5)
            },completion: { _ in
                sender.backgroundColor = UIColor.red.withAlphaComponent(0.5)
            })
            showCorrectAnswers()
        }
        
    }
    
    var stateOfGetting : Bool? {
        willSet {
            
        }
        didSet {
            MBProgressHUD.hide(for: self.view, animated: true)
            self.updatePracticeQuestions()
        }
        
    }
  
   
    func getQuestions() {
        let obtainAllQuestion = data()
        obtainAllQuestion.getAllQustions("QuestionBank")
        
         DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(4*NSEC_PER_SEC))/Double(NSEC_PER_SEC)) {
             print(obtainAllQuestion.returnValueAll)
             self.praticeQuestions.add(array: obtainAllQuestion.returnValueAll as! [BmobObject])
             self.stateOfGetting = true
            }

            
           
        }
       
  
    func showCorrectAnswers() {
        if A.tag == correctAns{
            
            UIView.animate(withDuration: 0.5, delay: 0.5, usingSpringWithDamping: 0.5, initialSpringVelocity: 6, options: .allowUserInteraction, animations: {
                self.A.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
                self.A.backgroundColor = UIColor.green.withAlphaComponent(0.5)
            }, completion: nil)
        }else if B.tag == correctAns {
            
            UIView.animate(withDuration: 0.5, delay: 0.5, usingSpringWithDamping: 0.5, initialSpringVelocity: 6, options: .allowUserInteraction, animations: {
                self.B.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
                self.B.backgroundColor = UIColor.green.withAlphaComponent(0.5)
            }, completion: nil)
            
        }else if C.tag == correctAns {
           
            UIView.animate(withDuration: 0.5, delay: 0.5, usingSpringWithDamping: 0.5, initialSpringVelocity: 6, options: .allowUserInteraction, animations: {
                self.C.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
                self.C.backgroundColor = UIColor.green.withAlphaComponent(0.5)
            }, completion: nil)
        }else if D.tag == correctAns {
            
            UIView.animate(withDuration: 0.5, delay: 0.5, usingSpringWithDamping: 0.5, initialSpringVelocity: 6, options: .allowUserInteraction, animations: {
                self.D.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
                self.D.backgroundColor = UIColor.green.withAlphaComponent(0.5)
            }, completion: nil)
        }
    }
    
   var questionList = [Question]()
    
    @IBAction func heartTapped(_ sender: UIButton) { 
        sender.setImage(UIImage(named: "redheart.png")!, for: .normal)
        
        questionList.append(Question(questionText: praticeQuestions.list[numberOfQuestions].question, choiceA: praticeQuestions.list[numberOfQuestions].A, choiceB: praticeQuestions.list[numberOfQuestions].B, choiceC: praticeQuestions.list[numberOfQuestions].C, choiceD: praticeQuestions.list[numberOfQuestions].D, answer: praticeQuestions.list[numberOfQuestions].correctAnswer))
        print(questionList)
    }
    
    @IBOutlet weak var trashButton: UIButton!
    
    @IBAction func trashButtonTapped(_ sender: UIButton) {
        heart.setImage(UIImage(named : "heart.png")!, for: .normal)
        questionList.removeAll()

    }
    
    func updatePracticeQuestions() {
        print(numberOfQuestions)
        if numberOfQuestions < praticeQuestions.list.count   {
            A.isEnabled = true
            B.isEnabled = true
            C.isEnabled = true
            D.isEnabled = true
            questionlbl.text = praticeQuestions.list[numberOfQuestions].question
            A.setTitle(praticeQuestions.list[numberOfQuestions].A, for: .normal)
            B.setTitle(praticeQuestions.list[numberOfQuestions].B, for: .normal)
            C.setTitle(praticeQuestions.list[numberOfQuestions].C, for: .normal)
            D.setTitle(praticeQuestions.list[numberOfQuestions].D, for: .normal)
            correctAns = praticeQuestions.list[numberOfQuestions].correctAnswer
            numberOfQuestions += 1
            A.backgroundColor = UIColor.orange.withAlphaComponent(0.5)
            B.backgroundColor = UIColor.orange.withAlphaComponent(0.5)
            C.backgroundColor = UIColor.orange.withAlphaComponent(0.5)
            D.backgroundColor = UIColor.orange.withAlphaComponent(0.5)
            A.transform = CGAffineTransform.identity
            B.transform = CGAffineTransform.identity
            C.transform = CGAffineTransform.identity
            D.transform = CGAffineTransform.identity
        }
        else {
            let lastQuestion = MBProgressHUD.showAdded(to: self.view, animated: true)
            lastQuestion.mode = MBProgressHUDMode.customView
            lastQuestion.label.text = "This is the last question!"
            lastQuestion.hide(animated: true, afterDelay: 1)
            
        }
    }
    
    
    func previousQuestion() {
    
        if numberOfQuestions > 0 {
            numberOfQuestions -= 1
            questionlbl.text = praticeQuestions.list[numberOfQuestions].question
            A.setTitle(praticeQuestions.list[numberOfQuestions].A, for: .normal)
            B.setTitle(praticeQuestions.list[numberOfQuestions].B, for: .normal)
            C.setTitle(praticeQuestions.list[numberOfQuestions].C, for: .normal)
            D.setTitle(praticeQuestions.list[numberOfQuestions].D, for: .normal)
            correctAns = praticeQuestions.list[numberOfQuestions].correctAnswer
            A.backgroundColor = UIColor.orange.withAlphaComponent(0.5)
            B.backgroundColor = UIColor.orange.withAlphaComponent(0.5)
            C.backgroundColor = UIColor.orange.withAlphaComponent(0.5)
            D.backgroundColor = UIColor.orange.withAlphaComponent(0.5)
            A.transform = CGAffineTransform.identity
            B.transform = CGAffineTransform.identity
            C.transform = CGAffineTransform.identity
            D.transform = CGAffineTransform.identity
        }else{
            let firstQuestion = MBProgressHUD.showAdded(to: self.view, animated: true)
            firstQuestion.mode = MBProgressHUDMode.customView
            firstQuestion.label.text = "This is the first question!"
            firstQuestion.hide(animated: true, afterDelay: 1)
            
        }
 
    }
    
    
}
