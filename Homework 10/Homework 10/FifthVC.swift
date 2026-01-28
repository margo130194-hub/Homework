//
//  FifthVC.swift
//  Homework 10
//
//  Created by Margarita Matsonko on 27/01/2026.
//

import UIKit

class FifthViewController: UIViewController {

    var stringFromvc: String?
    let text = UILabel()
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
        text.text = stringFromvc
        text.font = .boldSystemFont(ofSize: 30)
        text.textAlignment = .center
        text.textColor = .purple
        text.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(text)
    }
    private func setupConstreints(){
        NSLayoutConstraint.activate([
            text.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            text.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            text.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
            
        ])
    }
        
    }


