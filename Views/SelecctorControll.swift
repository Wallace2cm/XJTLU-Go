//
//  SelecctorControll.swift
//  XJTLU
//
//  Created by Wallace Wu on 2018/4/21.
//  Copyright © 2018年 Wallace Wu. All rights reserved.
//

import UIKit
@IBDesignable
class SelecctorControll: UIControl {
    
    var buttons = [UIButton]()
    var selector : UIView!
    var selectedSegmentedControl = 0
    @IBInspectable
    var borderWidth : CGFloat = 0  {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    @IBInspectable
    var borderColor : UIColor = UIColor.clear {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable
    var commaSeparateButtonTitles : String = "," {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable
    var textColor : UIColor = .black{
        didSet {
            updateView()
        }
    }
    @IBInspectable
    var selectorColor : UIColor = .lightGray{
        didSet {
            updateView()
        }
    }
    @IBInspectable
    var selectorTextColor : UIColor = .white {
        didSet {
            updateView()
        }
    }
    
    func updateView () {
        buttons.removeAll()
        subviews.forEach { (view) in
            view.removeFromSuperview()
        }
        
        
        let buttonTitles = commaSeparateButtonTitles.components(separatedBy: ",")
        for buttonTitle in buttonTitles {
            let button = UIButton(type: .system)
            button.setTitle(buttonTitle, for: .normal)
            button.setTitleColor(textColor, for: .normal)
            button.addTarget(self, action: #selector(buttonTapped(button:)), for: .touchUpInside)
            buttons.append(button)
        }
        
        buttons[0].setTitleColor(selectorTextColor, for: .normal)
        
        
        let selectorWidth = frame.width / CGFloat(buttonTitles.count)
        
        selector = UIView(frame: CGRect(x: 0, y: 0, width: selectorWidth, height: frame.height))
        selector.backgroundColor = selectorColor
        addSubview(selector)
        
        let sv = UIStackView(arrangedSubviews: buttons)
        sv.axis = .horizontal
        sv.alignment = .fill
        sv.distribution = .fillEqually
        addSubview(sv)
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        sv.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        sv.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        sv.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        
    }
    
    override func draw(_ rect: CGRect) {
       
    }
    
    @objc func buttonTapped(button : UIButton) {
        for (buttonIndex, btn) in buttons.enumerated() {
            
            
            btn.setTitleColor(textColor, for: .normal)
            if btn.isEqual(button) {
                selectedSegmentedControl = buttonIndex
                let selectorStartPosition = frame.width/CGFloat(buttons.count) * CGFloat(buttonIndex)
                UIView.animate(withDuration: 0.3, animations: {
                    self.selector.frame.origin.x = selectorStartPosition
                })
                
                btn.setTitleColor(selectorTextColor, for: .normal)
                
            }
        }
        sendActions(for: .valueChanged)
    }
    
    
    

}
