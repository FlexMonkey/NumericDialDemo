//
//  RGBpicker.swift
//  NumericDial
//
//  Created by Simon Gladman on 06/09/2014.
//  Copyright (c) 2014 Simon Gladman. All rights reserved.
//

import UIKit

class RGBpicker: UIControl
{
    let redDial = NumericDial(frame: CGRectZero)
    let greenDial = NumericDial(frame: CGRectZero)
    let blueDial = NumericDial(frame: CGRectZero)
    let swatch = UIView()

    let numericDialValueChangedSelector : Selector = Selector.convertFromStringLiteral("numericDialValueChanged:")
    
    override init(frame: CGRect)
    {
        super.init(frame: CGRect(x: 0, y: 0, width: 600, height: 200))
        
        backgroundColor = UIColor.lightGrayColor()
        
        addSubview(redDial)
        addSubview(greenDial)
        addSubview(blueDial)

        redDial.addTarget(self, action: numericDialValueChangedSelector, forControlEvents: .ValueChanged)
        greenDial.addTarget(self, action: numericDialValueChangedSelector, forControlEvents: .ValueChanged)
        blueDial.addTarget(self, action: numericDialValueChangedSelector, forControlEvents: .ValueChanged)
        
        swatch.backgroundColor = UIColor.blackColor()
        addSubview(swatch)
    }
    
    required init(coder: NSCoder)
    {
        super.init(coder: coder)
    }

    func numericDialValueChanged(numericDial : NumericDial)
    {
        let red = CGFloat(redDial.currentValue)
        let green = CGFloat(greenDial.currentValue)
        let blue = CGFloat(blueDial.currentValue)
        
        let color = UIColor(red: red, green: green, blue: blue, alpha: 1)
        
        swatch.backgroundColor = color
    }
    
    override func didMoveToWindow()
    {
        redDial.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        greenDial.frame = CGRect(x: 200, y: 0, width: 200, height: 200)
        blueDial.frame = CGRect(x: 400, y: 0, width: 200, height: 200)
        
        swatch.frame = CGRect(x: 20, y: 185, width: 560, height: 10)
        
        redDial.labelFunction = createLabelFunction("Red: ")
        greenDial.labelFunction = createLabelFunction("Green: ")
        blueDial.labelFunction = createLabelFunction("Blue: ")
    }

    func createLabelFunction(label : String) -> ((Double) -> String)
    {
        func redLabelFunction(value : Double) -> String
        {
            return label + NSString(format: "%.4f", value)
        }
        
        return redLabelFunction
    }
    


    
}
