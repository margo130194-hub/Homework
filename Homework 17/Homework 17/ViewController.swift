//
//  ViewController.swift
//  Homework 17
//
//  Created by Margarita Matsonko on 19/02/2026.
//

import UIKit

class ViewController: UIViewController {
    private let circle = UIView()
    private let upButton = UIButton(type: .system)
    private let downButton = UIButton(type: .system)
    private let rightButton = UIButton(type: .system)
    private let leftButton = UIButton(type: .system)
    private let clearButton = UIButton(type: .system)
    private var circleConstraintsY: NSLayoutConstraint?
    private var circleConstraintsX: NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubview()
        setupConstraints()
        setupViewProperties()
    }
    
    private func setupViewProperties(){
        view.backgroundColor = .black
    }
    
    private  func setupSubview(){
        circle.backgroundColor = .purple
        circle.translatesAutoresizingMaskIntoConstraints = false
        circle.layer.cornerRadius = 50
        circle.layer.borderColor = UIColor.white.cgColor
        circle.layer.borderWidth = 1
        
        [upButton, downButton, rightButton, leftButton, clearButton].forEach {
            $0.backgroundColor  = .clear
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        upButton.setImage(UIImage(systemName: "arrowshape.up.fill"), for: .normal)
        upButton.addTarget(self, action: #selector(upTap), for: .touchUpInside)
        
        downButton.setImage(UIImage(systemName: "arrowshape.down.fill"), for: .normal)
        downButton.addTarget(self, action: #selector(downTap), for: .touchUpInside)
        
        rightButton.setImage(UIImage(systemName: "arrowshape.right.fill"), for: .normal)
        rightButton.addTarget(self, action: #selector(rightTap), for: .touchUpInside)
        
        leftButton.setImage(UIImage(systemName: "arrowshape.left.fill"), for: .normal)
        leftButton.addTarget(self, action: #selector(leftTap), for: .touchUpInside)
        
        clearButton.setImage(UIImage(systemName: "stop.circle.fill"), for: .normal)
        clearButton.addTarget(self, action: #selector(clearTap), for: .touchUpInside)
        
        view.addSubview(circle)
        
    }
    
    private func setupConstraints(){
        
        circleConstraintsY = circle.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        circleConstraintsX = circle.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        guard let circleConstraintsY, let circleConstraintsX else {return}
        
        NSLayoutConstraint.activate([
            circle.widthAnchor.constraint(equalToConstant: 100),
            circle.heightAnchor.constraint(equalToConstant: 100),
            circleConstraintsY,
            circleConstraintsX,
            
            upButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 100),
            upButton.bottomAnchor.constraint(equalTo: clearButton.topAnchor, constant: -5),
            
            downButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 100),
            downButton.topAnchor.constraint(equalTo: clearButton.bottomAnchor, constant: 5),
            
            clearButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 100),
            clearButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -60),
            
            rightButton.leadingAnchor.constraint(equalTo: clearButton.leadingAnchor, constant: 30),
            rightButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -60),
            
            leftButton.trailingAnchor.constraint(equalTo: clearButton.trailingAnchor, constant: -30),
            leftButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -60),
        ])
    }
    
    @objc private func upTap(){
        let steps = 100
        let duration = 4
        let rotation = 5
        let distance = (view.frame.height/2) - view.safeAreaInsets.top - 50
        
        UIView.animateKeyframes(withDuration: TimeInterval(duration), delay: 0, options: .calculationModePaced, animations: {
            for i in 0...steps {
                let time = Double(i) / Double(steps)//i от 0.0(начало) до 1.0(конец)
                let angle = CGFloat(time) * .pi * 2 * CGFloat(rotation)//2пи = 360, 5 полных оборотов
                let radius: CGFloat = sin(CGFloat(time) * .pi) * 100
                let newX = cos(CGFloat(angle)) * radius
                let newY = (CGFloat(time) * -distance) + (sin(CGFloat(angle)) * radius)
                
                UIView.addKeyframe(withRelativeStartTime: time, relativeDuration: 1.0 / Double(steps), animations: {
                    self.circleConstraintsX?.constant = newX
                    self.circleConstraintsY?.constant = newY
                    self.view.layoutIfNeeded()
                })
            }
        },completion: nil)
    }
    @objc private func downTap(){
        let steps = 100
        let duration = 4
        let rotation = 5
        let distance = (view.frame.height/2) - view.safeAreaInsets.bottom - 50
        
        UIView.animateKeyframes(withDuration: TimeInterval(duration), delay: 0, options: .calculationModePaced, animations: {
            for i in 0...steps {
                let time = Double(i) / Double(steps)
                let angle = CGFloat(time) * .pi * 2 * CGFloat(rotation)
                let radius: CGFloat = sin(CGFloat(time) * .pi) * 100
                let newX = cos(CGFloat(angle)) * radius
                let newY = (CGFloat(time) * distance) + (sin(CGFloat(angle)) * radius)
                
                UIView.addKeyframe(withRelativeStartTime: time, relativeDuration: 1.0 / Double(steps), animations: {
                    self.circleConstraintsX?.constant = newX
                    self.circleConstraintsY?.constant = newY
                    self.view.layoutIfNeeded()
                })
            }
        },completion: nil)
    }
    @objc private func rightTap(){
        let rightDistance = (view.frame.width/2) - (circle.frame.width / 2) - 20
        UIView.animate(withDuration: 0.2, animations: {
            self.circle.transform = CGAffineTransform(scaleX: 0.4, y: 0.4)
        }) { _ in
            UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.1,options: .curveEaseInOut, animations: {
                self.circleConstraintsX?.constant = rightDistance
                self.circle.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
                self.view.layoutIfNeeded()
            }) { _ in
                UIView.animate(withDuration: 0.2) {
                    self.circle.transform = .identity
                }
            }
        }
    }
    
    @objc private func leftTap(){
        let leftDistance = -((view.frame.width/2) - (circle.frame.width / 2) - 20)
        UIView.animate(withDuration: 0.2, animations: {
            self.circle.transform = CGAffineTransform(scaleX: 0.4, y: 0.4)
        }) { _ in
            UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.1,options: .curveEaseInOut, animations: {
                self.circleConstraintsX?.constant = leftDistance
                self.circle.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
                self.view.layoutIfNeeded()
            }) { _ in
                UIView.animate(withDuration: 0.2) {
                    self.circle.transform = .identity
                }
            }
        }
    }
    @objc private func clearTap(){
        self.circleConstraintsY?.constant = 0
        self.circleConstraintsX?.constant = 0
        
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveLinear, animations: {
            self.view.layoutIfNeeded()
        })
    }
}


//#Preview{
//    ViewController()
//}
