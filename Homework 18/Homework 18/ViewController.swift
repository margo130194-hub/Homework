//
//  ViewController.swift
//  Homework 18
//
//  Created by Margarita Matsonko on 26/02/2026.
//
import UIKit

final class ViewController: UIViewController {
    
    // MARK: - Subviews
    private let label = UILabel()
    private let textField = UITextField()
    private let button = ButtonView()
    private let stackView = UIStackView()
    private var stackViewConstraintsY: NSLayoutConstraint?
    private var stackViewConstraintsX: NSLayoutConstraint?
    
    // MARK: - Lyfecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNotifications()
        setupViewProperties()
        setupSubviews()
        setupConstraints()
        textField.becomeFirstResponder()
        
    }
    
    // MARK: - Layout
    
    private func setupNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing(_:)))
        view.addGestureRecognizer(tap)
    }
    private func setupViewProperties() {
        view.backgroundColor = .darkGray
    }
    
    private func setupSubviews() {
        label.text = "Enter something"
        label.textColor = .systemMint
        label.font = .systemFont(ofSize: 30, weight: .bold)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        
        textField.placeholder = "type ..."
        textField.borderStyle = .roundedRect
        textField.clearButtonMode = .whileEditing
        textField.textColor = .black
        textField.backgroundColor = .white
        textField.translatesAutoresizingMaskIntoConstraints = false
        addIcon(textField: textField, image: "pencil.and.scribble")
        textField.isUserInteractionEnabled = true
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.axis = .vertical
        stackView.spacing = 60
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        [label, textField, button].forEach{
            stackView.addArrangedSubview($0)
        }
        view.addSubview(stackView)
        
    }
    
    private func setupConstraints() {
        
        stackViewConstraintsY = stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        stackViewConstraintsX = stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        guard let stackViewConstraintsY, let stackViewConstraintsX else {return}
        
        NSLayoutConstraint.activate([
            stackViewConstraintsY,
            stackViewConstraintsX,
            stackView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7)
        ])
    }
    
    private func addIcon(textField: UITextField, image: String){
        let iconImage = UIImageView(frame: CGRect(x: 10, y: 0, width: 30, height: 30))
        iconImage.image = UIImage(systemName: image)
        iconImage.contentMode = .scaleAspectFit
        
        textField.leftViewMode = .always
        textField.leftView = iconImage
    }
    
    @objc private func keyboardWillShow( notification: NSNotification) {
        if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardHeight = keyboardFrame.cgRectValue.height
            stackViewConstraintsY?.constant = -(keyboardHeight/2)
            animateLayout(notification: notification)
        }
    }
    @objc private func keyboardWillHide( notification: NSNotification) {
        stackViewConstraintsY?.constant = 0
        animateLayout(notification: notification)
    }
    
    private func  animateLayout( notification: NSNotification){
        let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double ?? 0.3
        UIView.animate(withDuration: duration){
            self.view.layoutIfNeeded()
        }
    }
}
