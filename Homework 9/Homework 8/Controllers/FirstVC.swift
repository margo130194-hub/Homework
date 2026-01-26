//
//  ViewController.swift
//  Homework 8
//
//  Created by Margarita Matsonko on 23/01/2026.
//

import UIKit

class FirstViewController: UIViewController {
    
    let someView = UIView()
    private let button = UIButton(type: .system)
    private let buttonSunrise = UIButton(type: .system)
    private let buttonPride = UIButton(type: .system)
    private let buttonPrince = UIButton(type: .system)
    private let label = UILabel()
    private let image = UIImageView()
    private let janeImage = UIImageView()
    private let princeImage = UIImageView()
    private let prideImage = UIImageView()
    private let sunriseImage = UIImageView()
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        setupView()
        setupCon()
        setupViewProperties()
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        buttonPrince.addTarget(self, action: #selector(buttonPrinceTapped), for: .touchUpInside)
        buttonSunrise.addTarget(self, action: #selector(buttonSunriseTapped), for: .touchUpInside)
        buttonPride.addTarget(self, action: #selector(buttonPrideTapped), for: .touchUpInside)
        
    }
    private func setupViewProperties(){
        someView.layer.cornerRadius = 10
        someView.layer.borderWidth = 0.5
        someView.layer.shadowOpacity = 1
        
    }
    
    private func setupView(){
        
        [button, buttonPride, buttonPrince, buttonSunrise].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.setTitleColor(.black, for: .normal)
            $0.backgroundColor = .white
            $0.setTitle("Show", for: .normal)
        }
        [button, buttonPride, buttonPrince, buttonSunrise].forEach{
            $0.layer.borderWidth = 1
            $0.layer.shadowRadius = 1
        }
        label.text = "Welcome to My Library"
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 32)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        image.image = UIImage(named: "books")
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        
        janeImage.image = UIImage(named: "jane")
        janeImage.contentMode = .scaleAspectFit
        janeImage.translatesAutoresizingMaskIntoConstraints = false
        
        princeImage.image = UIImage(named: "prince")
        princeImage.contentMode = .scaleAspectFit
        princeImage.translatesAutoresizingMaskIntoConstraints = false
        
        sunriseImage.image = UIImage(named: "sunrise")
        sunriseImage.contentMode = .scaleAspectFit
        sunriseImage.translatesAutoresizingMaskIntoConstraints = false
        
        prideImage.image = UIImage(named: "pride")
        prideImage.contentMode = .scaleAspectFit
        prideImage.translatesAutoresizingMaskIntoConstraints = false
        
        
        view.addSubview(image)
        view.addSubview(janeImage)
        view.addSubview(label)
        view.addSubview(princeImage)
        view.addSubview(sunriseImage)
        view.addSubview(prideImage)
        view.addSubview(button)
        view.addSubview(buttonPride)
        view.addSubview(buttonPrince)
        view.addSubview(buttonSunrise)
        
    }
    
    private func setupCon(){
        NSLayoutConstraint.activate([
            
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor ),
            label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
            image.topAnchor.constraint(equalTo: view.topAnchor),
            image.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            image.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            image.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            janeImage.widthAnchor.constraint(equalToConstant: 100),
            janeImage.heightAnchor.constraint(equalToConstant: 130),
            janeImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 35),
            janeImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            
            princeImage.widthAnchor.constraint(equalToConstant: 100),
            princeImage.heightAnchor.constraint(equalToConstant: 130),
            princeImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 35),
            princeImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 350),
            sunriseImage.widthAnchor.constraint(equalToConstant: 100),
            sunriseImage.heightAnchor.constraint(equalToConstant: 130),
            sunriseImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -35),
            sunriseImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            prideImage.widthAnchor.constraint(equalToConstant: 100),
            prideImage.heightAnchor.constraint(equalToConstant: 130),
            prideImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -35),
            prideImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 350),
            
            button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 62),
            button.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 250),
            button.widthAnchor.constraint(equalToConstant: 50),
            button.heightAnchor.constraint(equalToConstant: 25),
            buttonSunrise.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -62),
            buttonSunrise.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 250),
            buttonSunrise.widthAnchor.constraint(equalToConstant: 50),
            buttonSunrise.heightAnchor.constraint(equalToConstant: 25),
            buttonPride.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -62),
            buttonPride.bottomAnchor.constraint(equalTo: prideImage.bottomAnchor, constant: 50),
            buttonPride.widthAnchor.constraint(equalToConstant: 50),
            buttonPride.heightAnchor.constraint(equalToConstant: 25),
            buttonPrince.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 62),
            buttonPrince.bottomAnchor.constraint(equalTo: princeImage.bottomAnchor, constant: 50),
            buttonPrince.widthAnchor.constraint(equalToConstant: 50),
            buttonPrince.heightAnchor.constraint(equalToConstant: 25)
            
        ])
    }
    @objc private func buttonTapped() {
        let vc = SecondViewController()
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
    }
    @objc private func buttonPrinceTapped() {
        let vc = ThirdViewController()
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
    }
    @objc private func buttonSunriseTapped() {
        let vc = ForthViewController()
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
    }
    @objc private func buttonPrideTapped() {
        let vc = FifthViewController()
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
