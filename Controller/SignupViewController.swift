//
//  SignupViewController.swift
//  XJTLU
//
//  Created by Wallace Wu on 2018/4/20.
//  Copyright © 2018年 Wallace Wu. All rights reserved.
//

import UIKit


class SignupViewController : UIViewController {
    
    override func viewDidLoad() {
        self.emailTextField.alpha = 0.7
        self.passwordTextField.alpha = 0.7
         self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:))))
        super.viewDidLoad()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
   
        
   
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var createButton: UIButton!
    
    
    @IBAction func createButtonTapped(_ sender: UIButton) {
        let spinning = MBProgressHUD.showAdded(to: self.view, animated: true)
        let suffix : String = "@student.xjtlu.edu.cn"
        if let email = emailTextField.text, let pass = passwordTextField.text, let emailaddress : String = email + suffix {
            let newUser = user()
            newUser.createUser(email, password: pass)
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(2*NSEC_PER_SEC))/Double(NSEC_PER_SEC)) {
                DispatchQueue.global(qos: .userInitiated).async
                    {
                        DispatchQueue.main.async()
                            {
                                let state = newUser.login(email, password: pass)
                                if state == true {
                                    spinning.hide(animated: true)
                                    let successSignUp = MBProgressHUD.showAdded(to: self.view, animated: true)
                                    successSignUp.mode = MBProgressHUDMode.customView
                                    successSignUp.customView = UIImageView(image: UIImage(named: "checked.png"))
                                    successSignUp.label.text = "Success!"
                                    successSignUp.hide(animated: true, afterDelay: 2)
                                    print("ok")
                                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(1*NSEC_PER_SEC))/Double(NSEC_PER_SEC)) {
                                        self.performSegue(withIdentifier: "signUp", sender: self)
                                    }
                                   
                                }else{
                                    spinning.hide(animated: true)
                                    let failedSignUp = MBProgressHUD.showAdded(to: self.view, animated: true)
                                    failedSignUp.mode = MBProgressHUDMode.customView
                                    failedSignUp.customView = UIImageView(image: UIImage(named: "wrong.png"))
                                    failedSignUp.label.text = "Invalid Input!"
                                    failedSignUp.hide(animated: true, afterDelay: 2)
                                    print("no")
                                }
                                newUser.logOut()
                        }
                        
                }
           
            
            }

        }
    }
    
}

