//
//  PanViewController.swift
//  Homework 16
//
//  Created by Margarita Matsonko on 18/02/2026.
//

import UIKit

class PanViewController: UIViewController {
    
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
        let pan = UIPanGestureRecognizer(target: self, action: #selector(panAction))
        circle.addGestureRecognizer(pan)
        
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(singleTap))
        singleTap.numberOfTapsRequired = 1
        view.addGestureRecognizer(singleTap)
    }
}

private extension PanViewController{
    
    @objc func singleTap(_ gesture: UITapGestureRecognizer){
        let location = gesture.location(in: view)
        circle.center = location
        
        circle.isHidden.toggle()
    }
    
    @objc func panAction(_ gesture: UIPanGestureRecognizer){
        switch gesture.state {
        case .began:
            circle.backgroundColor = .red
        case .changed:
            let translation = gesture.translation(in: view)
            let radiusX = circle.frame.width / 2
            let radiusY = circle.frame.height / 2
            var newCenter = CGPoint(x: circle.center.x + translation.x,
                                    y: circle.center.y + translation.y)
            newCenter.x = max(radiusX, min(view.frame.width - radiusX, newCenter.x))
            newCenter.y = max(radiusY, min(view.frame.height - radiusY, newCenter.y))
            self.circle.center = newCenter
            gesture.setTranslation(.zero, in: view)
        case .ended:
            circle.backgroundColor = .purple
        default:
            break
        }
        
    }
}
