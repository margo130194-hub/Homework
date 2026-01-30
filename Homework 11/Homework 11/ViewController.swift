//
//  ViewController.swift
//  Homework 11
//
//  Created by Margarita Matsonko on 29/01/2026.
//

import UIKit

class ViewController: UIViewController {
    
    private let buttons = ["AC","7","4", "1","{}", "%","8","5","2","0","<-","3","6","9",".","-","+", "=", "*", "/"]
    private let verticalStackView1 = UIStackView()
    private let verticalStackView2 = UIStackView()
    private let verticalStackView3 = UIStackView()
    private let verticalStackView4 = UIStackView()
    private let label  = UILabel()
    private let horizontalStackView = UIStackView()
    private var number: Double = 0
    private var operation: String = ""
    private var result: Double = 0
    private var isTyping: Bool = false
    
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
        let realButtons:[UIButton]  =  buttons.map { title in
            let button = UIButton(type: .system)
            button.setTitle(title, for: .normal)
            button.titleLabel?.font =  .systemFont(ofSize: 30, weight: .medium)
            button.setTitleColor(.white, for: .normal)
            button.backgroundColor = .systemCyan
            button.heightAnchor.constraint(equalTo: button.widthAnchor).isActive = true
            button.clipsToBounds = true
            button.layer.cornerRadius = 35
            button.translatesAutoresizingMaskIntoConstraints = false
            button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
            
            return button
        }
        realButtons[0...4].forEach{
            verticalStackView1.addArrangedSubview($0)
        }
        realButtons[5...9].forEach{
            verticalStackView2.addArrangedSubview($0)
        }
        realButtons[10...14].forEach{
            verticalStackView3.addArrangedSubview($0)
        }
        realButtons[15...19].forEach{
            $0.backgroundColor  = .systemBlue
            verticalStackView4.addArrangedSubview($0)
        }
        [realButtons[0], realButtons[5], realButtons[10], realButtons[15]].forEach{
            $0.backgroundColor = .systemGray2
            
        }
        
        [verticalStackView1, verticalStackView2, verticalStackView3, verticalStackView4].forEach { stackView in
            stackView.axis = .vertical
            stackView.spacing = 10
            stackView.alignment = .fill
            stackView.distribution = .fillEqually
            stackView.translatesAutoresizingMaskIntoConstraints = false
            horizontalStackView.addArrangedSubview(stackView)
        }
        horizontalStackView.axis = .horizontal
        horizontalStackView.spacing = 10
        horizontalStackView.alignment = .fill
        horizontalStackView.distribution = .fillEqually
        horizontalStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(horizontalStackView)
        
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
            horizontalStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 300),
            horizontalStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            horizontalStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            horizontalStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            
            label.bottomAnchor.constraint(equalTo: horizontalStackView.topAnchor),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            //            label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        ])
    }
    
    @objc func buttonTapped(_ sender: UIButton){
        guard let buttonTitle = sender.currentTitle else {return}
        if buttonTitle == "%"{
            if let currentText = label.text, let valueNumber = Double(currentText){
                let percentage = valueNumber/100
                label.text = "\(percentage)"
                isTyping = false
            }
            return
        }
        if buttonTitle == "AC" {
            label.text = "0"
            operation = ""
            number = 0
            isTyping = false
            return
        }
        
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
                    //                }
                    //            }
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


//#Preview {
//   ViewController()
//}




