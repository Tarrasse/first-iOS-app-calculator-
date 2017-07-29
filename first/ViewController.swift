//
//  ViewController.swift
//  first
//
//  Created by Mahmoud El-Tarrasse on 7/27/17.
//  Copyright © 2017 Mahmoud El-Tarrasse. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet private weak var display: UILabel!
    
    private var userIsInTheMiddleOfTheTyping = false
    
    private var brain: calculatorBrain = calculatorBrain()
    
    //this value to track the the display text
    private var displayValue:Double{
        get{
            return Double(display.text!)!
        }
        set{
            display.text = String(newValue)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction private func touchDigit(_ sender: UIButton) {
        let digit = sender.currentTitle!
        
        if userIsInTheMiddleOfTheTyping {
            let textCurrentlyInDisplay = display.text!
            display.text = textCurrentlyInDisplay + digit
        }else{
            display.text =  digit
        }
        userIsInTheMiddleOfTheTyping = true
    }
    
    @IBAction private func performOperation(_ sender: UIButton) {
        if userIsInTheMiddleOfTheTyping {
            brain.setOperand(openrand: displayValue)
        }
        userIsInTheMiddleOfTheTyping = false
        if let mathSymbol = sender.currentTitle{
            brain.performOperation(symbol: mathSymbol)
        }
        displayValue = brain.result
    }
    

}

