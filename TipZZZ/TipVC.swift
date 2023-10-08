//
//  TipVC.swift
//  TipZZZ
//
//  Created by Ilya Rzheznikov on 24/09/2023.
//

import UIKit

class TipVC: UIViewController, UITextFieldDelegate {
    
    let enterBill = TipLabel(fontSize: 19)
    let billAmountTF = UITextField()
    let tipSlider = UISlider()
    let tipAmountLabel = TipLabel(fontSize: 15)
    let tipNumAmountLabel = TipLabel(fontSize: 13)
    let totalWithTipLabel = TipLabel(fontSize: 19)
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        billAmountTF.delegate = self
        configureUI()
        
       
        
        
        // Do any additional setup after loading the view.
    }
    
    // Configuration Sheet
    func configureUI(){
        createEnterBill()
        createBillAmount()
        createTipAmount()
        createTipSlider()
        createTipNumLabel()
        createTotalWithTip()
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
        view.addSubview(billAmountTF)
        billAmountTF.translatesAutoresizingMaskIntoConstraints = false
        billAmountTF.keyboardType = .numberPad
        billAmountTF.textColor = .systemGray
        billAmountTF.font = .systemFont(ofSize: 50, weight: .bold)
        billAmountTF.textAlignment = .center
        billAmountTF.placeholder = "..."
        NSLayoutConstraint.activate([
            billAmountTF.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            billAmountTF.topAnchor.constraint(equalTo: enterBill.bottomAnchor, constant: 20),
            billAmountTF.widthAnchor.constraint(equalToConstant: 200)
        ])
        billAmountTF.addTarget(self, action: #selector(TipVC.textFieldDidChange(_:)), for: .editingChanged)
        
    }
    

    
    func createTipAmount(){
        view.addSubview(tipAmountLabel)
        tipAmountLabel.text = "Tip value: 0%"
        NSLayoutConstraint.activate([
            tipAmountLabel.topAnchor.constraint(equalTo: billAmountTF.bottomAnchor, constant: 50),
            tipAmountLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        
        ])
    
    }
    
    func createTipSlider(){
        view.addSubview(tipSlider)
        tipSlider.translatesAutoresizingMaskIntoConstraints = false
        tipSlider.maximumValue = 100
        tipSlider.minimumValue = 0
        tipSlider.value = 0
        tipSlider.isContinuous = false
        NSLayoutConstraint.activate([
            tipSlider.widthAnchor.constraint(equalToConstant: 250),
            tipSlider.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tipSlider.topAnchor.constraint(equalTo: tipAmountLabel.bottomAnchor, constant: 50)
        ])
        tipSlider.addTarget(self, action: #selector(TipVC.generateTipPercent(_:)), for: .valueChanged )
       
    }
    
    func createTipNumLabel(){
        view.addSubview(tipNumAmountLabel)
        tipNumAmountLabel.text = "Tip: 0"
        NSLayoutConstraint.activate([
            tipNumAmountLabel.topAnchor.constraint(equalTo: tipSlider.bottomAnchor, constant: 50),
            tipNumAmountLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        
        ])
    }
    func createTotalWithTip(){
        view.addSubview(totalWithTipLabel)
        totalWithTipLabel.text = "Total with Tip:"
        NSLayoutConstraint.activate([
            totalWithTipLabel.topAnchor.constraint(equalTo: tipNumAmountLabel.bottomAnchor, constant: 50),
            totalWithTipLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        
        ])
    }
    
    // Methods
//    func textFieldDidEndEditing(_ textField: UITextField) {
//        let amountIfZero = (Int(textField.text?.replacingOccurrences(of: ",", with: "") ?? "0") ?? 0)
//        if amountIfZero == 0 {
//            calculateTip(amountIfZero, amountIfZero)
//        }
            
//    }
    
    func textField(
        _ textField: UITextField,
        shouldChangeCharactersIn range: NSRange,
        replacementString string: String
    ) -> Bool {
        
        let numbersOnly = CharacterSet(charactersIn: "0123456789")
        if string.rangeOfCharacter(from: numbersOnly.inverted) != nil {
            return false
        }
        
        
        return true
        
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        let currentText = (textField.text?.replacingOccurrences(of: ",", with: "") ?? "0")
        if let value = Int(currentText) {
            let formattedNumber = NumberFormatters.formatter.string(
                from: NSNumber(value: value)
            )
            textField.text = formattedNumber
            calculateTip(value, Int(tipSlider.value))
        }
    }
    
    @objc func generateTipPercent (_ slider: UISlider) {
        let roundedValue = round(slider.value / 5) * 5
        slider.setValue(roundedValue, animated: true)
        tipAmountLabel.text  = "Tip percentage: \(Int(roundedValue))%"
        let currentText = (billAmountTF.text?.replacingOccurrences(of: ",", with: "") ?? "")
        if let value = Int(currentText) {
            calculateTip(value, Int(slider.value))
        }
        
    }
    
    func calculateTip (_ number: Int, _ percent: Int ) {
        let tip = number * percent / 100
        let principal = (billAmountTF.text?.replacingOccurrences(of: ",", with: "") ?? "0")
        tipNumAmountLabel.text = "Tip: \(NumberFormatters.formatter.string(from: NSNumber(value:tip)) ?? "NA")"
        if let value = Int(principal) {
            totalWithTipLabel.text = "Total with Tip: \(NumberFormatters.formatter.string(from: NSNumber(value: value + tip)) ?? "0")"
        } else {
            totalWithTipLabel.text = "Total with Tip: 0"
        }
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            view.endEditing(true)
        }
        

    
}
