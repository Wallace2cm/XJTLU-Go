//
//  Ranking.swift
//  XJTLU
//
//  Created by Wallace Wu on 2018/4/26.
//  Copyright © 2018年 Wallace Wu. All rights reserved.
//

import UIKit

class Ranking : UIViewController,BmobEventDelegate {
    
    var loginUser = BmobUser()
    var rival = BmobUser()
    var rowId = ""
    var waitingTableRowid = ""
    var quesTotalNumInt = 10
    var event = BmobEvent()
    var stateSecond = false
    
    @IBOutlet weak var user1lbl: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var QuestionsLbl: UILabel!
    @IBOutlet weak var questionCounter: UILabel!
    @IBOutlet weak var scorePotins: UILabel!
    @IBOutlet weak var A: UIButton!
    @IBOutlet weak var B: UIButton!
    @IBOutlet weak var C: UIButton!
    @IBOutlet weak var D: UIButton!
    @IBOutlet weak var user2lbl: UILabel!
    
    var stateReturn : Bool? {
        willSet {
            
            
        }
        didSet {
            self.execute()
            
            
        }
    }
    
    var seconds = 10
    var timer = Timer()
    var secondTimer = Timer()
    var thirdTimer = Timer()
    var point = 0
    var anotherSecond = 2
    var thirdSecond = 3
    var stateSameTime = false
    var stateAnswered = false
 
    
    var allQuestions = QuestionBank()
    var questionNumber = 0
    var score : Int = 0
    var rivalScore : Int = 0
    var selectedAnswer : Int = 0
    var progessView : VerticalProgressView!
    var anotherProgressView : VerticalProgressView!
    
    
   
    
    
    
    
