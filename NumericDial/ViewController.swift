//
//  ViewController.swift
//  NumericDial
//
//  Created by Simon Gladman on 05/09/2014.
//  Copyright (c) 2014 Simon Gladman. All rights reserved.
//
//  Demo of NumericDial Control
//
//  Demo shows a dial with a horizontal slider. When either changes, the other reflects that change
//  With help from http://www.raywenderlich.com/76433/how-to-make-a-custom-control-swift

import UIKit

class ViewController: UIViewController
{
    let rgbPicker = RGBpicker(frame: CGRectZero, cmykMode : false)
    let cmykPicker = RGBpicker(frame: CGRectZero, cmykMode : true)
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        view.addSubview(rgbPicker)
        view.addSubview(cmykPicker)
        
        currentColor = UIColor.brownColor()
        
        rgbPicker.addTarget(self, action: "colorChanged:", forControlEvents: .ValueChanged)
        cmykPicker.addTarget(self, action: "colorChanged:", forControlEvents: .ValueChanged)
    }

    var currentColor : UIColor = UIColor.blackColor()
    {
        didSet
        {
            rgbPicker.removeTarget(self, action: "colorChanged:", forControlEvents: .ValueChanged)
            cmykPicker.removeTarget(self, action: "colorChanged:", forControlEvents: .ValueChanged)
            
            rgbPicker.currentColor = currentColor
            cmykPicker.currentColor = currentColor
            
            rgbPicker.addTarget(self, action: "colorChanged:", forControlEvents: .ValueChanged)
            cmykPicker.addTarget(self, action: "colorChanged:", forControlEvents: .ValueChanged)
        }
    }
    
    func colorChanged(value : RGBpicker)
    {
        currentColor = value.currentColor
    }
    
    override func viewDidLayoutSubviews()
    {
        let margin: CGFloat = 20.0
        let width = 325 - 2.0 * margin
        
        rgbPicker.frame = CGRect(x: view.frame.width / 2 - 300, y: margin, width: 600, height: 200)
        cmykPicker.frame = CGRect(x: view.frame.width / 2 - 400, y: view.frame.height - 200 - margin, width: 800, height: 200)
    }


}

