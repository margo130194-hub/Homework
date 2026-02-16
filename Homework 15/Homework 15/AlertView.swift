//
//  AlertView.swift
//  Homework 15
//
//  Created by Margarita Matsonko on 14/02/2026.
//

import UIKit

class AlertView: UIView  {
    
    private let someView = UIView()
    private let label = UILabel()
    private let header = UILabel()
    private let OkButton = UIButton(type: .system)
    private let CloseButton = UIButton(type: .system)
    private let stackView = UIStackView()
    
    
    override init(frame: CGRect) {
            super.init(frame: frame)
            setupSubview()
            setupConstraints()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    
    
    private func setupViewProperties(){
        
    }
    
    private  func setupSubview(){
        self.backgroundColor = .clear
        
        let blurEffect = UIBlurEffect(style: .systemChromeMaterialDark)
        let blur = UIVisualEffectView(effect: blurEffect)
        blur.translatesAutoresizingMaskIntoConstraints = false
        addSubview(blur)
        NSLayoutConstraint.activate([
            blur.topAnchor.constraint(equalTo: topAnchor),
            blur.bottomAnchor.constraint(equalTo: bottomAnchor),
            blur.leadingAnchor.constraint(equalTo: leadingAnchor),
            blur.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        
        someView.backgroundColor = .white
        someView.layer.cornerRadius = 10
        someView.translatesAutoresizingMaskIntoConstraints = false
        someView.layer.borderWidth = 0.8
        someView.layer.borderColor = UIColor.black.cgColor
        someView.layer.shadowOffset = CGSize(width: 2, height: 6)
        someView.layer.shadowColor = UIColor.black.cgColor
        someView.layer.shadowOpacity = 0.8
        someView.layer.masksToBounds = false
        
        addSubview(someView)
        
        header.text = "KABOOM! 🧨"
        header.textColor = .black
        header.font = UIFont(name: "ChalkboardSE-Bold", size: 20)
        header.translatesAutoresizingMaskIntoConstraints = false
    
        label.text = " Dee Dee, Marky, and Joey just raided your fridge and messed up the screen! Everything is blurred until you chase them away."
        label.font = UIFont(name: "ChalkboardSE", size: 20)
        label.textColor = .black
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .justified
        
        OkButton.setTitle("CALL JACK", for: .normal)
        OkButton.titleLabel?.font = UIFont(name: "ChalkboardSE-Bold", size: 11)
        OkButton.setTitleColor(.white, for: .normal)
        OkButton.backgroundColor = .systemGreen
        OkButton.layer.cornerRadius = 4
        OkButton.translatesAutoresizingMaskIntoConstraints = false
        OkButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        CloseButton.setTitle(" USE THE FLY SWATTER", for: .normal)
        CloseButton.titleLabel?.font = UIFont(name: "ChalkboardSE-Bold", size: 11)
        CloseButton.setTitleColor(.white, for: .normal)
        CloseButton.backgroundColor = .systemRed
        CloseButton.layer.cornerRadius = 4
        CloseButton.translatesAutoresizingMaskIntoConstraints = false
        CloseButton.addTarget(self, action: #selector(buttonFlatterAction), for: .touchUpInside)
        
        
        stackView.axis = .horizontal
        stackView.spacing = 30
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        [OkButton, CloseButton].forEach{
            stackView.addArrangedSubview($0)
        }
        
        someView.addSubview(label)
        someView.addSubview(header)
        someView.addSubview(stackView)
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            
            someView.centerXAnchor.constraint(equalTo: centerXAnchor),
            someView.centerYAnchor.constraint(equalTo: centerYAnchor),
            someView.widthAnchor.constraint(equalToConstant: 350),
            someView.heightAnchor.constraint(equalToConstant: 250),
            
            label.topAnchor.constraint(equalTo: header.bottomAnchor, constant: 10),
            label.leadingAnchor.constraint(equalTo: someView.leadingAnchor, constant: 30),
            label.trailingAnchor.constraint(equalTo: someView.trailingAnchor, constant: -30),
            
            header.topAnchor.constraint(equalTo: someView.topAnchor, constant: 30),
            header.centerXAnchor.constraint(equalTo: someView.centerXAnchor),
            
            stackView.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: someView.leadingAnchor, constant: 30),
            stackView.trailingAnchor.constraint(equalTo: someView.trailingAnchor, constant: -30),
            stackView.bottomAnchor.constraint(equalTo: someView.bottomAnchor, constant: -30)
            
            ])
    }
    private func shakeView(_ viewToShake: UIView){
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: .linear)
        animation.duration = 0.5
        animation.values = [-20, 20, -15, 15, -10, 10, -5, 5, 0]
        viewToShake.layer.add(animation, forKey: "shake")
    }
    
    @objc private func buttonTapped(){
        UIView.animate(withDuration: 0.2, animations: {
            self.alpha = 0
            
        }){_ in
            self.isHidden = true
            self.backgroundColor = .clear
        }
    }
    
    @objc private func buttonFlatterAction(){
        shakeView(someView)
        
        UIView.animate(withDuration: 0.2){
            self.backgroundColor = .red
        }
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
            self.buttonTapped()
        }
    }
}

//#Preview {
//    AlertViewController()
//}
