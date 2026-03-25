//
//  CurrentTimeViewController.swift
//  Homework 24
//
//  Created by Margarita Matsonko on 25/03/2026.
//

import UIKit

final class CurrentTimeViewController: UIViewController {
    
    // MARK: - Subviews
    private var timer: Timer?
    private let bigClock = ClockView()
    private let label = UILabel()
    private let formatter = DateFormatter()
    
    // MARK: - Lyfecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewProperties()
        setupSubviews()
        setupConstraints()
    }
    override func viewWillAppear(_ animated: Bool){
        super.viewWillAppear(animated)
        timeFormatter()
        //MARK: Здесь утечка, если убрать слабую ссылку и timer.invalidate(). таймер работает вечно и если заходить в дебаг мемори, после нескольких переходов между экранами, то в пямяти висит много контроллеров и видно, что они связаны с замыканием и таймером
        //        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true ){ _ in
        //            self.timeFormatter()
        //        }
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true ){ [weak self] _ in
            self?.timeFormatter()
        }
        if let timer = timer {
            RunLoop.main.add(timer, forMode: .common)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool){
        super.viewWillDisappear(animated)
        timer?.invalidate()
        timer = nil
    }
    // MARK: - Layout
    private func setupViewProperties() {
        view.backgroundColor = .white
    }
    
    private func setupSubviews() {
        bigClock.translatesAutoresizingMaskIntoConstraints = false
        bigClock.setupTime(date: Date(), timeZone: TimeZone.current)
        
        label.textColor = .black
        label.font = .italicSystemFont(ofSize: 25)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(bigClock)
        view.addSubview(label)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            bigClock.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            bigClock.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            bigClock.widthAnchor.constraint(equalToConstant: 300),
            bigClock.heightAnchor.constraint(equalToConstant: 300),
            
            label.topAnchor.constraint(equalTo: bigClock.bottomAnchor, constant: 40),
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            label.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -60)
        ])
    }
    private func timeFormatter(timeZone: TimeZone = .current){
        formatter.dateStyle = .full
        formatter.timeStyle = .full
        formatter.timeZone = timeZone
        let dateString = formatter.string(from: Date())
        label.text = dateString
    }
    
}

