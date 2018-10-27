//
//  tabBarController.swift
//  XJTLU
//
//  Created by Wallace Wu on 2018/5/13.
//  Copyright © 2018年 Wallace Wu. All rights reserved.
//

import UIKit

class tabBarController: UITabBarController {

    override func viewDidLoad() {
        self.navigationItem.hidesBackButton = true
        if self.tabBarItem.tag == 0 {
        self.navigationItem.title = "Dashboard"
        }
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if item.tag == 1 {
            navigationItem.title = "Dashboard"
            
        }else {
            navigationItem.title = " Me"
        }
    
    }
    
    
    
    
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
