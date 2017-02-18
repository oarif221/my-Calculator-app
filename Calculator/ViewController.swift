//
//  ViewController.swift
//  Calculator
//
//  Created by Omer Arif on 14/02/2017.
//  Copyright © 2017 OmerA. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    
    enum Operation: String{
        case Divide = "/"
        case Multiply = "*"
        case Subtract = "-"
        case Add = "+"
        case Empty = "Empty"
    }

    @IBOutlet weak var outputLbl: UILabel!
    
    var btnSound: AVAudioPlayer!
    
    var currentNumber = ""
    var leftValue = ""
    var rightValue = ""
    var result = ""
    var currentOperation: Operation = Operation.Empty
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        let path = Bundle.main.path(forResource: "btn", ofType: "wav")
        
        let soundUrl = NSURL(fileURLWithPath: path!)
        
        do{
            try btnSound = AVAudioPlayer(contentsOf: soundUrl as URL)
            btnSound.prepareToPlay()
        } catch let error as NSError{
            print(error.debugDescription)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func clearButton(btn: UIButton){
        
        playSound()
        outputLbl.text = "0"
        currentNumber = ""
        leftValue = ""
        rightValue = ""
        result = ""
        currentOperation = Operation.Empty
        
    }
    @IBAction func numberPressed(btn: UIButton!){
        
        playSound()
        
        currentNumber += "\(btn.tag)"
        outputLbl.text = currentNumber
    
    }

    @IBAction func DivideButton(_ sender: Any) {
        processOperation(op: Operation.Divide)
    }
    
    
    @IBAction func MultiplyButton(_ sender: Any) {
        processOperation(op: Operation.Multiply)
    }
    
    
    @IBAction func SubtractButton(_ sender: Any) {
        processOperation(op: Operation.Subtract)
    }
    
    @IBAction func AddButton(_ sender: Any) {
        processOperation(op: Operation.Add)
    }
    
    @IBAction func EqualButton(_ sender: Any) {
        processOperation(op: currentOperation)
        
    }
    
    func processOperation(op: Operation){
        playSound()
        
        if currentOperation != Operation.Empty {
            
            if currentNumber != "" {
                rightValue = currentNumber
                currentNumber = ""
                
                if currentOperation == Operation.Add{
                    
                    result = "\(Double(leftValue)! + Double(rightValue)!)"
                }
                else if currentOperation == Operation.Subtract{
                    
                    result = "\(Double(leftValue)! - Double(rightValue)!)"
                }
                else if currentOperation == Operation.Multiply{
                    
                    result = "\(Double(leftValue)! * Double(rightValue)!)"
                }
                else if currentOperation == Operation.Divide{
                    
                    result = "\(Double(leftValue)! / Double(rightValue)!)"
                }
                
                leftValue = result
                outputLbl.text = result
            }
            
            currentOperation = op
            
        } else {
            leftValue = currentNumber
            currentNumber = ""
            currentOperation = op
        }
        
    }
    
    func playSound(){
        if btnSound.isPlaying {
            btnSound.stop()
        }
        
        btnSound.play()
    }
    
}

