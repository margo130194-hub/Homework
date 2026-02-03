//
//  ViewController.swift
//  Homework 11
//
//  Created by Margarita Matsonko on 29/01/2026.
//

import UIKit

class ViewController: UIViewController {
    
    private let buttons = ["AC","7","4", "1","0", "%","8","5","2","<-", "3","6","9",".","-","+", "=", "*", "/"]
    private let horizontalStackView1 = UIStackView()
    private let horizontalStackView2 = UIStackView()
    private let horizontalStackView3 = UIStackView()
    private let horizontalStackView4 = UIStackView()
    private let horizontalStackView5 = UIStackView()
    private let label  = UILabel()
    private let verticalStackView = UIStackView()
    private var number: Double = 0
    private var operation: String = ""
    private var result: Double = 0
    private var isTyping: Bool = false
    private var realButtons:[UIButton] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewProperties()
        setupSubview()
        setupLabel()
        setupConctraints()
        
    }
    
    private func setupViewProperties(){
        view.backgroundColor = .black
    }
    
    private  func setupSubview(){
        
        realButtons = buttons.map { title in
            let button = UIButton(type: .system)
            button.setTitle(title, for: .normal)
            button.titleLabel?.font =  .systemFont(ofSize: 30, weight: .medium)
            button.setTitleColor(.white, for: .normal)
            button.backgroundColor = UIColor(named: "my color")
            button.clipsToBounds = true
            button.translatesAutoresizingMaskIntoConstraints = false
            button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
            
            return button
        }
        
        [realButtons[0],realButtons[5],realButtons[9], realButtons[14]].forEach{
            $0.widthAnchor.constraint(equalToConstant: 80).isActive = true
            $0.heightAnchor.constraint(equalToConstant: 80).isActive = true
            $0.layer.cornerRadius = 40
        
            horizontalStackView1.addArrangedSubview($0)
        }
        
        [realButtons[1],realButtons[6],realButtons[12], realButtons[17]] .forEach{
            $0.widthAnchor.constraint(equalToConstant: 80).isActive = true
            $0.heightAnchor.constraint(equalToConstant: 80).isActive = true
            $0.layer.cornerRadius = 40
            horizontalStackView2.addArrangedSubview($0)
        }
        
        [realButtons[2],realButtons[7],realButtons[11], realButtons[15]].forEach{
            $0.widthAnchor.constraint(equalToConstant: 80).isActive = true
            $0.heightAnchor.constraint(equalToConstant: 80).isActive = true
            $0.layer.cornerRadius = 40
            horizontalStackView3.addArrangedSubview($0)
        }
        
        [realButtons[3], realButtons[8], realButtons[10], realButtons[16]].forEach{
            $0.widthAnchor.constraint(equalToConstant: 80).isActive = true
            $0.heightAnchor.constraint(equalToConstant: 80).isActive = true
            $0.layer.cornerRadius = 40
            horizontalStackView4.addArrangedSubview($0)
        }
        
        [realButtons[0],realButtons[5],realButtons[9], realButtons[14]].forEach{
            $0.backgroundColor = UIColor(named: "my color 2")
            $0.setTitleColor(.white, for: .normal)
        }
        
        [realButtons[4],realButtons[13],realButtons[18]].forEach{
            $0.layer.cornerRadius = 40
            horizontalStackView5.addArrangedSubview($0)
        }
        
        realButtons[4].widthAnchor.constraint(equalTo: realButtons[13].widthAnchor, multiplier: 2, constant: 15).isActive = true
        [realButtons[18], realButtons[13]].forEach{
            $0.widthAnchor.constraint(equalToConstant: 80).isActive = true
            $0.heightAnchor.constraint(equalToConstant: 80).isActive = true
            $0.layer.cornerRadius = 40
        }
        realButtons[18].widthAnchor.constraint(equalTo: realButtons[13].widthAnchor).isActive = true
        realButtons[18].heightAnchor.constraint(equalTo: realButtons[13].heightAnchor).isActive = true
        
        horizontalStackView5.distribution = .equalSpacing
        horizontalStackView5.spacing = 15
        
        [realButtons[14], realButtons[17], realButtons[15], realButtons[16], realButtons[18]].forEach{
            $0.backgroundColor = UIColor(named: "my orange")
        }
        
        [horizontalStackView1, horizontalStackView2, horizontalStackView3, horizontalStackView4].forEach { stackView in
            stackView.axis = .horizontal
            stackView.spacing = 15
            stackView.alignment = .center
            stackView.distribution = .equalSpacing
            stackView.translatesAutoresizingMaskIntoConstraints = false
            verticalStackView.addArrangedSubview(stackView)
        }
        verticalStackView.addArrangedSubview(horizontalStackView5)
        
        verticalStackView.axis = .vertical
        verticalStackView.spacing = 7
        verticalStackView.alignment = .center
        verticalStackView.distribution = .equalSpacing
        verticalStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(verticalStackView)
        
    }
    private func  setupLabel(){
        label.backgroundColor = .black
        label.textColor  = .white
        label.text = "0"
        label.font = .systemFont(ofSize: 90, weight: .medium)
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
    }
    
    private func setupConctraints(){
        NSLayoutConstraint.activate([
            verticalStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            verticalStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            verticalStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            
            label.bottomAnchor.constraint(equalTo: verticalStackView.topAnchor),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
        ])
    }
    
    @objc func buttonTapped(_ sender: UIButton){
        percentage(sender)
        delete(sender)
        removeLast(sender)
        delete(sender)
        doubleNum(sender)
        operations(sender)
    }
    
    private  func percentage(_ sender: UIButton){
        guard let buttonTitle = sender.currentTitle else {return}
        if buttonTitle == "%"{
            if let currentText = label.text, let valueNumber = Double(currentText){
                let percentage = (valueNumber/100)
                label.text = "\(percentage)"
                isTyping = false
            }
            return
        }
    }
    
    private  func delete (_ sender: UIButton){
        guard let buttonTitle = sender.currentTitle else {return}
        if buttonTitle == "AC" {
            label.text = "0"
            operation = ""
            number = 0
            isTyping = false
            return
        }
    }
    
    private func removeLast(_ sender: UIButton){
        guard let buttonTitle = sender.currentTitle else {return}
        if buttonTitle == "<-"{
            guard let text = label.text else {return}
            if text.count > 1{
                label.text?.removeLast()
                return
            }
            else {
                label.text = "0"
                isTyping = false
            }
            return
        }
    }
    
    private  func operations (_ sender: UIButton){
        guard let buttonTitle = sender.currentTitle else {return}
        if ["+", "-","*","/"].contains(buttonTitle){
            if let currentText = label.text{
                if let firstNumber = Double(currentText){
                    number = firstNumber
                }
            }
            operation = buttonTitle
            isTyping = false
            return }
        
        if buttonTitle == "="{
            if let currenText = label.text{
                if let valueNumber = Double(currenText){
                    result = valueNumber
                    isTyping = false
                    
                    switch operation {
                    case "+":
                        result += number
                    case "-":
                        result -= number
                    case "*":
                        result *= number
                    case "/":
                        result = (valueNumber != 0) ? (number / valueNumber) : 0
                    default:
                        result = number
                    }
                    
                    
                    if result.truncatingRemainder(dividingBy: 1) == 0{
                        label.text = "\(Int(result))"}
                    else {
                        label.text = "\(result)"
                    }
                    return
                }
            }
        }
    }
    
    private func doubleNum (_ sender: UIButton){
        guard let buttonTitle = sender.currentTitle else {return}
        guard Int(buttonTitle) != nil || buttonTitle == "." else {return}
        if isTyping {
            if buttonTitle == "."{
                if label.text?.contains(".") == true{ return }
                label.text? += "."
            } else {
                label.text? += buttonTitle
            }
        } else {
            if buttonTitle == "."{
                label.text = "0."
            } else {
                label.text = buttonTitle
            }
            isTyping = true
        }
    }
    
}


//    #Preview {
//        ViewController()
//    }




