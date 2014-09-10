//
//  ColorSpinner.swift
//  NumericDial
//
//  Created by Simon Gladman on 08/09/2014.
//  Copyright (c) 2014 Simon Gladman. All rights reserved.
//
//  Some color definitions sourced from http://www.color-hex.com

import UIKit

class ColorSpinner: UIControl, UIPickerViewDataSource, UIPickerViewDelegate
{
    let colors = [
        NamedColor(name: "Custom", color: UIColor.clearColor()),
        NamedColor(name: "Red", color: UIColor.redColor()),
        NamedColor(name: "Green", color: UIColor.greenColor()),
        NamedColor(name: "Blue", color: UIColor.blueColor()),
        NamedColor(name: "Black", color: UIColor(red: 0, green: 0, blue: 0, alpha: 1)),
        NamedColor(name: "Cyan", color: UIColor.cyanColor()),
        NamedColor(name: "Yellow", color: UIColor.yellowColor()),
        NamedColor(name: "Magenta", color: UIColor.magentaColor()),
        NamedColor(name: "Brown", color: UIColor.brownColor()),
        NamedColor(name: "Tomato", color: UIColor(red: 255/255, green: 99/255, blue: 71/255, alpha: 1)),
        NamedColor(name: "Salmon", color: UIColor(red: 250/255, green: 128/255, blue: 114/255, alpha: 1)),
        NamedColor(name: "Turquoise", color: UIColor(red: 64/255, green: 224/255, blue: 208/255, alpha: 1)),
        NamedColor(name: "Plum", color: UIColor(red: 221/255, green: 160/255, blue: 221/255, alpha: 1)),
        NamedColor(name: "Orchid", color: UIColor(red: 218/255, green: 112/255, blue: 214/255, alpha: 1)),
        NamedColor(name: "Wheat", color: UIColor(red: 245/255, green: 222/255, blue: 179/255, alpha: 1)),
        NamedColor(name: "Sienna", color: UIColor(red: 160/255, green: 82/255, blue: 45/255, alpha: 1))
    ]
    
    let spinner : UIPickerView = UIPickerView(frame: CGRectZero)
    
    override init(frame: CGRect)
    {
        super.init(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        
        backgroundColor = UIColor.lightGrayColor()
       
        spinner.delegate = self
        spinner.dataSource = self
        
        addSubview(spinner)
    }
    
    var currentColor : UIColor = UIColor.blackColor()
    {
        didSet
        {
            sendActionsForControlEvents(.ValueChanged)
 
            var matchFound = false
            
            for (index, namedColor) in enumerate(colors)
            {
                if CGColorEqualToColor(namedColor.color.CGColor, currentColor.CGColor)              
                {
                    spinner.selectRow(index, inComponent: 0, animated: true)
                    matchFound = true
                }
            }
            
            if !matchFound
            {
                spinner.selectRow(0, inComponent: 0, animated: true)
                spinner.reloadComponent(0)
            }
        }
    }
    
    required init(coder: NSCoder)
    {
        super.init(coder: coder)
    }
    
    override func didMoveToWindow()
    {
        spinner.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
    }
    
    func pickerView(pickerView: UIPickerView!, titleForRow row: Int, forComponent component: Int) -> String
    {
        return colors[row].name
    }
    
    func pickerView(pickerView: UIPickerView!, didSelectRow row: Int, inComponent component: Int)
    {
        currentColor = colors[row].color
    }
    
    func pickerView(pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat
    {
        return CGFloat(frame.width)
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int
    {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        return colors.count
    }
    
    func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView!) -> UIView
    {
        let rendererColor = (row == 0) ? NamedColor(name: "Custom", color: currentColor) : colors[row]
        
        return ColorSpinnerItemRenderer(frame: CGRectZero, color : rendererColor)
    }
    
}

struct NamedColor
{
    var name : String
    var color : UIColor
    
    init(name : String, color : UIColor)
    {
        self.name = name;
        self.color = color
    }
}
