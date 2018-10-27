//
//  HomeViewController.swift
//  XJTLU
//
//  Created by Wallace Wu on 2018/4/23.
//  Copyright © 2018年 Wallace Wu. All rights reserved.
//

import UIKit
class HomeViewController : UIViewController{
    
    override func viewDidLoad() {
        
        
        super.viewDidLoad()
    }
    override  func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    @IBOutlet weak var rank: UIButton!
    @IBAction func rankTapped(_ sender: UIButton) {
     
        
    }
    
    
    @IBAction func report(_ sender: UIButton) {
        let alert = UIAlertController(title: "Report", message: "The fucntion of reporting errors", preferredStyle: .alert)
        let dismiss = UIAlertAction(title: "OK", style: .default, handler: {action in self.dismissAlert()})
        alert.addAction(dismiss)
        
        UIView.animate(withDuration: 0.5, delay: 0.5, usingSpringWithDamping: 0.5, initialSpringVelocity: 6, options: .allowUserInteraction, animations: {
            self.present(alert,animated: true, completion: nil)
            
            
        }, completion: nil)
    }
    
    
    @IBAction func addQuestion(_ sender: UIButton) {
        let alert = UIAlertController(title: "Upload", message: "The fucntion of adding question", preferredStyle: .alert)
        let dismiss = UIAlertAction(title: "OK", style: .default, handler: {action in self.dismissAlert()})
        alert.addAction(dismiss)
        
        UIView.animate(withDuration: 0.5, delay: 0.5, usingSpringWithDamping: 0.5, initialSpringVelocity: 6, options: .allowUserInteraction, animations: {
            self.present(alert,animated: true, completion: nil)
            
            
        }, completion: nil)
    }
    
    @IBAction func informationOfTeam(_ sender: UIButton) {
        let alert = UIAlertController(title: "Team Golf!", message: "Jinlong.Hong \n Wenya.Ma \n Pinyi.Wu \n Jiaxin.Li \n Tai.Chen \n Ning.Luo \n Caiming.Pang", preferredStyle: .alert)
        let dismiss = UIAlertAction(title: "Bravo!", style: .default, handler: {action in self.dismissAlert()})
        alert.addAction(dismiss)
        UIView.animate(withDuration: 0.5, delay: 0.5, usingSpringWithDamping: 0.5, initialSpringVelocity: 6, options: .allowUserInteraction, animations: {
             self.present(alert,animated: true, completion: nil)
            
            
        }, completion: nil)
       
    }
    func dismissAlert() {
        
    }
    
   
}
