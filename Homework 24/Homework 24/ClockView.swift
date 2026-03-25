//
//  ClockView.swift
//  Homework 24
//
//  Created by Margarita Matsonko on 22/03/2026.
//

import UIKit

class ClockView: UIView {
    
    private let hourHand = CALayer()
    private let minuteHand = CALayer()
    private let background = CALayer()
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        setupSubview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews(){
        super.layoutSubviews()
        background.frame = bounds
        let center = CGPoint(x: bounds.midX, y: bounds.midY)
        hourHand.position = center
        minuteHand.position = center
        hourHand.bounds = CGRect(x: 0, y: 0, width: 3, height: bounds.height*0.25)
        minuteHand.bounds = CGRect(x: 0, y: 0, width: 1.5, height: bounds.height*0.35)
    }
    
    private func setupSubview(){
        background.contents = UIImage(named: "clock")?.cgImage
        background.contentsGravity = .resizeAspect
        
        hourHand.backgroundColor = UIColor.black.cgColor
        minuteHand.backgroundColor = UIColor.black.cgColor
        
        hourHand.anchorPoint = CGPoint(x: 0.5, y: 1.0)
        minuteHand.anchorPoint = CGPoint(x: 0.5, y: 1.0)
        
        layer.insertSublayer(background, at: 0)
        layer.addSublayer(hourHand)
        layer.addSublayer(minuteHand)
        
        layer.cornerRadius = bounds.width/2
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 1.5
        layer.shadowColor = UIColor.black.withAlphaComponent(0.7).cgColor
    }
    
    func setupTime(date: Date, timeZone: TimeZone){
        var calendar = Calendar.current
        calendar.timeZone = timeZone
        let components = calendar.dateComponents([.hour, .minute], from: date)
        let hour = CGFloat(components.hour ?? 0)
        let minute = CGFloat(components.minute ?? 0)
        let hourAngle = (hour + minute/60) * 30 * .pi/180
        let minuteAngle = minute * 6 * .pi/180
        
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        
        hourHand.setAffineTransform(CGAffineTransform(rotationAngle: hourAngle))
        minuteHand.setAffineTransform(CGAffineTransform(rotationAngle: minuteAngle))
        CATransaction.commit()
    }
    
}
