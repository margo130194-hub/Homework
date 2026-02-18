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
        
        let swipe = UISwipeGestureRecognizer(target: self, action: #selector(topSwipe))
        swipe.direction = .up
        view.addGestureRecognizer(swipe)
        
    }
}

private extension ViewController{
    
    @objc func singleTap(_ gesture: UITapGestureRecognizer){
        let location = gesture.location(in: view)
        circle.center = location
        
        circle.isHidden.toggle()
    }
    
    @objc func topSwipe(_ gesture: UISwipeGestureRecognizer){
        let minY = circle.frame.height / 2
        UIView.animate(withDuration: 0.3) {
            self.circle.center.y = max(minY, self.circle.center.y - 600)
        }
    }
}
