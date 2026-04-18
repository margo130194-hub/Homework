//
//  TableCellContriller.swift
//  Homework 31
//
//  Created by Margarita Matsonko on 16/04/2026.
//


import UIKit

class TableCell: UITableViewCell {
    
    static var reuseIdentifier: String {
        return String(describing: self)
    }
    private let name = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViewProperties()
        setupSubview()
        setupConctraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        name.text = nil
    }
    private func setupViewProperties(){
        contentView.backgroundColor = .white
    }
    
    private  func setupSubview(){
        name.font = .systemFont(ofSize: 18, weight: .bold)
        name.textColor = .black
        name.numberOfLines = 0
        name.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(name)
    }
    
    private func setupConctraints(){
        NSLayoutConstraint.activate([
            name.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            name.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    func configure(with user: Users, index: Int){
        name.text = user.name
    }
}
