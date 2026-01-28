//
//  SecondVC.swift
//  Homework 10
//
//  Created by Margarita Matsonko on 27/01/2026.
//

import UIKit

class SecondViewController: UIViewController {

     var stringFromvc: String?
     var myObject: MyData?
    private let buttonForLabel = UIButton(type: .system)
    private let name = UILabel()
    private let age = UILabel()
    private let place  = UILabel()
    private let occupation = UILabel()
    private let stackView = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupProperties()
        setupStackView()
        setupSubview()
        setupConstreints()
        data()
        
    }
    
    private func setupProperties(){
        view.backgroundColor = .systemBackground
    }
    private func data(){

        [name, age, place, occupation].forEach{
            $0.font = .boldSystemFont(ofSize: 30)
            $0.textColor = .black
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.textAlignment = .center
            stackView.addArrangedSubview($0)
        }
        
        guard let data = myObject else {
         return
    }
        name.text = "\(data.name)"
        age.text = "\(data.age)"
        place.text = "\(data.place)"
        occupation.text  = "\(data.occupation)"
        
    }
    private func setupSubview(){
        buttonForLabel.setTitle("Next View Controller", for: .normal)
        buttonForLabel.translatesAutoresizingMaskIntoConstraints = false
        buttonForLabel.setTitleColor(.white, for: .normal)
        buttonForLabel.backgroundColor = .systemBlue
        buttonForLabel.layer.cornerRadius = 10
        view.addSubview(buttonForLabel)
        buttonForLabel.addTarget(self, action: #selector(nextTap), for: .touchUpInside)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
    }
    private func setupStackView(){
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.alignment = .fill
        stackView.distribution = .fill
    }
    private func setupConstreints(){
        NSLayoutConstraint.activate([
            buttonForLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            buttonForLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            buttonForLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -100),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
            
        ])
    }
    @objc func nextTap(){
        let vc = ThirdViewController()
        vc.stringFromvc = self.stringFromvc
        navigationController?.pushViewController(vc, animated: true)
    }
}

