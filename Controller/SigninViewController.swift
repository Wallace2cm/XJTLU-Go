//
//  SigninViewController.swift
//  XJTLU
//
//  Created by Wallace Wu on 2018/4/20.
//  Copyright © 2018年 Wallace Wu. All rights reserved.
//

import UIKit





class SigninViewController : UIViewController {
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
    
    @IBOutlet weak var continueButton: UIButton!
    
    
    
    @IBAction func continueButtonTapped(_ sender: UIButton) {
        
     
       
    let oldUsers = user()

        if let email = emailTextField.text, let  pass = passwordTextField.text {
          let spin = MBProgressHUD.showAdded(to: self.view, animated: true)
            oldUsers.login(email, password: pass)
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(1*NSEC_PER_SEC))/Double(NSEC_PER_SEC)) {
            DispatchQueue.global(qos: .userInitiated).async
             {
                DispatchQueue.main.async()
                    {
                        let state = oldUsers.login(email, password: pass)
                        if state == false  {

                            spin.hide(animated: true)
                            let failed = MBProgressHUD.showAdded(to: self.view, animated: true)
                            failed.mode = MBProgressHUDMode.customView
                            failed.customView = UIImageView(image: UIImage(named: "wrong.png"))
                            failed.label.text = "Invalid Account"
                            failed.hide(animated: true, afterDelay: 2)

                        }else{
                            spin.hide(animated: true)
                            let success = MBProgressHUD.showAdded(to: self.view, animated: true)
                            success.mode = MBProgressHUDMode.customView
                            success.customView = UIImageView(image: UIImage(named: "checked.png"))
                            success.hide(animated: true, afterDelay: 2)

                            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(1*NSEC_PER_SEC))/Double(NSEC_PER_SEC)) {
                                self.performSegue(withIdentifier: "loginSuccessful", sender: self)
                            }
                        }

                }


                }
            }
            }

        }
    
    
        
        
}

