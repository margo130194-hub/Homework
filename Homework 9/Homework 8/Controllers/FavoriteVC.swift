//
//  FavoriteVC.swift
//  Homework 8
//
//  Created by Margarita Matsonko on 26/01/2026.
//

import UIKit
class FavoriteViewController: UIViewController {
    private let bookImage = UIImageView()
    private let labelPrince = UILabel()
    private let labelSunrise = UILabel()
    private let labelPride = UILabel()
    private let labelJane = UILabel()
    private let stackView = UIStackView()
    override func viewDidLoad(){
        super.viewDidLoad()
        
        bookImage.image = UIImage(named: "favorite")
        bookImage.contentMode = .scaleAspectFill
        bookImage.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        labelJane.text = "**Jane Eyer by Charlotte Brontë**"
        labelPride.text = "**Pride and Prejudice by Jane Austen**"
        labelPrince.text = "**The little prince by Antoine de Saint-Exupéry**"
        labelSunrise.text = "**Sunrise on the Reaping by Suzanne Collins**"
        
        [labelJane, labelPride, labelPrince, labelSunrise].forEach{
            $0.textColor = .white
            $0.font = .boldSystemFont(ofSize: 30)
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.numberOfLines = 0
            stackView.addArrangedSubview($0)
        }
        
        view.addSubview(bookImage)
        view.addSubview(stackView)
        
        
        NSLayoutConstraint.activate([
            bookImage.topAnchor.constraint(equalTo: view.topAnchor),
            bookImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bookImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bookImage.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30)
            
        ])
    }
}

