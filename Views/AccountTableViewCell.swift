//
//  AccountTableViewCell.swift
//  XJTLU
//
//  Created by Wallace Wu on 2018/4/23.
//  Copyright © 2018年 Wallace Wu. All rights reserved.
//

import UIKit

class AccountTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var lbl: UILabel!
    @IBOutlet weak var accountView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
