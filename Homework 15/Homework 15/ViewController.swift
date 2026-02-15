//
//  ViewController.swift
//  Homework 15
//
//  Created by Margarita Matsonko on 13/02/2026.
//

import UIKit

class ViewController: UIViewController {
    
    private let button = UIButton(type: .system)
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
        image.image = UIImage(named: "oggy")
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        
        
        button.setTitle("OPEN THE FRIDGE", for: .normal)
        button.titleLabel?.font = UIFont(name: "ChalkboardSE-Bold", size: 20)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .clear
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        
        
        view.addSubview(image)
        view.addSubview(button)
        
    }
    
    private func setupConctraints(){
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: view.topAnchor),
            image.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            image.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            image.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            button.heightAnchor.constraint(equalToConstant: 60),
            button.widthAnchor.constraint(equalToConstant: 180)
            
        ])
    }
    
    @objc private func buttonTapped(){
        let vc = AlertViewController()
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .crossDissolve
        
        present(vc, animated: true)
    }
}

//#Preview {
//    ViewController()
//}
