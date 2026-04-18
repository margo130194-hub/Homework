//
//  UsersInfoViewController.swift
//  Homework 31
//
//  Created by Margarita Matsonko on 17/04/2026.
//



import UIKit

final class UsersInfoViewController: UIViewController {
    
    // MARK: - Subviews
    private let infoLabel = UILabel()
    var user: Users?
    
    
    // MARK: - Lyfecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewProperties()
        setupSubviews()
        setupConstraints()
        configureInfo()
    }
    
    // MARK: - Layout
    private func setupViewProperties() {
        view.backgroundColor = .white
    }
    
    private func setupSubviews() {
        infoLabel.font = .systemFont(ofSize: 17, weight: .medium)
        infoLabel.textColor = .black
        infoLabel.numberOfLines = 0
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(infoLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            infoLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            infoLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            infoLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            infoLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40)
        ])
    }
    func configureInfo(){
        guard let user = user else {return}
        infoLabel.text = """
        💁 Name: \(user.name)
        😎 User name: \(user.username)
        📧 Email: \(user.email)
        🏠 Address: \(user.address.city), \(user.address.street)
        📞 Phone: \(user.phone)
        🛜 Website: \(user.website)
        💼 Company: \(user.company.name)
        """
    }
}

