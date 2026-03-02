//
//  ViewController.swift
//  Homework 21
//
//  Created by Margarita Matsonko on 27/02/2026.
//

import UIKit

final class ViewController: UIViewController {
    
    // MARK: - Subviews
    let phrases = ["English, motherf*r, do you speak it?", "Panie, ja tu tylko sprzątam, niech pan mnie nie pyta o kod."]
    var wordPhrases:[UILabel] = []
    let segmentedControl =  UISegmentedControl()
    let button = UIButton(type: .system)
    
    // MARK: - Lyfecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewProperties()
        setupSubviews()
        setupConstraints()
        createLabel(from: phrases[0])
    }
    
    // MARK: - Layout
    private func setupViewProperties() {
        view.backgroundColor = UIColor(named: "Color")
    }
    
    private func setupSubviews() {
        button.setTitle("Magic", for: .normal)
        button.titleLabel?.font = UIFont(name: "Eater-Regular", size: 40)
        button.setTitleColor(.systemPink, for: .normal)
        button.backgroundColor = .yellow
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.borderWidth = 1.5
        button.layer.borderColor = UIColor.black.cgColor
        button.addTarget(self, action: #selector(magicTap), for: .touchUpInside)
        view.addSubview(button)
        
        segmentedControl.insertSegment(withTitle: "English", at: 0, animated: true)
        segmentedControl.insertSegment(withTitle: "Polski", at: 1, animated: true)
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.selectedSegmentTintColor = .yellow
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.addTarget(self, action: #selector(changeSegment), for: .valueChanged)
        view.addSubview(segmentedControl)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            button.heightAnchor.constraint(equalToConstant: 60),
            button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -100),
            button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -100),
            button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 100),
            
            segmentedControl.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            segmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -100),
            segmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 100),
            
        ])
    }
    
    @objc private func magicTap(){
        if self.segmentedControl.selectedSegmentIndex == 1{
            for _ in 0...60{
                let size = CGFloat.random(in: 6...10)
                let drop = UIView(frame: CGRect(x: CGFloat(Int(CGFloat.random(in: 0...view.bounds.width))), y: -20, width: size, height: size*2.5))
                drop.layer.cornerRadius = size/2
                drop.layer.shadowColor = UIColor.red.cgColor
                drop.layer.shadowOpacity = 0.5
                drop.layer.shadowRadius = 8
                drop.layer.shadowOffset = CGSize(width: 2, height: 2)
                drop.backgroundColor = UIColor.red.withAlphaComponent(0.7)
                view.addSubview(drop)
                
                UIView.animate(withDuration: Double.random(in: 0.5...3.5), delay: Double.random(in: 0.0...0.9), options: .curveEaseInOut){
                    drop.frame.origin.y = self.view.bounds.height + 30
                    drop.transform = CGAffineTransform(scaleX: 0.7, y: 2)
                    drop.alpha = 0.4
                }  completion: { _ in
                    drop.removeFromSuperview()
                }
            }
        }
        
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 4, initialSpringVelocity: 0.9){
            if self.segmentedControl.selectedSegmentIndex == 1{
                self.view.backgroundColor = .black
            } else {
                self.view.backgroundColor = UIColor(named: "Color")
            }
            var currentX: CGFloat = 30
            var currentY: CGFloat = 210
            let maxWidth = self.view.bounds.width - 100
            
            for label in self.wordPhrases{
                label.transform = .identity
                if self.segmentedControl.selectedSegmentIndex == 1{
                    label.textColor = .color
                    label.font = UIFont(name: "Eater-Regular", size: 30)
                }
                if currentX + label.frame.height > maxWidth{
                    currentX = 30
                    currentY += label.frame.height + 15
                }
                
                label.frame.origin = CGPoint(x: currentX, y: currentY)
                currentX += label.frame.width + 15
            }
        }
    }
    
    @objc private func changeSegment(_ sender: UISegmentedControl){
        let index = sender.selectedSegmentIndex
        let phrase = phrases[index]
        
        UIView.animateKeyframes(withDuration: 0.5, delay: 0, options: []){
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.25){
                for label in self.wordPhrases{
                    label.alpha = 0.5
                }
            }
            UIView.addKeyframe(withRelativeStartTime: 0.25, relativeDuration: 0.25){
                for label in self.wordPhrases{
                    label.alpha = 0
                }
            }
        }
            completion: {  _ in
                for label in self.wordPhrases{
                    label.removeFromSuperview()
                }
                self.wordPhrases.removeAll()
                self.createLabel(from: phrase)
            }
        }
    
    private func createLabel(from text: String){
        let words = text.components(separatedBy: " ")
        for (index, word) in words.enumerated(){
            let label = UILabel()
            let customFont: UIFont?
            switch index {
            case 1:
                customFont = UIFont(name: "Eater-Regular", size: 40)
            case 2...3:
                customFont = UIFont(name: "Oi-Regular", size: 25)
            case 4...6:
                customFont = UIFont(name: "RubikBrokenFax-Regular", size: 37)
            default:
                customFont = UIFont(name: "Futura-CondensedExtraBold", size: 45)
            }
            let attributes:[NSAttributedString.Key: Any] = [
                .foregroundColor: (index % 3 == 0) ? UIColor.orange : UIColor.systemPink,
                .font: customFont ?? UIFont(name: "Copperplate-Bold", size: 32) ?? UIFont.systemFont(ofSize: 32),
                .strokeColor: (index < 2) ? UIColor.systemPink : UIColor.blue,
                .kern: (index < 2) ? 10.0 : 6.0
            ]
            let atrText = NSMutableAttributedString(string: word, attributes: attributes)
            if word.count >= 3{
                atrText.addAttribute(.foregroundColor, value: UIColor.purple, range: NSRange(location: 2, length: 1))}
            if word.count >= 2{
                atrText.addAttribute(.foregroundColor, value: UIColor.systemMint, range: NSRange(location: 0, length: 1))}
            if word.count  >= 2{
                atrText.addAttribute(.font, value: UIFont(name: "RubikBrokenFax-Regular", size: 50) ?? .italicSystemFont(ofSize: 40), range: NSRange(location: 1, length: 1))}
            label.attributedText = atrText
            label.sizeToFit()
            
            let randomX = CGFloat.random(in: 100...view.bounds.width - 100)
            let randomY = CGFloat.random(in: 100...view.bounds.height - 300)
            label.center = CGPoint(x: randomX, y: randomY)
            label.transform = CGAffineTransform(rotationAngle: CGFloat.random(in: -0.5...0.5))
            view.addSubview(label)
            self.wordPhrases.append(label)
        }
    }
}

