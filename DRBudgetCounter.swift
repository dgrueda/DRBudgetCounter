//
//  DRBudgetCounter.swift
//  DRBudgetCounter
//
//  Created by Diego Rueda on 08/07/15.
//  Copyright (c) 2015 Diego Rueda. All rights reserved.
//

/// TODO: add didSet for colors
import UIKit

// @IBDesignable needed to allow the properties can be modified from storyboard
// It needs to be public if you want to make also public properties and methods
@IBDesignable public class DRBudgetCounter: UIView {
    let leftButton = UIButton()
    let rightButton = UIButton()
    let label = UILabel()
    
    // The initSetup() function runs after the properties has been created, so it is necesary
    // to make the didSet and willSet for all properties that needs to change its value
    // after running
    var value: Int = 0 {
        // an observer of the changes made in value
        didSet {
            label.text = String(value)
        }
        // it is called before the value changes
        willSet {}
    }

    /// Limits for the counter
    // @IBInspectable needed to allow the var can be modified from storyboard
    @IBInspectable public var leftLimit: Int = 0
    @IBInspectable public var rightLimit: Int = 10
    
    /// Colors
    @IBInspectable public var leftButtonBackgroundColor: UIColor = UIColor.redColor()
    // Just for instructable purpouses: each color of UIColor must be between 0 and 1: number / 255
    @IBInspectable public var labelBackgroundColor: UIColor = UIColor(red: 0, green: 0, blue: (255 / 255), alpha: 1)
    @IBInspectable public var rightButtonBackgroundColor: UIColor = UIColor.redColor()
    
    @IBInspectable public var leftButtonTitleColor: UIColor = UIColor.whiteColor()
    @IBInspectable public var labelColor: UIColor = UIColor.whiteColor()
    @IBInspectable public var rigthButtonTitleColor: UIColor = UIColor.whiteColor()
    
    /// Animation properties
    
    @IBInspectable public var animationDuration: NSTimeInterval = 0.1
    private let labelDisplacement: CGFloat = 5
    
    
    required public init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initSetup()
    }
    
    // Sometimes needed to fix some problems with Swift. Swift calls this init instead of the another one
    override init(frame: CGRect) {
        super.init(frame: frame)
        initSetup()
    }
    
    func initSetup() {
        let leftButtonText = "-"
        let rightButtonText = "+"
        
        leftButton.setTitle(leftButtonText, forState: .Normal)
        rightButton.setTitle(rightButtonText, forState: .Normal)
        
        // adds the elements to itself. You can add an element inside another element with label.subView(leftButton)
        addSubview(leftButton)
        addSubview(rightButton)
        addSubview(label)
        
        // Sets the colors
        leftButton.backgroundColor = leftButtonBackgroundColor
        label.backgroundColor = labelBackgroundColor
        rightButton.backgroundColor = rightButtonBackgroundColor
        
        leftButton.setTitleColor(leftButtonTitleColor, forState: .Normal)
        label.textColor = labelColor
        rightButton.setTitleColor(leftButtonTitleColor, forState: .Normal)
        
        // You can omit UIControlEvents and use .TouchDown
        // colon (:) after the name of the function is necesary to indicate that the function receives parameters
        leftButton.addTarget(self, action: "leftButtonTapped:", forControlEvents:  UIControlEvents.TouchDown)
        rightButton.addTarget(self, action: "rightButtonTapped:", forControlEvents: .TouchDown)
        
        label.text = String(value)
        label.textAlignment = .Center
    }
    
    override public func layoutSubviews() {
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
    @objc private func leftButtonTapped(sender: UIButton) {
        if (value > leftLimit) {
            value -= 1
            animateLabelToLeft()
        }
        else {
            limitReached(sender)
        }
    }
    
    @objc private func rightButtonTapped(sender: UIButton) {
        if (value < rightLimit) {
            value += 1
            animateLabelToRight()
        }
        else {
            limitReached(sender)
        }
    }
    
    func animateLabelToLeft() {
        animateLabel(self.labelDisplacement)
    }
    
    func animateLabelToRight() {
        animateLabel(-self.labelDisplacement)
    }
    
    func animateLabel(displacement: CGFloat) {
        UIView.animateWithDuration(animationDuration, animations: {
            self.label.center.x -= displacement
            },
            completion: { _ in
                self.label.center.x += displacement
        })
    }
    
    func limitReached(sender: UIButton) {
        let backgroundColor: UIColor = sender.backgroundColor!
        
        UIView.animateWithDuration(animationDuration, animations: {
            sender.backgroundColor = UIColor.blackColor()
            }, completion: { _ in
                sender.backgroundColor = backgroundColor
        })
    }
}