//
//  choiceButton.swift
//  XJTLU
//
//  Created by Wallace Wu on 2018/4/28.
//  Copyright © 2018年 Wallace Wu. All rights reserved.
//

import UIKit

class choiceButton: UIButton {

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 6, options: .allowUserInteraction, animations: {
            self.transform = CGAffineTransform.identity
            
            
        }, completion: nil)
        super.touchesBegan(touches, with: event)
        
    }
    
    
    
    
    
    
    

    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }
    
   
}
