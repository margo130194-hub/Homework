//
//  ViewController.swift
//  Homework 10
//
//  Created by Margarita Matsonko on 27/01/2026.
//

import UIKit

class MyData {
    
    var name: String
    var age: Int
    var place: String
    var occupation: String
    
    init(name: String, age: Int, place: String, occupation: String) {
        self.name = name
        self.age = age
        self.place = place
        self.occupation = occupation
    }
}


class ViewController: UIViewController {

    
    private let buttonForLabel = UIButton(type: .system)
    private let buttonForClass = UIButton(type: .system)
    private let stackView = UIStackView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubview()
        setupConstreints()
        setupProperties()
        setupStackView()
    
    }
    private func setupProperties(){
        view.backgroundColor = .systemBackground
    }
    private func setupSubview(){
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        
        buttonForClass.setTitle("Class", for: .normal)
        buttonForLabel.addTarget(self, action: #selector(buttonForLabelTapped), for: .touchUpInside)
        buttonForClass.addTarget(self, action: #selector(buttonForClassTapped), for: .touchUpInside)
        buttonForLabel.setTitle("Label", for: .normal)
        [buttonForClass, buttonForLabel].forEach{
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.setTitleColor(.white, for: .normal)
            $0.backgroundColor = .systemBlue
            $0.layer.cornerRadius = 10
            stackView.addArrangedSubview($0)
        }
        
        
    }
    private func setupStackView(){
        stackView.axis = .vertical
        stackView.spacing = 15
        stackView.alignment = .fill
        stackView.distribution = .fill
    }
    private func setupConstreints(){
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),

            
            
        ])
    }
    @objc private func buttonForLabelTapped(){
        let vc = SecondViewController()
        vc.stringFromvc = "It was hard"
        navigationController?.pushViewController(vc, animated: true)
    }
    @objc private func buttonForClassTapped(){
        let vc = SecondViewController()
        let person = MyData(name: "Margarita", age: 32, place: "Gdynia", occupation: "cook")
        vc.myObject = person
        navigationController?.pushViewController(vc, animated: true)
    }
}