    func execute() {
        if self.stateReturn == true {
            MBProgressHUD.hide(for: self.view, animated: true)
            let foundUser = MBProgressHUD.showAdded(to: self.view, animated: true)
            foundUser.mode = MBProgressHUDMode.customView
            foundUser.label.text = "Matched Successfully!"
            foundUser.hide(animated: true, afterDelay: 1)
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(1*NSEC_PER_SEC))/Double(NSEC_PER_SEC)) {
                let willStart = MBProgressHUD.showAdded(to: self.view, animated: true)
                willStart.mode = MBProgressHUDMode.customView
                willStart.label.text = "Game will start in"
                willStart.hide(animated: true, afterDelay: 1)
            }
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(2*NSEC_PER_SEC))/Double(NSEC_PER_SEC)) {
                let twoSec = MBProgressHUD.showAdded(to: self.view, animated: true)
                twoSec.mode = MBProgressHUDMode.customView
                twoSec.label.text = "3"
                twoSec.hide(animated: true, afterDelay: 1)
            }
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(3*NSEC_PER_SEC))/Double(NSEC_PER_SEC)) {
                let thirdSec = MBProgressHUD.showAdded(to: self.view, animated: true)
                thirdSec.mode = MBProgressHUDMode.customView
                thirdSec.label.text = "2"
                thirdSec.hide(animated: true, afterDelay: 1)
            }
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(4*NSEC_PER_SEC))/Double(NSEC_PER_SEC)) {
                let oneSec = MBProgressHUD.showAdded(to: self.view, animated: true)
                oneSec.mode = MBProgressHUDMode.customView
                oneSec.label.text = "1"
                oneSec.hide(animated: true, afterDelay: 1)
            }
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(5*NSEC_PER_SEC))/Double(NSEC_PER_SEC)) {
                self.scorePotins.text = String(self.score)
                super.viewDidLoad()
                self.updateQuestion()
                self.updateUI()
                self.user2lbl.isHidden = false
                self.user2lbl.text = self.rival.username
                self.user1lbl.text = self.loginUser.username
                print(self.user2lbl.text)
                
                
                
                
            }
        }
        
    }
    
    
    func startMatching() {
        let match = MBProgressHUD.showAdded(to: self.view, animated: true)
        match.label.text = "Matching..."
        match.button.setTitle("Cancel", for: .normal)
        match.button.addTarget(self, action: #selector(self.quitMatching), for: .touchUpInside)
        rankingProgress()
        
        
    }
    
    
    override func viewDidLoad() {
        self.navigationItem.hidesBackButton = true
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "exit.png"), style: .plain, target: self, action: #selector(handleBackToDashboard))
        
        startMatching()
        
        progessView = VerticalProgressView(frame: CGRect(x: 0, y: 250, width: 15, height: 200))
        progessView.center.x = view.center.x - 160
        view.addSubview(progessView)
        anotherProgressView = VerticalProgressView(frame: CGRect(x: 0, y: 250, width: 15, height: 200))
        anotherProgressView.center.x = view.center.x + 160
        view.addSubview(anotherProgressView)
        
        A.backgroundColor = UIColor.orange.withAlphaComponent(0.5)
        B.backgroundColor = UIColor.orange.withAlphaComponent(0.5)
        C.backgroundColor = UIColor.orange.withAlphaComponent(0.5)
        D.backgroundColor = UIColor.orange.withAlphaComponent(0.5)
    }
    
    @objc func handleBackToDashboard() {
        let warning = UIAlertController(title: "Warning", message: "Are you sure to leave game because you will derank to do so", preferredStyle: .alert)
        let stay = UIAlertAction(title: "Stay", style: .default, handler: {action in self.stay()})
        let quit = UIAlertAction(title: "Quit", style: .default, handler: {action in self.quit()})
        warning.addAction(stay)
        warning.addAction(quit)
        present(warning,animated: true, completion: nil)
        
    }
    
    func stay() {
        
    }
    func quit() {
        self.navigationController?.popViewController(animated: true)
        let gamescore:BmobObject = BmobObject(outDataWithClassName: "waitingTable", objectId: self.waitingTableRowid)
        gamescore.deleteInBackground { (isSuccessful, error) in
            if (isSuccessful) {
                print ("success delete waiting table");
            }else{
                print("delete error \(error?.localizedDescription)")
            }
        }
        
    }
    
    
    
    
    @objc func quitMatching() {
        self.navigationController?.popViewController(animated: true)
        let gamescore:BmobObject = BmobObject(outDataWithClassName: "waitingTable", objectId: self.waitingTableRowid)
        gamescore.deleteInBackground { (isSuccessful, error) in
            if (isSuccessful) {
                print ("success delete waiting table");
            }else{
                print("delete error \(error?.localizedDescription)")
            }
        }
    }
    
    
    
    
    func rankingProgress() {
        self.event = BmobEvent.default()
        self.event?.delegate = self
        self.event?.start()
        
        self.loginUser = BmobUser.current()
        
        let query:BmobQuery = BmobQuery(className: "waitingTable")
        
        // if he/she is the second player
        query.findObjectsInBackground{ (array, error) in
            if array!.count>0{
                for i in 0..<array!.count{
                    let obj = array![i] as! BmobObject
                    let userId = obj.object(forKey: "userId") as? String
                    self.rowId = obj.object(forKey: "rowObjectId") as! String
                    print("userId =  \(String(describing: userId))")
                    print("rowObjectId = \(String(describing: self.rowId ))")
                    let gamescore:BmobObject = BmobObject(outDataWithClassName: "waitingTable", objectId: obj.objectId)
                    gamescore.deleteInBackground { (isSuccessful, error) in
                        if (isSuccessful) {
                            // delete unmatched information
                            print ("successful delete");
                            let update:BmobObject = BmobObject(outDataWithClassName: "conversation", objectId: self.rowId)
                            update.setObject(self.loginUser.objectId, forKey: "user2")
                            update.setObject(self.loginUser.username, forKey: "user2Name")
                            update.setObject(false, forKey: "didInitState")
                            update.setObject(false, forKey: "answerState")
                            let countQuery = BmobQuery()
                            let bql = "select count(*) from QuestionBank"
                            countQuery!.queryInBackground(withBQL: bql, block: { (result, error) in
                                if error != nil{
                                    print("counting question bank error")
                                }else{
                                    let totalNumInt = result!.count + 1
                                    var resultArray : [Int] = []
                                    if totalNumInt < self.quesTotalNumInt{
                                        resultArray = data.getRamdomArray(totalNumInt, total: totalNumInt) as! [Int]
                                    }else{
                                        resultArray = data.getRamdomArray(Int32(self.quesTotalNumInt), total: totalNumInt) as! [Int]
                                    }
                                    print("searched question total number " , resultArray)
                                    update.setObject(resultArray, forKey:"questionIndex")
                                    update.updateInBackground(resultBlock: { (isSuccessful, error) in
                                        if isSuccessful {
                                            let da = data()
                                            da.getQuestionsByIndex(resultArray, bankName: "QuestionBank")
                                            var getArray : [BmobObject] = []
                                            var returnArray : [BmobObject] = []
                                            //get question index
                                            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(2*NSEC_PER_SEC))/Double(NSEC_PER_SEC)) {
                                                getArray = da.returnArr as! [BmobObject]
                                                for index in resultArray{
                                                    for obj in getArray{
                                                        if index == obj.object(forKey: "num") as! Int{
                                                            returnArray.append(obj)
                                                        }
                                                    }
                                                }
                                                self.allQuestions.add(array: returnArray)
                                            }
                                            print("update successfully");
                                            self.event?.listenRowChange(BmobActionTypeUpdateRow, tableName: "conversation", objectId: self.rowId)
                                        }else{
                                            print("update error is \(String(describing: error?.localizedDescription))")
                                        }
                                    })
                                }
                            })
                        }else{
                            print("delete error \(String(describing: error?.localizedDescription))")
                        }
                    }
                }
            }else{
                // if he / she is the first player
                print("no result!")
                let conversation:BmobObject = BmobObject(className: "conversation")
                conversation.setObject(self.loginUser.objectId, forKey: "user1")
                conversation.setObject(self.loginUser.username, forKey: "user1Name")
                conversation.setObject(false, forKey: "didInitState")
                conversation.setObject(false, forKey: "answerState")
                for i in 1...10{
                    let optionN = String(format: "option%i",i)
                    conversation.setObject(0, forKey: optionN)
                }
                conversation.saveInBackground(resultBlock: { (isSuccessful, error) in
                    if isSuccessful {  // update conversation
                        print("update conversation successfully");
                        self.rowId = conversation.objectId;
                        self.event?.listenRowChange(BmobActionTypeUpdateRow, tableName: "conversation", objectId: self.rowId)
                        let update:BmobObject = BmobObject(className: "waitingTable")
                        update.setObject(self.loginUser.objectId, forKey: "userId")
                        update.setObject(self.rowId, forKey: "rowObjectId")
                        update.saveInBackground(resultBlock: { (isSuccessful, error) in
                            if isSuccessful {
                                print("successful add to waiting table");
                            }else{
                                print("update error is \(String(describing: error?.localizedDescription))")
                            }
                        })
                    }else{
                        print("update error is \(String(describing: error?.localizedDescription))")
                    }
                })
            }
        }
        
    }
    
    func bmobEvent(_ event: BmobEvent!, didReceiveMessage message: String!) {
        print("get")
        var didInitState = false
        var answerState = false
        var questionIndex : [Int] = []
        var getArray : [BmobObject] = []
        var returnArray : [BmobObject] = []
        
        let jsonData:Data = message.data(using: .utf8)!
        var dict = NSDictionary()
        dict = try! JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers) as! NSDictionary
        
        //search for state,  json for first dict
        //answers is in sub dict
        let subdict = dict["data"] as? NSDictionary
        for (key, value) in subdict!{
            if key as! String  == "didInitState"{
                didInitState = value as! Bool
            }
            if key as! String  == "answerState"{
                answerState = value as! Bool
            }
            if key as! String  == "questionIndex"{
                questionIndex = value as! [Int]
            }
        }
        if didInitState == true && answerState == true{
            //for getting answers
            var state = false   //to find which is current option
            var stateState = false
            var answer: NSNumber = 0
            
            if subdict?.object(forKey: "user1") as! String == self.loginUser.objectId as String{
                self.rival.objectId = subdict?.object(forKey: "user2") as! String
                self.rival.username = subdict?.object(forKey: "user2Name") as! String
                //user2lbl.text = self.rival.username

            }
            if subdict?.object(forKey: "user2") as! String == self.loginUser.objectId as String{
                self.rival.objectId = subdict?.object(forKey: "user1") as! String
                self.rival.username = subdict?.object(forKey: "user1Name") as! String
                //user2lbl.text = self.rival.username

            }
            if (self.rival.objectId != nil) && ((subdict?.object(forKey: self.rival.objectId)) != nil){
                rivalScore =  subdict?.object(forKey: self.rival.objectId) as! Int
                print("get rival score")
            }
            
            for i in 1...10{
                let optionN = String(format: "option%i",i)
                if subdict?.object(forKey: optionN) as! NSNumber == 0{
                    if i == 1{
                        let optionTemp = String(format: "option%i",1)
                        answer = subdict?.object(forKey: optionTemp) as! NSNumber
                    }else{
                        let optionTemp = String(format: "option%i",i-1)
                        answer = subdict?.object(forKey: optionTemp) as! NSNumber
                    }
                    if state == false{
                        if stateSameTime == false{  //stateSameTime is for correct answer
                            if answer == selectedAnswer as NSNumber{
                                if self.loginUser.objectId as NSString == subdict?.object(forKey: "current") as! NSString{
                                   
                                }else{
                                    self.showCorrectAnswers()
                                    self.disableButton()
                                
                                }
                                stateState = true
                                stateSameTime = true
                            }else{
                                //wrong answer
                                if self.loginUser.objectId as NSString == subdict?.object(forKey: "current") as! NSString{
                                    //self answer wrong
                                    if stateAnswered == true{
                                        //self.updateQuestion()
                                        self.showCorrectAnswers()
                                        print("展示了answers")
                                    }else{
                                    }
                                    stateAnswered = true  //stateAnswer for the times two user answer wrong
                                }else{
                                    //rival answer wrong
                                    if stateAnswered == true{
                                        //self.updateQuestion()
                                        self.showCorrectAnswers()
                                        print("展示了answers")
                                    }else{
                                    }
                                    stateAnswered = true  //stateAnswer for the times two user answer wrong
                                }
                               // situation when user answer incorrect quesiton
                            }
                        }
                        state = true
                    }
                    else{
                        
                    }
                }
            }
            print("get answer from rival")
            
        }else{
            if didInitState == false && answerState == false{
                //get questions + change state to true
                let da = data()
                //get rival information
                if subdict?.object(forKey: "user1") as! String == self.loginUser.objectId as String{
                    self.rival.objectId = subdict?.object(forKey: "user2") as! String
                    self.rival.username = subdict?.object(forKey: "user2Name") as! String
                    //user2lbl.text = self.rival.username
                }
                if subdict?.object(forKey: "user2") as! String == self.loginUser.objectId as String{
                    self.rival.objectId = subdict?.object(forKey: "user1") as! String
                    self.rival.username = subdict?.object(forKey: "user1Name") as! String
                    //user2lbl.text = self.rival.username
                }
                
                da.getQuestionsByIndex(questionIndex, bankName: "QuestionBank")
                let update:BmobObject = BmobObject(outDataWithClassName: "conversation", objectId: self.rowId)
                update.setObject(true, forKey: "didInitState")
                update.updateInBackground(resultBlock: { (isSuccessful, error) in
                    if isSuccessful {
                        print("changed didInitState to true");
                        //this is for not gettting a nil object , improve robustness
                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(1*NSEC_PER_SEC))/Double(NSEC_PER_SEC)) {
                            getArray = da.returnArr as! [BmobObject]
                            for index in questionIndex{
                                for obj in getArray{
                                    if index == obj.object(forKey: "num") as! Int{
                                        returnArray.append(obj)
                                    }
                                }
                            }
                            self.allQuestions.add(array: returnArray)
                        }
                    }else{
                        print("update error is \(String(describing: error?.localizedDescription))")
                    }
                })
            }else{
                // always update rival information as quick as it can
                if subdict?.object(forKey: "user1") as! String == self.loginUser.objectId as String{
                    self.rival.objectId = subdict?.object(forKey: "user2") as! String
                    self.rival.username = subdict?.object(forKey: "user2Name") as! String
                    //user2lbl.text = self.rival.username
                    
                }
                if subdict?.object(forKey: "user2") as! String == self.loginUser.objectId as String{
                    self.rival.objectId = subdict?.object(forKey: "user1") as! String
                    self.rival.username = subdict?.object(forKey: "user1Name") as! String
                    //user2lbl.text = self.rival.username
                    
                }
                print("I should be User2 and now user1 got the question bank")
                self.stateReturn = true
            }
        }
    }
    
    //called when user click button
    func answerfunc(option:NSNumber, index: Int){
        let update:BmobObject = BmobObject(outDataWithClassName: "conversation", objectId: self.rowId)
        let optionN = String(format: "option%i",index)
        update.setObject(option, forKey: optionN)
        update.setObject(true, forKey: "answerState")
        update.setObject(self.loginUser.objectId, forKey: "current")
//        update.setObject(score, forKey: String(self.loginUser.objectId.description))
        update.updateInBackground(resultBlock: { (isSuccessful, error) in
            if isSuccessful {
                print("option updated");
            }else{
                print("update error is \(String(describing: error?.localizedDescription))")
            }
        })
    }
    
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.progessView.setProgress(progress: 0.05, animated: true)
        self.anotherProgressView.setProgress(progress: 0.5, animated: true)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func gamestart() {
        thirdTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(gameCountDown), userInfo: nil, repeats: true)
    }
    
    func gamePause() {
        thirdTimer.invalidate()
    }
    
    @objc func gameCountDown() {
        thirdSecond = 3
        if thirdSecond == 0 {
            self.gamePause()
        }else {
            thirdSecond -= 1
            
        }
    }
    
    
    func start(){
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(counter), userInfo: nil, repeats: true)
    }
    
    
    @objc func counter() {
        anotherSecond = 2
        if (seconds == 0){
            self.pause()
            answerfunc(option: 5, index: questionNumber)
        }
            
        else{
            seconds -= 1
            time.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 6, options: .allowUserInteraction, animations: {
                self.time.transform = CGAffineTransform.identity
                
            }, completion: nil)
            time.text = String(seconds)
            
        }
    }
    func showCorrectAnswers() {
        print("show")
        secondTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
    }
    
    
    @objc func countDown(){
        if anotherSecond == 0{
            self.anotherPause()
            updateQuestion()
        }
        else {
            self.pause()
            anotherSecond -= 1
            cottectAns()
        }
    }
    func anotherPause() {
        secondTimer.invalidate()
    }
    
    
    public func pause(){
        timer.invalidate()
    }
    
    public func caculatePoints() {
        switch seconds {
        case 9:
            score += 100
            progessView.progress += 0.045
        case 8 :
            score += 90
            progessView.progress += 0.04
        case 7 :
            score += 80
            progessView.progress += 0.035
        case 6 :
            score += 70
            progessView.progress += 0.03
        case 5 :
            score += 60
            progessView.progress += 0.025
        case 4 :
            score += 50
            progessView.progress += 0.02
        case 3 :
            score += 40
            progessView.progress += 0.015
        case 2 :
            score += 30
            progessView.progress += 0.01
        case 1 :
            score += 20
            progessView.progress += 0.005
        case 0 :
            score += 10
            
        default:
            break
            
        }
    }
    
    
    func cottectAns() {
        if A.tag == selectedAnswer{
            self.A.isEnabled = false
            self.B.isEnabled = false
            self.C.isEnabled = false
            self.D.isEnabled = false
            UIView.animate(withDuration: 0.5, delay: 0.5, usingSpringWithDamping: 0.5, initialSpringVelocity: 6, options: .allowUserInteraction, animations: {
                self.A.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
                self.A.backgroundColor = UIColor.green.withAlphaComponent(0.5)
                
                
            }, completion: nil)
            
        }else if B.tag == selectedAnswer {
      
            self.A.isEnabled = false
            self.B.isEnabled = false
            self.C.isEnabled = false
            self.D.isEnabled = false
            UIView.animate(withDuration: 0.5, delay: 0.5, usingSpringWithDamping: 0.5, initialSpringVelocity: 6, options: .allowUserInteraction, animations: {
                self.B.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
                self.B.backgroundColor = UIColor.green.withAlphaComponent(0.5)
                
                
            }, completion: nil)
            
        }else if C.tag == selectedAnswer {
        
            self.A.isEnabled = false
            self.B.isEnabled = false
            self.C.isEnabled = false
            self.D.isEnabled = false
            UIView.animate(withDuration: 0.5, delay: 0.5, usingSpringWithDamping: 0.5, initialSpringVelocity: 6, options: .allowUserInteraction, animations: {
                self.C.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
                self.C.backgroundColor = UIColor.green.withAlphaComponent(0.5)
                
            }, completion: nil)
            
        }else if D.tag == selectedAnswer {
            self.A.isEnabled = false
            self.B.isEnabled = false
            self.C.isEnabled = false
            self.D.isEnabled = false
            UIView.animate(withDuration: 0.5, delay: 0.5, usingSpringWithDamping: 0.5, initialSpringVelocity: 6, options: .allowUserInteraction, animations: {
                self.D.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
                self.D.backgroundColor = UIColor.green.withAlphaComponent(0.5)
                
            }, completion: nil)
            
        }
        
    }
    func disableButton(){
        self.A.isEnabled = false
        self.B.isEnabled = false
        self.C.isEnabled = false
        self.D.isEnabled = false
    }
    
    @IBAction func optionTapped(_ sender: UIButton) {
        if  sender.tag == selectedAnswer {
            self.A.isEnabled = false
            self.B.isEnabled = false
            self.C.isEnabled = false
            self.D.isEnabled = false
            showCorrectAnswers()
            caculatePoints()
            score += 100
            scorePotins.text = String(score)
            self.pause()
            progessView.progress += 0.05
            answerfunc(option: selectedAnswer as NSNumber, index: questionNumber)
            print (score)
            print ("Correct")
        }else {
            self.A.isEnabled = false
            self.B.isEnabled = false
            self.C.isEnabled = false
            self.D.isEnabled = false
            UIView.animate(withDuration: 0.1, animations: {
                sender.backgroundColor = UIColor.red.withAlphaComponent(0.5)
            },completion: { _ in
                sender.backgroundColor = UIColor.red.withAlphaComponent(0.5)
            })
            answerfunc(option: sender.tag as NSNumber, index: questionNumber)
            self.pause()
            //showCorrectAnswers()
            print ("Wrong")
        }
        anotherSecond = 2
    }
    
    func updateQuestion() {
        
        if questionNumber < allQuestions.list.count {
            start()
            QuestionsLbl.text = allQuestions.list[questionNumber].question
            A.setTitle(allQuestions.list[questionNumber].A, for: .normal)
            B.setTitle(allQuestions.list[questionNumber].B, for: .normal)
            C.setTitle(allQuestions.list[questionNumber].C, for: .normal)
            D.setTitle(allQuestions.list[questionNumber].D, for: .normal)
            selectedAnswer = allQuestions.list[questionNumber].correctAnswer
            questionNumber += 1
            stateSameTime = false
            stateAnswered = false
            A.backgroundColor = UIColor.orange.withAlphaComponent(0.5)
            B.backgroundColor = UIColor.orange.withAlphaComponent(0.5)
            C.backgroundColor = UIColor.orange.withAlphaComponent(0.5)
            D.backgroundColor = UIColor.orange.withAlphaComponent(0.5)
            A.transform = CGAffineTransform.identity
            B.transform = CGAffineTransform.identity
            C.transform = CGAffineTransform.identity
            D.transform = CGAffineTransform.identity
            A.isEnabled = true
            B.isEnabled = true
            C.isEnabled = true
            D.isEnabled = true
            
        }else {
            let alert = UIAlertController(title: "Awesome!", message: "End of the Game", preferredStyle: .alert)
            let onceagain = UIAlertAction(title: "Continue", style: .default, handler: {action in self.restartQuiz()})
            let backToDashboard = UIAlertAction(title: "Back", style: .default, handler: {action in self.goBack()})
            alert.addAction(backToDashboard)
            alert.addAction(onceagain)
            present(alert,animated: true, completion: nil)
            timer.invalidate()
        }
        updateUI()
        seconds = 10
        time.text = String(seconds)
    }
    func updateUI() {
        
        questionCounter.text = "\(questionNumber )/\(allQuestions.list.count)"
        
    }
    func restartQuiz() {
        startMatching()
        score = 0
        scorePotins.text = String(0)
        questionNumber = 0
        allQuestions.list.removeAll()
        self.progessView.setProgress(progress: 0.05, animated: true)
        let conversationrestart:BmobObject = BmobObject(outDataWithClassName: "conversation", objectId: self.rowId)
        conversationrestart.deleteInBackground { (isSuccessful, error) in
            if (isSuccessful) {
                print ("success delete conversation table");
            }else{
                print("delete error \(String(describing: error?.localizedDescription))")
            }
        }
        
    }
    func goBack() {
        self.navigationController?.popViewController(animated: true)
        let conversationrestart:BmobObject = BmobObject(outDataWithClassName: "conversation", objectId: self.rowId)
        conversationrestart.deleteInBackground { (isSuccessful, error) in
            if (isSuccessful) {
                print ("success delete conversation table");
            }else{
                print("delete error \(String(describing: error?.localizedDescription))")
            }
        }
    }
    
    
    
    
}
