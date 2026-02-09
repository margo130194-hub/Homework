//
//  SecondVC.swift
//  Homework 13
//
//  Created by Margarita Matsonko on 09/02/2026.
//
import UIKit

class SecondVC: UIViewController {
    
    private let label = UILabel()
    private let button =  UIButton(type: .system)
    private let nameField = UITextField()
    private let phoneField = UITextField()
    private let nameLabel = UILabel()
    private let phoneLabel = UILabel()
    private let stackView = UIStackView()
    private let image = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubview()
        setupConctraints()
        setupViewProperties()
    }
    
    private func setupViewProperties(){
       
    }
    
    private  func setupSubview(){
        
        image.image = UIImage(named: "background")
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(image)
        
        
        label.text = "Have questions about this tour? Leave your details, and our travel expert will call you back shortly."
        label.textColor = .black
        label.font = .systemFont(ofSize: 25, weight: .semibold)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(label)
        
        [nameField, phoneField].forEach{
            $0.textColor = .black
            $0.borderStyle = .roundedRect
            $0.widthAnchor.constraint(equalToConstant: 220).isActive = true
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        nameField.placeholder = "Enter your name"
        phoneField.placeholder = "Enter your pnone"
        
        
        
        [nameLabel, phoneLabel].forEach{
            $0.textColor = .black
            $0.font = .systemFont(ofSize: 17)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        nameLabel.text = "Name"
        phoneLabel.text = "Phone"
        
        button.setTitle("Call me back", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        
       
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.distribution = .fill
        stackView.alignment = .leading
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        [nameLabel, nameField, phoneLabel,  phoneField].forEach{
            stackView.addArrangedSubview($0)
        }
        view.addSubview(stackView)
        view.addSubview(button)
    }
    
    private func setupConctraints(){
        NSLayoutConstraint.activate([
            
            image.topAnchor.constraint(equalTo: view.topAnchor),
            image.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            image.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            image.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            label.widthAnchor.constraint(equalToConstant: 220),
            
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 50),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -60),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 80),
            
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 40),
            button.widthAnchor.constraint(equalToConstant: 150),
            button.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}


