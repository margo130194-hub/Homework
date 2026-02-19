//
//  ViewController.swift
//  Homework 16
//
//  Created by Margarita Matsonko on 18/02/2026.
//

import UIKit

class ViewController: UIViewController {
    
    private let circle = UIView()
    var isFirstTap = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubview()
        setupViewProperties()
        setupGestures()
    }
    
    private func setupViewProperties(){
        view.backgroundColor = .black
    }
    
    private  func setupSubview(){
        circle.backgroundColor = .purple
        circle.translatesAutoresizingMaskIntoConstraints = true
        circle.frame = CGRect(x: 0, y: 0, width: 150, height: 150)
        circle.layer.cornerRadius = 75
        circle.layer.borderColor = UIColor.white.cgColor
        circle.layer.borderWidth = 1
        circle.isHidden = true
        
        view.addSubview(circle)
    }
    
    private func setupGestures(){
        
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(singleTap))
        singleTap.numberOfTapsRequired = 1
        view.addGestureRecognizer(singleTap)
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(swipe))
        swipeDown.direction = .down
        view.addGestureRecognizer(swipeDown)
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(swipe))
        swipeRight.direction = .right
        view.addGestureRecognizer(swipeRight)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(swipe))
        swipeLeft.direction = .left
        view.addGestureRecognizer(swipeLeft)
        
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(swipe))
        swipeUp.direction = .up
        view.addGestureRecognizer(swipeUp)
        
    }
}

private extension ViewController{
    
    @objc func singleTap(_ gesture: UITapGestureRecognizer){
        if isFirstTap{
            circle.center = gesture.location(in: view)
            circle.alpha = 0
            circle.isHidden = false
            UIView.animate(withDuration: 0.3) {self.circle.alpha = 1}
            isFirstTap = false
        } else {
            UIView.animate(withDuration: 0.5, animations: {
                self.circle.alpha = 0
            }) { _ in
                let radius = self.circle.frame.width / 2
                let diameter = self.circle.frame.width
                var newCenter: CGPoint
                var distance: CGFloat = 0
                repeat {
                    let randomX = CGFloat.random(in: radius...(self.view.bounds.width - radius))
                    let randomY = CGFloat.random(in: radius...(self.view.bounds.height - radius))
                    newCenter = CGPoint(x: randomX, y: randomY)
                    
                    let legX = newCenter.x - self.circle.center.x
                    let legY = newCenter.y - self.circle.center.y
                    distance = sqrt(legX * legX + legY * legY)
                    
                } while distance < diameter
                self.circle.center = newCenter
                UIView.animate(withDuration: 0.5) {
                    self.circle.alpha = 1
                }
            }
        }
    }
    
    @objc func swipe(_ gesture: UISwipeGestureRecognizer){
        let radius = circle.frame.width / 2
        UIView.animate(withDuration: 0.3) {
            switch gesture.direction {
            case .down:
                let maxY = self.view.bounds.height - radius
                self.circle.center.y = min(maxY, self.circle.center.y + 500)
            case .up:
                let minY = radius
                self.circle.center.y = max(minY, self.circle.center.y - 500)
            case .right:
                let maxX = self.view.bounds.width - radius
                self.circle.center.x = min(maxX, self.circle.center.x + 500)
            case .left:
                let minX = radius
                self.circle.center.x = max(minX, self.circle.center.y - 500)
            default:
                break
            }
        }
    }
}
