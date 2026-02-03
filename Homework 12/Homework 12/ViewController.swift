//
//  ViewController.swift
//  Homework 12
//
//  Created by Margarita Matsonko on 03/02/2026.
//

import UIKit



class ViewController: UIViewController {
    
    private let label = UILabel()
    private let button = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubview()
        setupConctraints()
        setupViewProperties()
    }
    
    private func setupViewProperties(){
        view.backgroundColor = UIColor(named: "my color")
    }
    
    private  func setupSubview(){
        
        label.textColor = .white
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        
        button.setTitle("Press me", for: .normal)
        button.backgroundColor  = UIColor(named: "rose")
        button.setTitleColor(UIColor(named: "my color"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 10
        button.clipsToBounds  = true
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        view.addSubview(label)
        view.addSubview(button)
    }
    
    private func setupConctraints(){
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            button.widthAnchor.constraint(equalToConstant: 80),
            button.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    @objc private func buttonTapped(){
        let vc = SecondViewController()
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)
    }
}
extension ViewController: SecondViewControllerDelegate{
    func transfer(text: String){
        label.text = text
    }
}

