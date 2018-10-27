# XJTLU-Go
XJTLU Go is a IOS Quiz App which is designed only for students in Xi'an Jiaotong-Liverpool University. It is an multiplayer online app which aims to help students improve the efficiency of reviewing.
## Contribution
This ios app is completed by a group of 7 members. The development part is done by Jinlong Hong and Pinyi Wu which is me - [Wallace2cm](https://github.com/Wallace2cm). Jinlong Hong is resopnsible for the back-end development by using Objective-C and Swift. I am responbile for the front-end code by using Swift. Wenya Ma is in charge of UI design and it is confirmed that all the background images are created originally from her. Jiaxing Li mainly worked on the presenation and report. Other members who are Ning Luo, Caiming Pang and Tai Chen have participated into work such as but not limited to Testing, Evaluation, Data collection, code improvements and system design.
## Program Introduction
XJTLU GO is an IOS application software which contributes to simplify Xi’an Jiaotong-Liverpool University (XJTLU) students’ reviewing process. Compared with traditional learning software, this application could stimulate users’ learning enthusiasm by transforming the process of memorizing knowledge concept into competing with opponents. More specifically, it is to provide a real time competition platform for two-users with the same series of questions in the same limited time. At the first period of the software development, the subjects named Chinese Cultural, taken by all of XJTLU Chinese freshman as an obligatory course, is the target object of this application. During the progress of market investigation, development team adjusts software database to satisfy users’ requirements on multi-subject.
## Functions
### Login & Sign in
As regard to “Login” and “Sign in”, the users who are the first time to use the XJTLU Go are required to register with XJTLU student account. Only the name is needed when signing up because the suffix of the mailbox is added automatically by “student.xjtlu.edu.cn” when sending request to the database. Without access to the XJTLU school database, confirmation emails will be sent to users to ensure that the operations are conducted by themselves. “Invalid Input” will display if the account was registered before and issues of Internet connection. After the registration, a segue will be performed to the Login interface to ask user to type the account and password. When the data is verified by the database, the segue “loginSuccessful” will perform to lead users to the dashboard. Otherwise, the HUD will be displayed to inform the users with wrong information according to names or passwords.


![image](https://github.com/Wallace2cm/XJTLU-Go/blob/master/Screenshot/login.jpg)

###Ranking
In the interface of dashboard, there are three functions for users to choose. At the bottom of the page lies the tab bar, the two icons, represented by the images of house and portrait, will be highlighted by black when tapped and show the different pages which are “Dashboard” and “Account” respectively. When tapping the button of “Ranking”, the request for matching will be sent to database to look for competitor. A HUD - “Matching…” will be displayed during that period until the competitor is found. There is a cancel button under the label “Matching…” which allows the users to quit matching.


![image](https://github.com/Wallace2cm/XJTLU-Go/blob/master/Screenshot/Dashboard.jpg)

After the competitor is found, there will be 3 seconds to count down before the start of the quiz. The names of user himself/herself and the competitor will be displayed on the top left corner and top right corner, respectively. For each question, both users only have 10 seconds to answers the questions otherwise the correct will be highlighted by green and the next question will be updated.

The countdown of 10 seconds will be highlighted by each second to inform users
      
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
    
    
There are several situations of answering question. First, if user1 answer the question correctly ahead of user2 then user2 will have no chance to answer the question. The four buttons will be disabled and the correct answer will be highlighted immediately. Second, if user1 answer the question incorrectly ahead of user2 then user2 will have the chance to answer the question. Whether user2 answer the question correctly or incorrectly, both interfaces of user1 and user2 will show correct answers. Third, if ueser1 and user2 do not answer the question in 10 seconds, the correct answer will be highlighted.

The 10 questions are randomly selected by the database and stored temporarily in the Question array. The type of questions and choices is string but the type of the correct answers is integer because the tag of choice A, B, C, D are 1, 2 ,3 ,4, respectively. To update the questions:

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
    
    
## Backend Implementation
### Comparisions between server services
It is convenient to utilize third-party server service to operate all backend operations using easier encapsulated functions. Expecting basic functions that most popular third-party server service provider could performs, the main investigate aspects for our app is stable server service, fully functional service, clear and stable API documents.


![image](https://github.com/Wallace2cm/XJTLU-Go/blob/master/Screenshot/Table.png)
As a consequnse, we selected Bmob.
### Use accounts
    -(void)initAPP;
    -(Boolean)createUser:(NSString*)user_name
    password:(NSString*)length;
    -(Boolean)login:(NSString*)user_name password:(NSString*)length;
    -(void)changeRanking:(int)score;
    -(void)logOut;
### Login Function
    If has current user
    Return true
    Else
    If login with correct username and password
    Return true
    Else
    Return false
### Question Bank
    -(void)createQ:(NSString*)title A:(NSString*)optionA
                                    B:(NSString*)optionB
                                    C:(NSString*)optionC
                                    D:(NSString*)optionD
                                    ans:(NSString*)answer;
    -(NSArray *) getAllQustions: bankName;
    -(void)getQuestionsByIndex:(NSArray *)arr
    bankName:(NSString*)bankName;
    -(NSArray *)RandomSearchByNumber:(int)total num:(int)num
    bankName:(NSString*)bankName;
    -(void)searchQ:(NSString*)title;
The auxiliary functions are:

    +(NSMutableArray*)getRamdomArray:(int)number total:(int)total;
    +(NSMutableArray *)getRandomInt:(NSMutableArray*)a total:(int)total;
    
### Initializing Ranking
    Player1:
    If nothing in waiting table:
       Add play1 information, empty options from 1 to 10 to conversation table
       Add two states as false to conversation table
    If successful:
        Listening row change
        Add player1 information, row objectId to waiting table
        If successful:
           Print success
        Else:
           Print error
    Else:
        Print error
        
 
     Play2:
     If has player in waiting table:
        Get player1 information
        Delete selected row in waiting table
        If successful:
           Update player2 information using row objectId in conversation table
           Make sure two states are still false
           Count total number of questions
           If successful:
              If total number is less than ranking question number:
                 Get question index array (length = total number)
              Else:
                  Get question index array (select number of ranking question from total)
                  Update question index to conversation table
              If successful:
                  Listen selected row change
              Else:
                 Print error
           Else:
             Print error
     Else:
        Print error
        
### Received Changing Event
Message should be decoded and operate differently under three conditions.
Condition1: both of two players have not get ranking questions.
Condition2: player tells rival he/she have got ranking questions.
Condition3: players are ranking.

    Decode the Json data and get didInitState and answerState value.
    If both didInitState and answerState are true: (condition3)
       In answering procedure
       Determine which option player are answering
       Determine which current situation
       Send to frontend
    Else:
      If both didInitState and answerState are false: (condition1)
      Get questions using question index
      Update rival user Id, username and score
      Change didInitState to true
      Else: (condition2)
        Know rival get question.
        Update rival user Id, username and score
