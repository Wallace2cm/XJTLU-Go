//
//  TableViewController.swift
//  XJTLU
//
//  Created by Wallace Wu on 2018/4/23.
//  Copyright © 2018年 Wallace Wu. All rights reserved.
//

import UIKit





class TableViewController: UITableViewController {

    let account = ["Account", "Points", "Settings"]
    var myindex = 0
    @IBOutlet var accountView: UITableView!
    
    
    
    @IBOutlet weak var logOut: UIButton!
    
    @IBAction func logOutTpped(_ sender: Any) {
         BmobUser.logout()
        self.performSegue(withIdentifier: "logOutToBegin", sender: self)
        
    }
    
    
    
    
    override func viewDidLoad() {
        tableView.backgroundView = UIImageView(image: UIImage(named: "IMG_0104"))
        accountView.delegate = self
        accountView .dataSource = self
        super.viewDidLoad()
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return account.count
        
        
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = accountView.dequeueReusableCell(withIdentifier: "Acc") as! AccountTableViewCell
        
        cell.cellView.layer.cornerRadius = cell.cellView.frame.height / 2
        
        
        cell.lbl.text = account[indexPath.row]
        cell.accountView.image = UIImage(named: account[indexPath.row])
        cell.accountView.layer.cornerRadius = cell.accountView.layer.frame.height/2
        cell.backgroundColor = UIColor.clear
        return cell
    }
   
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        myindex = indexPath.row
        performSegue(withIdentifier: "detail", sender: self)
        
    }



}
 

