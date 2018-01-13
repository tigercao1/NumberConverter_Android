//
//  ViewController.swift
//  Assignment2
//
//  Created by Yizhang Cao on 2017-03-07.
//  Copyright © 2017 Yizhang Cao. All rights reserved.
//

import UIKit

// http://stackoverflow.com/questions/34587094/how-to-check-if-text-contains-only-numbers
extension String {
    var isNumeric: Bool {
        let nums: Set<Character> = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
        return Set(self.characters).isSubset(of: nums)
    }
    
    var isBinary: Bool {
        let nums: Set<Character> = ["0", "1"]
        return Set(self.characters).isSubset(of: nums)
    }
    
    var isHex: Bool {
        let strings: Set<Character> = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "A", "B", "C", "D", "E", "F", "a", "b", "c", "d", "e", "f"]
        return Set(self.characters).isSubset(of: strings)
    }
}

class ViewController: UIViewController {

    @IBOutlet var decimalButton: UIButton!
    @IBOutlet var binaryButton: UIButton!
    @IBOutlet var hexButton: UIButton!
    @IBOutlet var inputField: UITextField!
    var isDecimalButtonPressed: Bool = false
    var convertedValue: String = ""
    var index: String.Index? = nil
    var input: String = ""
    var head: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initButtons()
        self.view.layer.backgroundColor = UIColor.gray.cgColor
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func binaryToDecimal(_ binaryString : String) -> Bool {
        if Int(strtoul(binaryString, nil, 2)) != 0{
            convertedValue = String(strtoul(binaryString, nil, 2))
            return true
        }
        return false
    }
    
    func hexToDecimal(_ hexString: String) -> Bool {
        if Int(strtoul(hexString, nil, 16)) != 0{
            convertedValue = String(strtoul(hexString, nil, 16))
            return true
        }
        return false
    }
    
    func decimalToBinary(_ decimalString: String) -> Bool {
//        if Int(strtoul(decimalString, nil, 2)) != 0{
//            convertedValue = String(strtoul(decimalString, nil, 2))
//            return true
//        }
//        return false
        if decimalString.isNumeric{
            convertedValue = String(Int(decimalString)!,radix: 2)
            return true
        }
        return false
    }
    
    
    func hexToBinary(_ hexString: String) -> Bool {
        if hexToDecimal(hexString){
            if decimalToBinary(convertedValue){
                return true
            }
        }
        return false
    }
    
    func decimalToHex(_ decimalString: String) -> Bool {
        if decimalString.isNumeric{
            convertedValue = String(Int(decimalString)!, radix: 16)
            return true
        }
        return false
    }
    
    func binaryToHex(_ binaryString: String) -> Bool {
        if binaryToDecimal(binaryString){
            if decimalToHex(convertedValue){
                return true
            }
        }
        return false
    }
    
    
    @IBAction func decimalButtonClicked(sender : UIButton){
        decimalButton.layer.backgroundColor = UIColor.green.cgColor
        binaryButton.layer.backgroundColor = UIColor.red.cgColor
        hexButton.layer.backgroundColor = UIColor.red.cgColor
        if ((inputField.text?.characters.count)! >= 2){
            index = inputField.text!.index(inputField.text!.startIndex, offsetBy: 2)
            input = inputField.text!.substring(from: index!)
            head = inputField.text!.substring(to: index!)
        }
        else {
            head = inputField.text!
        }
        
        if head == "h:" && hexToDecimal(input) && input.isHex{
            inputField.backgroundColor = UIColor.white
            inputField.text = "d:"+convertedValue
        }
        else if head == "b:" && binaryToDecimal(input) && input.isBinary {
            inputField.backgroundColor = UIColor.white
            inputField.text = "d:"+convertedValue
        }
        else if head == "d:" && input.isNumeric{
            inputField.backgroundColor = UIColor.white
            return
        }
        else {
            inputField.text = "ERROR"
            inputField.backgroundColor = UIColor.red
        }
    }
    
    @IBAction func binaryButtonClicked(sender : UIButton){
        decimalButton.layer.backgroundColor = UIColor.red.cgColor
        binaryButton.layer.backgroundColor = UIColor.green.cgColor
        hexButton.layer.backgroundColor = UIColor.red.cgColor
        
        if ((inputField.text?.characters.count)! >= 2){
            index = inputField.text!.index(inputField.text!.startIndex, offsetBy: 2)
            input = inputField.text!.substring(from: index!)
            head = inputField.text!.substring(to: index!)
        }
        else {
            head = inputField.text!
        }
        
        if head == "h:" && hexToBinary(input) && input.isHex{
            inputField.text = "b:"+convertedValue
            inputField.backgroundColor = UIColor.white
        }
        else if head == "d:" && decimalToBinary(input) && input.isNumeric{
            inputField.text = "b:"+convertedValue
            inputField.backgroundColor = UIColor.white
        }
        else if head == "b:" && input.isBinary{
            inputField.backgroundColor = UIColor.white
            return
        }
        else{
            inputField.text = "ERROR"
            inputField.backgroundColor = UIColor.red
        }
    }
    
    @IBAction func hexButtonClicked(sender : UIButton){
        decimalButton.layer.backgroundColor = UIColor.red.cgColor
        binaryButton.layer.backgroundColor = UIColor.red.cgColor
        hexButton.layer.backgroundColor = UIColor.green.cgColor
        if ((inputField.text?.characters.count)! >= 2){
            index = inputField.text!.index(inputField.text!.startIndex, offsetBy: 2)
            input = inputField.text!.substring(from: index!)
            head = inputField.text!.substring(to: index!)
        }
        else {
            head = inputField.text!
        }
        if head == "d:" && decimalToHex(input) && input.isNumeric{
            inputField.text = "h:"+convertedValue
            inputField.backgroundColor = UIColor.white
            convertedValue = ""
        }
        else if head == "b:" && binaryToHex(input) && input.isBinary{
            inputField.text = "h:"+convertedValue
            inputField.backgroundColor = UIColor.white
            convertedValue = ""
        }
        else if head == "h:" && hexToDecimal(input) && input.isHex{
            inputField.backgroundColor = UIColor.white
            convertedValue = ""
            return
        }
        else{
            inputField.text = "ERROR"
            convertedValue = ""
            inputField.backgroundColor = UIColor.red
        }
        
    }
    
    func initButtons(){
        decimalButton.layer.cornerRadius = 10;
        decimalButton.layer.backgroundColor = UIColor.red.cgColor
        decimalButton.layer.borderWidth = 2
        decimalButton.layer.borderColor = UIColor.black.cgColor
        
        binaryButton.layer.cornerRadius = 10;
        binaryButton.layer.backgroundColor = UIColor.red.cgColor
        binaryButton.layer.borderWidth = 2
        binaryButton.layer.borderColor = UIColor.black.cgColor
        
        hexButton.layer.cornerRadius = 10;
        hexButton.layer.backgroundColor = UIColor.red.cgColor
        hexButton.layer.borderWidth = 2
        hexButton.layer.borderColor = UIColor.black.cgColor
    }

}

