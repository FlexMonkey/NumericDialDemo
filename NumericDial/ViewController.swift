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

class ViewController: UIViewController {
    
    let numericDial = NumericDial(frame: CGRectZero)
    
    let rgbPicker = RGBpicker(frame: CGRectZero)
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        view.addSubview(numericDial)
        view.addSubview(rgbPicker)
        
        rgbPicker.currentColor = UIColor.brownColor()
        
        numericDial.addTarget(self, action: "numericDialValueChanged:", forControlEvents: .ValueChanged)
    }

    func numericDialValueChanged(numericDial : NumericDial)
    {
        hSlider.value = Float(numericDial.currentValue)
    }
    
    override func viewDidLayoutSubviews()
    {
        let margin: CGFloat = 20.0
        let width = 325 - 2.0 * margin
        numericDial.frame = CGRect(x: margin, y: margin + topLayoutGuide.length, width: 325, height: 325)
        
        rgbPicker.frame = CGRect(x: 400, y: margin + topLayoutGuide.length, width: 600, height: 200)
    }
    
    @IBAction func sliderChangeHandler(sender: AnyObject)
    {
        numericDial.currentValue = Double(hSlider.value)
    }
    
    @IBOutlet var hSlider: UISlider!
}

