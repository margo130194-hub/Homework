//
//  SecondVC.swift
//  Homework 8
//
//  Created by Margarita Matsonko on 25/01/2026.
//


import UIKit

class SecondViewController: UIViewController {
    
    let someView = SecondView()
    private let favButton = UIButton(type: .system)
    private let button = UIButton()
    override func viewDidLoad(){
        super.viewDidLoad()
        
        view.backgroundColor = .white
        someView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(someView)
        
        button.setTitle("Chapter 2", for: .normal)
        favButton.setTitle("Favourites", for: .normal)
        
        [button, favButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.setTitleColor(.white, for: .normal)
            $0.backgroundColor = .black
            $0.layer.borderWidth = 1
            $0.layer.shadowRadius = 1
            
        }
        
        favButton.addTarget(self, action: #selector(favButtonTapped), for: .touchUpInside)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        view.addSubview(button)
        view.addSubview(favButton)
        
        NSLayoutConstraint.activate([
            someView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            someView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            someView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            someView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30),
            button.widthAnchor.constraint(equalToConstant: 100),
            button.heightAnchor.constraint(equalToConstant: 40),
            favButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            favButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30),
            favButton.widthAnchor.constraint(equalToConstant: 100),
            favButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    @objc private func favButtonTapped() {
        let vc = FavoriteViewController()
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
        
    }
    @objc private func buttonTapped() {
        let vc = FirstViewController()
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
        
    }
}
class SecondView: UIView{
    
    private let chapter = UILabel()
    private let text = UITextView()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupCon()
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupView(){
        
        chapter.text = "Chapter 1"
        chapter.textColor = .black
        chapter.font = .boldSystemFont(ofSize: 30)
        chapter.translatesAutoresizingMaskIntoConstraints = false
        
        text.text = NSLocalizedString("book_jane_eyre_content", comment: "")
        text.textColor = .black
        text.backgroundColor = .white
        text.font = .systemFont(ofSize: 18)
        text.translatesAutoresizingMaskIntoConstraints  = false
        text.isEditable = false
        text.isSelectable = true
        text.isScrollEnabled = true
        text.textAlignment = .justified
        
        addSubview(chapter)
        addSubview(text)
        
    }
    private func setupCon(){
        NSLayoutConstraint.activate([
            chapter.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 130),
            chapter.topAnchor.constraint(equalTo: topAnchor, constant: 80),
            text.topAnchor.constraint(equalTo: chapter.bottomAnchor, constant: 30),
            text.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            text.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            text.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -100),
            
        ])
        
        
    }
}
