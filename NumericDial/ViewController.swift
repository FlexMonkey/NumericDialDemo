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
    let colorSpinner = ColorSpinner(frame: CGRectZero)
    let swatch = UIView()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        view.addSubview(rgbPicker)
        view.addSubview(cmykPicker)
        view.addSubview(swatch)
        view.addSubview(colorSpinner)
        
        currentColor = UIColor.brownColor()
        
        rgbPicker.addTarget(self, action: "colorChanged:", forControlEvents: .ValueChanged)
        cmykPicker.addTarget(self, action: "colorChanged:", forControlEvents: .ValueChanged)
        colorSpinner.addTarget(self, action: "spinnerColorChanged:", forControlEvents: .ValueChanged)
    }

    var currentColor : UIColor = UIColor.blackColor()
    {
        didSet
        {
            rgbPicker.removeTarget(self, action: "colorChanged:", forControlEvents: .ValueChanged)
            cmykPicker.removeTarget(self, action: "colorChanged:", forControlEvents: .ValueChanged)
            colorSpinner.removeTarget(self, action: "spinnerColorChanged:", forControlEvents: .ValueChanged)
            
            rgbPicker.currentColor = currentColor
            cmykPicker.currentColor = currentColor
            colorSpinner.currentColor = currentColor
            swatch.backgroundColor = currentColor
            
            rgbPicker.addTarget(self, action: "colorChanged:", forControlEvents: .ValueChanged)
            cmykPicker.addTarget(self, action: "colorChanged:", forControlEvents: .ValueChanged)
            colorSpinner.addTarget(self, action: "spinnerColorChanged:", forControlEvents: .ValueChanged)
        }
    }

    func spinnerColorChanged(value : ColorSpinner)
    {
        currentColor = value.currentColor
    }
    
    func colorChanged(value : RGBpicker)
    {
        currentColor = value.currentColor
        
        colorSpinner.spinner
    }
    
    override func viewDidLayoutSubviews()
    {
        let margin: CGFloat = 20.0
        let width = 325 - 2.0 * margin
        
        rgbPicker.frame = CGRect(x: view.frame.width - margin - 600 , y: margin, width: 600, height: 200)
        cmykPicker.frame = CGRect(x: view.frame.width / 2 - 400, y: view.frame.height - 200 - margin, width: 800, height: 200)
        
        swatch.frame = CGRect(x: view.frame.width / 2 - 200, y: view.frame.height / 2 - 100 - margin, width: 400, height: 200)
        
        colorSpinner.frame = CGRect(x: margin, y: margin, width: 200, height: 200)

    }


}

