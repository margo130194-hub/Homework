//
//  ViewController.swift
//  Homework 24
//
//  Created by Margarita Matsonko on 22/03/2026.
//

import UIKit

final class ViewController: UIViewController {
    
    // MARK: - Subviews
    private var timer: Timer?
    private var city:[CityModel] = [
        CityModel(name: "London", timeZone: TimeZone(identifier: "Europe/London") ?? TimeZone.current),
        CityModel(name: "Minsk", timeZone: TimeZone(identifier: "Europe/Minsk") ?? TimeZone.current),
        CityModel(name: "Warsaw", timeZone: TimeZone(identifier: "Europe/Warsaw") ?? TimeZone.current),
        CityModel(name: "New York", timeZone: TimeZone(identifier: "America/New_York") ?? TimeZone.current),
        CityModel(name: "Tokyo", timeZone: TimeZone(identifier: "Asia/Tokyo") ?? TimeZone.current),
        CityModel(name: "Sydney", timeZone: TimeZone(identifier: "Australia/Sydney") ?? TimeZone.current),
        CityModel(name: "Ouagadougou", timeZone: TimeZone(identifier: "Africa/Ouagadougou") ?? TimeZone.current),
        CityModel(name: "Lima", timeZone: TimeZone(identifier: "America/Lima") ?? TimeZone.current),
    ]
    
    private lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing  = 10
        return layout
    }()
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor  = .white
        return collectionView
    }()
    
    // MARK: - Lyfecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewProperties()
        setupSubviews()
        setupConstraints()
    }
    override func viewWillAppear(_ animated: Bool){
        super.viewWillAppear(animated)
//        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true ){ _ in
//            self.collectionView.reloadData()
//        } создала утечку, нет weak self, соответственно при закрытии экрана он не сможет удалиться, что повлечет за собой утечку памяти
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true ){ [weak self] _ in // убрала утечку, добавив [weak self]
            self?.collectionView.reloadData()
                }
        if let timer = timer {
            RunLoop.main.add(timer, forMode: .common)
        }
    }
    // надеюсь правильно поняла задачу про утечку
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
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(CityCell.self, forCellWithReuseIdentifier: CityCell.identifier)
        view.addSubview(collectionView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10)
        ])
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        city.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CityCell.identifier, for: indexPath) as? CityCell else {
            return UICollectionViewCell()
        }
        cell.configure(with: city[indexPath.item])
        return cell
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 250, height: 250)
    }
}
    
