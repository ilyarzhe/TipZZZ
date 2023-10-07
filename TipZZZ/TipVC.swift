//
//  TipVC.swift
//  TipZZZ
//
//  Created by Ilya Rzheznikov on 24/09/2023.
//

import UIKit

class TipVC: UIViewController, UITextFieldDelegate {
    
    let enterBill = TipLabel(fontSize: 19)
    let billAmount = UITextField()
    let tipSlider = UISlider()
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        var currentText = (textField.text?.replacingOccurrences(of: ",", with: "") ?? "")
        if let value = Int(currentText) {
            let formattedNumber = NumberFormatters.formatter.string(
                from: NSNumber(value: value)
            )
            textField.text = formattedNumber
            
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        billAmount.delegate = self
        configureUI()
        billAmount.addTarget(self, action: #selector(TipVC.textFieldDidChange(_:)), for: .editingChanged)
        
        
        // Do any additional setup after loading the view.
    }
    
    // Configuration Sheet
    func configureUI(){
        createEnterBill()
        createBillAmount()
        createTipSlider()
    }
    
    func createEnterBill () {
        view.addSubview(enterBill)
        enterBill.text = "Enter Bill Amount"
        NSLayoutConstraint.activate([
            enterBill.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            enterBill.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50)
        ])
    }
    func createBillAmount() {
        view.addSubview(billAmount)
        billAmount.translatesAutoresizingMaskIntoConstraints = false
        billAmount.keyboardType = .numberPad
        billAmount.textColor = .systemGray
        billAmount.font = .systemFont(ofSize: 50, weight: .bold)
        billAmount.textAlignment = .center
        billAmount.placeholder = "..."
        NSLayoutConstraint.activate([
            billAmount.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            billAmount.topAnchor.constraint(equalTo: enterBill.bottomAnchor, constant: 20),
            billAmount.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
    func createTipSlider(){
        view.addSubview(tipSlider)
        tipSlider.translatesAutoresizingMaskIntoConstraints = false
        tipSlider.maximumValue = 100
        tipSlider.minimumValue = 0
        tipSlider.isContinuous = false
        tipSlider.backgroundColor = .systemBlue
        NSLayoutConstraint.activate([
            tipSlider.widthAnchor.constraint(equalToConstant: 100),
            tipSlider.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tipSlider.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0)
        ])
       
    }
    
    func textField(
        _ textField: UITextField,
        shouldChangeCharactersIn range: NSRange,
        replacementString string: String
    ) -> Bool {
        
        let numbers  = "0123456789"
        let numbersOnly = CharacterSet(charactersIn: "0123456789")
        
        let billFormatter = NumberFormatters.formatter
        
        
        
        if string.rangeOfCharacter(from: numbersOnly.inverted) != nil {
            return false
        }
        
        
        return true
        
    }
    
}
