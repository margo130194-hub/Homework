//
//  ViewController.swift
//  Homework 16
//
//  Created by Margarita Matsonko on 18/02/2026.
//

import UIKit

class ViewController: UIViewController {
    
    private let circle = UIView()
   
    
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
        
        let point = gesture.location(in: view)
        if let present = circle.layer.presentation(),
           present.frame.contains(point){
            return
        }
        
        if circle.isHidden {
            circle.center = point
            circle.alpha = 0
            circle.isHidden = false
        }
        UIView.animate(withDuration: 0.3, animations: {
            self.circle.alpha = 0
        }) { _ in 
            self.circle.center = point
            UIView.animate(withDuration: 0.3) {
                self.circle.alpha = 1
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
