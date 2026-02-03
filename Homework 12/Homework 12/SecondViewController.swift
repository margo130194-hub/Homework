//
//  SecondViewController.swift
//  Homework 12
//
//  Created by Margarita Matsonko on 03/02/2026.
//

import UIKit

protocol SecondViewControllerDelegate: AnyObject{
    func transfer(text: String)
}

class SecondViewController: UIViewController {
    
    weak var delegate: SecondViewControllerDelegate?
    private let button = UIButton(type: .system)
    private let textField = UITextField()
    private let secondTextField = UITextField()
    private let thirdTextField = UITextField()
    private let stackView = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubview()
        setupConctraints()
        setupViewProperties()
    }
    
    private func setupViewProperties(){
        view.backgroundColor = UIColor(named: "rose")
    }
    
    private  func setupSubview(){
        button.setTitle("Save", for: .normal)
        button.backgroundColor  = UIColor(named: "rose2")
        button.setTitleColor(UIColor(named: "my color"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 10
        button.clipsToBounds  = true
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        [textField, secondTextField, thirdTextField].forEach{
            $0.borderStyle = .roundedRect
            $0.backgroundColor = UIColor(named: "rose2")
            $0.textColor = UIColor(named: "my color")
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.text = ""
            stackView.addArrangedSubview($0)
        }
        textField.placeholder = "Enter your name..."
        secondTextField.placeholder = "Enter you surname..."
        thirdTextField.placeholder = "Enter your age..."
        
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 40
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(button)
        view.addSubview(stackView)
        
    }
    
    private func setupConctraints(){
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            button.widthAnchor.constraint(equalToConstant: 110),
            button.heightAnchor.constraint(equalToConstant: 60),
            
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 200)
        ])
    }
    
    @objc private func buttonTapped(){
        delegate?.transfer(text: "Hello \(textField.text ?? " ") \(secondTextField.text ??  " "). You are \(thirdTextField.text ?? " ") years old.")
        navigationController?.popViewController(animated: true)
    }
}


