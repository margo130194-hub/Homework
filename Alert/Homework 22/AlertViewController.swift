//
//  ViewController.swift
//  Homework 22
//
//  Created by Margarita Matsonko on 14/03/2026.
//

import UIKit

final class AlertViewController: UIViewController {
    
    // MARK: - Subviews
    let image = UIImageView()
    let button = UIButton(type: .system)
    let message = UILabel()
    
    // MARK: - Lyfecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewProperties()
        setupSubviews()
        setupConstraints()
    }
    
    // MARK: - Layout
    private func setupViewProperties() {
        
    }
    
    private func setupSubviews() {
        image.image = UIImage(named: "doc")
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(image)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Red tape", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .red
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(pressButton), for: .touchUpInside)
        view.addSubview(button)
        
        message.textColor = .systemRed
        message.translatesAutoresizingMaskIntoConstraints = false
        message.alpha = 0
        message.font = .systemFont(ofSize: 30, weight: .bold)
        message.numberOfLines = 0
        message.textAlignment = .center
        view.addSubview(message)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: view.topAnchor),
            image.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            image.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            image.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
            button.widthAnchor.constraint(equalToConstant: 130),
            button.heightAnchor.constraint(equalToConstant: 40),
            
            message.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            message.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            message.widthAnchor.constraint(equalToConstant: 300),
            message.heightAnchor.constraint(equalToConstant: 150),
            
        ])
    }
    
    @objc private func pressButton(){
        let alert = UIAlertController(
            title: "Form No 4657-B",
            message: "Your request to perform the operation has been accepted for consideration. Please confirm that you are the owner of the finger that pressed the button.",
            preferredStyle: .alert)
        
        let closeAction = UIAlertAction(title: "I've changed my mind", style: .destructive)
        { _ in
            self.showMessage("✨Congratulations! You are free from the red tape!✨")
        }
        
        let action = UIAlertAction(title: "Department Hotline", style: .default)
        { _ in
            let secondAlert = UIAlertController(
                title: "Stay on the line",
                message: "Thank you for choosing our department. All our operators are busy. We will call you later!",
                preferredStyle: .alert)
            
            let close = UIAlertAction(title: "Close this shit", style: .destructive)
            { _ in
                self.showMessage("Ohh...You are leaving. Boo-hoo 🤧")
            }
            
            let waitAction = UIAlertAction(title: "Wait...", style: .default){ _ in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                    let thirdAlert = UIAlertController(
                        title: "Ops. Nobody is at home",
                        message: "Hello! It's lunch time.Do not bother us! Go away!!!",
                        preferredStyle: .alert)
                    
                    let closeAction = UIAlertAction(title: "Leave and be free", style: .destructive){
                        _ in
                        self.showMessage("You are free poor bunny!")
                    }
                    thirdAlert.addAction(closeAction)
                self.present(thirdAlert, animated: true)
                }
            }
            
            secondAlert.addAction(close)
            secondAlert.addAction(waitAction)
            self.present(secondAlert, animated: true)
        }
        alert.addAction(closeAction)
        alert.addAction(action)
        self.present(alert, animated: true)
        
    }
    
    private func showMessage(_ text: String){
        message.text = text
        
        UIView.animate(withDuration: 0.2){
            self.message.alpha = 1
            self.image.alpha = 0.3
        }
        completion: { _ in
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0){
                UIView.animate(withDuration: 0.2){
                    self.message.alpha = 0
                    self.image.alpha = 1
                }
                
            }
           
        }
        
    }
}

