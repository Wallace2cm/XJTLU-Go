//
//  XJTLU.swift
//  XJTLU
//
//  Created by Wallace Wu on 2018/4/21.
//  Copyright © 2018年 Wallace Wu. All rights reserved.
//

import UIKit

class XJTLU : UIViewController {
    
    
    @IBOutlet weak var Ranking: UIButton!
    
    @IBOutlet weak var Account: UILabel!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        Account.isHidden = true
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    @IBAction func valueChanged(_ sender: SelecctorControll) {
        if sender.selectedSegmentedControl == 0 {
            UIView.animate(withDuration: 0.3, animations: {
                self.Ranking.alpha = 1
                self.Account.alpha = 0
            })
        }
        else if sender.selectedSegmentedControl == 1 {
             self.performSegue(withIdentifier: "account", sender: self)
            Account.isHidden = false
            UIView.animate(withDuration: 0.3, animations: {
                self.Ranking.alpha = 0
                self.Account.alpha = 1
            })
            
        }
     }
 
}
