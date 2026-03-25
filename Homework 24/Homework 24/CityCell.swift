//
//  CityCell.swift
//  Homework 24
//
//  Created by Margarita Matsonko on 22/03/2026.
//


import UIKit

class CityCell: UICollectionViewCell{
    
    static var identifier: String = "Cell"
    
    private let time = UILabel()
    private let city = UILabel()
    private let clock = ClockView()
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        setupSubview()
        setupConstraints()
        setupViewProperties()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        time.text =  nil
        city.text  = nil
       
    }
    private func setupViewProperties(){
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 20
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOpacity = 0.5
        contentView.layer.shadowOffset = CGSize(width: 0, height: 2)
        contentView.layer.shadowRadius = 5
    }
    
    private  func setupSubview(){
        clock.translatesAutoresizingMaskIntoConstraints = false
        
        city.font = .italicSystemFont(ofSize: 25)
        city.textColor = .black
        city.textAlignment = .center
        city.translatesAutoresizingMaskIntoConstraints = false
        
        time.font = .italicSystemFont(ofSize: 20)
        time.textColor = .black
        time.textAlignment = .center
        time.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(clock)
        contentView.addSubview(time)
        contentView.addSubview(city)
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            clock.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            clock.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            clock.widthAnchor.constraint(equalToConstant: 100),
            clock.heightAnchor.constraint(equalToConstant: 100),
            
            city.topAnchor.constraint(equalTo: clock.bottomAnchor, constant: 20),
            city.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            time.topAnchor.constraint(equalTo: city.bottomAnchor, constant: 20),
            time.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
       ])
    }
     func configure(with model: CityModel){
        city.text = model.name
         clock.setupTime(date: Date(), timeZone: model.timeZone)
         let formatter = DateFormatter()
         formatter.dateFormat = "HH:mm:ss"
         formatter.timeZone = model.timeZone
         time.text = formatter.string(from: Date())
    }
}
