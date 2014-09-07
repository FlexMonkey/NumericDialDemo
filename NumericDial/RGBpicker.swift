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
    let redCyanDial = NumericDial(frame: CGRectZero)
    let greenMagentaDial = NumericDial(frame: CGRectZero)
    let blueYellowDial = NumericDial(frame: CGRectZero)
    let blackDial : NumericDial?
    let swatch = UIView()
    let cmykMode : Bool

    let numericDialValueChangedSelector : Selector = Selector.convertFromStringLiteral("numericDialValueChanged:")
    
    var updateDialsOnColorChange : Bool = true;
    
    init(frame: CGRect, cmykMode : Bool)
    {
        self.cmykMode = cmykMode
        
        super.init(frame: CGRect(x: 0, y: 0, width: cmykMode ? 800: 600, height: 200))
        
        backgroundColor = UIColor.lightGrayColor()
        
        addSubview(redCyanDial)
        addSubview(greenMagentaDial)
        addSubview(blueYellowDial)
        
        if(cmykMode)
        {
            blackDial = NumericDial(frame: CGRectZero)
            addSubview(blackDial!)
        }
        
        addSubview(swatch)
        
        addDispatchers()
    }
    
    required init(coder: NSCoder)
    {
        self.cmykMode = false;
        super.init(coder: coder)
    }

    var currentColor : UIColor = UIColor.blackColor()
    {
        didSet
        {
            if updateDialsOnColorChange
            {
                let colorRef = CGColorGetComponents(currentColor.CGColor);
                
                removeDispatchers()
          
                if cmykMode
                {
                    let k = 1 - max(max(Double(colorRef[0]), Double(colorRef[1])), Double(colorRef[2]))
                    
                    blackDial!.currentValue = k
                    redCyanDial.currentValue = (1 - Double(colorRef[0]) - k) / (1 - k)
                    greenMagentaDial.currentValue = (1 - Double(colorRef[1]) - k) / (1 - k)
                    blueYellowDial.currentValue = (1 - Double(colorRef[2]) - k) / (1 - k)
                }
                else
                {
                    redCyanDial.currentValue = Double(colorRef[0])
                    greenMagentaDial.currentValue = Double(colorRef[1])
                    blueYellowDial.currentValue = Double(colorRef[2])
                }
        
                addDispatchers()
            }
            
            swatch.backgroundColor = currentColor
            
            sendActionsForControlEvents(.ValueChanged)
        }
    }
    
    func addDispatchers()
    {
        redCyanDial.addTarget(self, action: numericDialValueChangedSelector, forControlEvents: .ValueChanged)
        greenMagentaDial.addTarget(self, action: numericDialValueChangedSelector, forControlEvents: .ValueChanged)
        blueYellowDial.addTarget(self, action: numericDialValueChangedSelector, forControlEvents: .ValueChanged)
        
        if cmykMode
        {
           blackDial!.addTarget(self, action: numericDialValueChangedSelector, forControlEvents: .ValueChanged)
        }
    }
    
    func removeDispatchers()
    {
        redCyanDial.removeTarget(self, action: numericDialValueChangedSelector, forControlEvents: .ValueChanged)
        greenMagentaDial.removeTarget(self, action: numericDialValueChangedSelector, forControlEvents: .ValueChanged)
        blueYellowDial.removeTarget(self, action: numericDialValueChangedSelector, forControlEvents: .ValueChanged)
        
        if cmykMode
        {
            blackDial!.removeTarget(self, action: numericDialValueChangedSelector, forControlEvents: .ValueChanged)
        }
    }
    
    func numericDialValueChanged(numericDial : NumericDial)
    {
        updateDialsOnColorChange = false
        
        if cmykMode
        {
            let red = (1 - CGFloat(redCyanDial.currentValue)) * (1 - CGFloat(blackDial!.currentValue))
            let green = (1 - CGFloat(greenMagentaDial.currentValue)) * (1 - CGFloat(blackDial!.currentValue))
            let blue = (1 - CGFloat(blueYellowDial.currentValue)) * (1 - CGFloat(blackDial!.currentValue))
            
            currentColor = UIColor(red: red, green: green, blue: blue, alpha: 1)
        }
        else
        {
            let red = CGFloat(redCyanDial.currentValue)
            let green = CGFloat(greenMagentaDial.currentValue)
            let blue = CGFloat(blueYellowDial.currentValue)
            
            currentColor = UIColor(red: red, green: green, blue: blue, alpha: 1)
        }
        
        updateDialsOnColorChange = true
    }
    
    override func didMoveToWindow()
    {
        redCyanDial.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        greenMagentaDial.frame = CGRect(x: 200, y: 0, width: 200, height: 200)
        blueYellowDial.frame = CGRect(x: 400, y: 0, width: 200, height: 200)
 
        swatch.frame = CGRect(x: 5, y: 180, width: frame.width - 10, height: 15)
        
        let redCyanLabel = cmykMode ? "Cyan" : "Red"
        let greenMagentaLabel = cmykMode ? "Magenta" : "Green"
        let blueYellowLabel = cmykMode ? "Yellow" : "Blue"
        
        redCyanDial.labelFunction = createLabelFunction("\(redCyanLabel): ")
        greenMagentaDial.labelFunction = createLabelFunction("\(greenMagentaLabel): ")
        blueYellowDial.labelFunction = createLabelFunction("\(blueYellowLabel): ")
        
        if cmykMode
        {
            blackDial?.frame = CGRect(x: 600, y: 0, width: 200, height: 200)
            blackDial?.labelFunction = createLabelFunction("Black: ")
        }
    }

    func createLabelFunction(label : String) -> ((Double) -> String)
    {
        func rgbLabelFunction(value : Double) -> String
        {
            if (cmykMode)
            {
                return label + NSString(format: "%d", Int(value * 100)) + "%"
            }
            else
            {
                return label + NSString(format: "%2X", Int(value * 255))
            }
        }
        
        return rgbLabelFunction
    }
    


    
}
