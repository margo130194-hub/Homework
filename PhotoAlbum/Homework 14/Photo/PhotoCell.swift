//
//  ViewController.swift
//  Homework 14
//
//  Created by Margarita Matsonko on 11/02/2026.
//

import UIKit

protocol PhotoCellDelegate: AnyObject{
    func favoriteTap(in cell: PhotoCell)
}


class PhotoCell: UICollectionViewCell {
    
    weak var delegate: PhotoCellDelegate?
    
    static var identifier: String = "Cell"
    
    private let image = UIImageView()
    private let name = UILabel()
    private let date = UILabel()
    private let like = UIImageView()
    private let favorite = UIImageView()
    private let buttonFavorite =  UIButton(type: .system)
    private let horizontalStack = UIStackView()
    private let verticalStack = UIStackView()
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        setupSubview()
        setupConctraints()
        setupViewProperties()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        image.image =  nil
        name.text  = nil
        date.text = nil
    }
    
    private func setupViewProperties(){
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 10
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOpacity = 0.5
        contentView.layer.shadowOffset = CGSize(width: 0, height: 2)
        contentView.layer.shadowRadius = 5
    }
    
    private  func setupSubview(){
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.layer.cornerRadius = 12
        
        horizontalStack.axis = .horizontal
        horizontalStack.spacing = 40
        horizontalStack.alignment = .center
        horizontalStack.distribution = .fill
        horizontalStack.translatesAutoresizingMaskIntoConstraints = false
        
        like.image  = UIImage(systemName: "heart")
        favorite.image  =  UIImage(systemName: "star")
        [like, favorite].forEach{
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.contentMode = .scaleAspectFit
            $0.clipsToBounds = true
            $0.heightAnchor.constraint(equalToConstant: 15).isActive = true
            $0.widthAnchor.constraint(equalToConstant: 15).isActive = true
            horizontalStack.addArrangedSubview($0)
        }
        
        verticalStack.axis = .vertical
        verticalStack.spacing = 5
        verticalStack.alignment = .leading
        verticalStack.distribution  = .fill
        verticalStack.translatesAutoresizingMaskIntoConstraints = false
        
        [name, date].forEach{
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.textColor = .black
            $0.textAlignment = .center
            $0.numberOfLines = 0
            $0.font = .systemFont(ofSize: 14, weight: .medium)
            verticalStack.addArrangedSubview($0)
        }
        
        
        
        
        buttonFavorite.setTitle("Favorite", for: .normal)
        buttonFavorite.setTitleColor(.white, for: .normal)
        buttonFavorite.backgroundColor = .systemBlue
        buttonFavorite.translatesAutoresizingMaskIntoConstraints = false
        buttonFavorite.layer.cornerRadius =  12
        buttonFavorite.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        contentView.addSubview(image)
        contentView.addSubview(horizontalStack)
        contentView.addSubview(verticalStack)
        
        contentView.addSubview(buttonFavorite)
        buttonFavorite.isUserInteractionEnabled = true
    }
    
    private func setupConctraints(){
        NSLayoutConstraint.activate([
            image.heightAnchor.constraint(equalToConstant: 80),
            image.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 20),
            image.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            image.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            
            horizontalStack.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 2),
            horizontalStack.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            verticalStack.topAnchor.constraint(equalTo: horizontalStack.bottomAnchor, constant: 2),
            verticalStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            verticalStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            
            buttonFavorite.topAnchor.constraint(equalTo: verticalStack.bottomAnchor, constant: 10),
            buttonFavorite.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: -15),
            buttonFavorite.heightAnchor.constraint(equalToConstant: 40),
            buttonFavorite.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            buttonFavorite.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
        ])
    }
    
    
    @objc private func  buttonTapped(){
        delegate?.favoriteTap(in: self)
    }
    
    func configure(with model: PhotoModel){
        image.image = UIImage(named: model.image)
        name.text = model.name
        date.text = model.date
        date.isHidden = false
        buttonFavorite.isHidden = false
        horizontalStack.isHidden = false
        
        like.image = UIImage(systemName: model.isLiked ? "heart.fill" : "heart")
        like.tintColor = model.isLiked ? .systemRed : .systemGray
        
        favorite.image = UIImage(systemName: model.isFavorite ? "star.fill" : "star")
        favorite.tintColor = model.isFavorite ? .systemYellow : .systemGray
        
    }
    
    func configureFavorites(with model: PhotoModel){
        image.image = UIImage(named: model.image)
        name.text = model.name
        date.isHidden = true
        buttonFavorite.isHidden = true
        horizontalStack.isHidden = true
    }
}
