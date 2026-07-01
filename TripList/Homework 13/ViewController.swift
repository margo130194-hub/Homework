//
//  ViewController.swift
//  Homework 13
//
//  Created by Margarita Matsonko on 07/02/2026.
//

import UIKit

class TripCell: UITableViewCell {
    
    static var reuseIdentifier: String {
        return String(describing: self)
    }
    private let image = UIImageView()
    private let offerLabel = UILabel()
    private let countryLabel = UILabel()
    private let nameLabel = UILabel()
    private let dateLabel = UILabel()
    private let cityLabel = UILabel()
    private let mealLabel = UILabel()
    private let cityImage = UIImageView()
    private let mealImage = UIImageView()
    private let priceLabel = UILabel()
    private let horizStackView = UIStackView()
    private let verticalStackView = UIStackView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupSubview()
        setupConctraints()
        setupViewProperties()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        image.image = nil
        offerLabel.text = nil
        countryLabel.text = nil
        nameLabel.text = nil
        dateLabel.text = nil
        cityLabel.text = nil
        mealLabel.text = nil
        cityImage.image = nil
        mealImage.image = nil
        priceLabel.text = nil
        
    }
    
    private func setupViewProperties(){
        
    }
    
    private  func setupSubview(){
        
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        
        [countryLabel, dateLabel, cityLabel, mealLabel].forEach{
            $0.font = .systemFont(ofSize: 17, weight: .medium)
            $0.textColor = .black
            $0.numberOfLines = 0
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        [nameLabel, priceLabel].forEach{
            $0.font = .boldSystemFont(ofSize: 20)
            $0.textColor = .black
            $0.numberOfLines = 0
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        priceLabel.textAlignment = .right
        
        offerLabel.font = .systemFont(ofSize: 15, weight: .bold)
        offerLabel.textColor = .black
        offerLabel.layer.borderWidth = 2
        offerLabel.layer.cornerRadius = 5
        offerLabel.layer.borderColor = UIColor.black.cgColor
        offerLabel.clipsToBounds = true
        offerLabel.translatesAutoresizingMaskIntoConstraints = false
        offerLabel.textAlignment = .center
        offerLabel.widthAnchor.constraint(equalToConstant: 120).isActive = true
        offerLabel.heightAnchor.constraint(equalToConstant: 40).isActive =  true
        
        [mealImage, cityImage].forEach{
            $0.contentMode = .scaleAspectFit
            $0.clipsToBounds = true
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.heightAnchor.constraint(equalToConstant: 15).isActive = true
            $0.widthAnchor.constraint(equalToConstant: 15).isActive = true
        }
        
        horizStackView.axis = .horizontal
        horizStackView.spacing  = 10
        horizStackView.alignment = .center
        horizStackView.distribution = .fill
        horizStackView.translatesAutoresizingMaskIntoConstraints = false
        
        [cityImage, cityLabel, mealImage, mealLabel].forEach{
            horizStackView.addArrangedSubview($0)
        }
        
        verticalStackView.translatesAutoresizingMaskIntoConstraints = false
        verticalStackView.axis = .vertical
        verticalStackView.spacing = 15
        verticalStackView.alignment  = .leading
        verticalStackView.distribution = .fill
        
        [offerLabel, countryLabel, nameLabel, dateLabel, horizStackView].forEach{
            verticalStackView.addArrangedSubview($0)
        }
        
        contentView.addSubview(verticalStackView)
        contentView.addSubview(image)
        contentView.addSubview(priceLabel)
        
    }
    
    private func setupConctraints(){
        NSLayoutConstraint.activate([
            
            image.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor),
            image.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            image.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            image.heightAnchor.constraint(equalToConstant: 200),
            
            
            verticalStackView.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 30),
            verticalStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            verticalStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            priceLabel.topAnchor.constraint(equalTo: verticalStackView.bottomAnchor, constant: 60),
            priceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            priceLabel.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
    
    
    func configure(with model: TripCellModel){
        image.image = UIImage(named: model.image)
        countryLabel.text = model.country
        nameLabel.text = "⭐⭐⭐⭐⭐ " + model.name
        dateLabel.text = model.date
        cityLabel.text = model.city
        mealLabel.text = model.meal
        cityImage.image = UIImage(systemName: model.cityImage)
        mealImage.image = UIImage(systemName: model.mealImage)
        priceLabel.text = model.price
        
        if model.isFavorite == true{
            offerLabel.text = model.offer + " ❤️"
        } else {
            offerLabel.text = model.offer
        }
    }
}
