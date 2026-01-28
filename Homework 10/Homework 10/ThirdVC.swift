//
//  ThirdVC.swift
//  Homework 10
//
//  Created by Margarita Matsonko on 27/01/2026.
//

import UIKit

class ThirdViewController: UIViewController {
    
    var stringFromvc: String?
    private let buttonForLabel = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubview()
        setupProperties()
        setupConstreints()
    }
    
    private func setupProperties(){
        view.backgroundColor = .systemBackground
    }
    private func setupSubview(){
        buttonForLabel.setTitle("Tap me again", for: .normal)
        buttonForLabel.translatesAutoresizingMaskIntoConstraints = false
        buttonForLabel.setTitleColor(.white, for: .normal)
        buttonForLabel.backgroundColor = .systemBlue
        buttonForLabel.layer.cornerRadius = 10
        view.addSubview(buttonForLabel)
        buttonForLabel.addTarget(self, action: #selector(nextTap), for: .touchUpInside)
    }
    private func setupConstreints(){
        NSLayoutConstraint.activate([
            buttonForLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            buttonForLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            buttonForLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
            
        ])
    }
    @objc func nextTap(){
        let vc = ForthViewController()
        vc.stringFromvc = self.stringFromvc
        navigationController?.pushViewController(vc, animated: true)
    }
}
