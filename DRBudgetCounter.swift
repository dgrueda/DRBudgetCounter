//
//  DRBudgetCounter.swift
//  DRBudgetCounter
//
//  Created by Diego Rueda on 08/07/15.
//  Copyright (c) 2015 Diego Rueda. All rights reserved.
//

import UIKit

class DRBudgetCounter: UIView {
    let leftButton = UIButton()
    let rightButton = UIButton()
    let label = UILabel()
    var value: Int = 0 {
        // an observer of the changes made in value
        didSet {
            label.text = String(value)
        }
        // it is called before the value changes
        willSet {}
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        let leftButtonText = "-"
        let rightButtonText = "+"
        
        leftButton.setTitle(leftButtonText, forState: .Normal)
        rightButton.setTitle(rightButtonText, forState: .Normal)
        
        // adds the elements to itself. You can add an element inside another element with label.subView(leftButton)
        addSubview(leftButton)
        addSubview(rightButton)
        addSubview(label)
        
        leftButton.backgroundColor = UIColor.redColor()
        label.backgroundColor = UIColor(red: 0, green: 0, blue: (255 / 255), alpha: 1)
        rightButton.backgroundColor = UIColor.redColor()
        
        // You can omit UIControlEvents and use .TouchDown
        // colon (:) after the name of the function is necesary to indicate that the function receives parameters
        leftButton.addTarget(self, action: "leftButtonTapped:", forControlEvents:  UIControlEvents.TouchDown)
        rightButton.addTarget(self, action: "rightButtonTapped:", forControlEvents: .TouchDown)
    }
    
    override func layoutSubviews() {
        var width = bounds.size.width
        var height = bounds.size.height
        
        // define the frames for label and button
        let labelWidth = width * 0.5
        let buttonWidth = width * 0.25
        
        leftButton.frame = CGRect(x: 0, y: 0, width: buttonWidth, height: height)
        label.frame = CGRect(x: buttonWidth, y: 0, width: labelWidth, height: height)
        rightButton.frame = CGRect(x: labelWidth + buttonWidth, y: 0, width: buttonWidth, height: height)
        
    }
    
    /// MARK: Button functions
    func leftButtonTapped(sender: UIButton) {
        value -= 1
    }
    
    func rightButtonTapped(sender: UIButton) {
        value += 1
    }
}
