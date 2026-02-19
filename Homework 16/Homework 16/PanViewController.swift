//
//  PanViewController.swift
//  Homework 16
//
//  Created by Margarita Matsonko on 18/02/2026.
//

import UIKit

class PanViewController: UIViewController {
    
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
        let pan = UIPanGestureRecognizer(target: self, action: #selector(panAction))
        circle.addGestureRecognizer(pan)
        
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(singleTap))
        singleTap.numberOfTapsRequired = 1
        view.addGestureRecognizer(singleTap)
    }
}

private extension PanViewController{
    
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
