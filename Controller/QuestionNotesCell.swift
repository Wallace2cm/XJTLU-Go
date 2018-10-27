//
//  QuestionNotesCell.swift
//  XJTLU
//
//  Created by Wallace Wu on 2018/5/17.
//  Copyright © 2018年 Wallace Wu. All rights reserved.
//

import UIKit

class QuestionNotesCell: UITableViewCell {
    
    
    
    @IBOutlet weak var questionSaved: UILabel!
    @IBOutlet weak var timeSaved: UILabel!
    
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
