//
//  ColorSpinnerItemRenderer.swift
//  NumericDial
//
//  Created by Simon Gladman on 09/09/2014.
//  Copyright (c) 2014 Simon Gladman. All rights reserved.
//

import UIKit

class ColorSpinnerItemRenderer: UIControl
{
    let label = UILabel(frame: CGRectZero)
    
    let border = UIView(frame: CGRectZero)
    let swatch = UIView(frame: CGRectZero)
    
    init(frame : CGRect, color : NamedColor)
    {
        super.init(frame: CGRect(x: 0, y: 0, width: 200, height: 80))
        
        label.text = color.name
        border.backgroundColor = UIColor.whiteColor()
        swatch.backgroundColor = color.color
        
        addSubview(label)
        
        if (color.color != UIColor.clearColor())
        {
            addSubview(border)
            addSubview(swatch)
        }
    }
    
    required init(coder: NSCoder)
    {
        super.init(coder: coder)
    }
    
    override func didMoveToWindow()
    {
        label.frame = CGRect(x: 20, y: 0, width: 200, height: 80)
        border.frame = CGRect(x: 158, y: 80 / 2 - 7, width: 34, height: 14)
        swatch.frame = CGRect(x: 160, y: 80 / 2 - 5, width: 30, height: 10)
    }
    
}
