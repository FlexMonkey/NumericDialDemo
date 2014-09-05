//
//  ViewController.swift
//  NumericDial
//
//  Created by Simon Gladman on 05/09/2014.
//  Copyright (c) 2014 Simon Gladman. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let numericDial = NumericDial(frame: CGRectZero)
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        view.addSubview(numericDial)
        
        numericDial.addTarget(self, action: "numericDialValueChanged:", forControlEvents: .ValueChanged)
    }

    func numericDialValueChanged(numericDial : NumericDial)
    {
        println("Hello from numericDialValueChanged \(numericDial.currentValue)")
        
        hSlider.value = Float(numericDial.currentValue)
    }
    
    override func viewDidLayoutSubviews()
    {
        let margin: CGFloat = 20.0
        let width = view.bounds.width - 2.0 * margin
        numericDial.frame = CGRect(x: margin, y: margin + topLayoutGuide.length, width: 300, height: 300)
    }
    
    @IBAction func sliderChangeHandler(sender: AnyObject)
    {
        numericDial.currentValue = Double(hSlider.value)
    }
    
    @IBOutlet var hSlider: UISlider!
}

