//
//  PhotoCollection.swift
//  Homework 14
//
//  Created by Margarita Matsonko on 12/02/2026.
//

import UIKit



class ViewController: UIViewController {
    
    var favorites: [PhotoModel] = []
    
    private let buttonToFavorites = UIButton(type: .system)
    private let addButton = UIButton(type: .system)
    
    private var photos:[PhotoModel] = [
        PhotoModel(image: "bird", name: "Beautiful bird", date: "13.07.2024"),
        PhotoModel(image: "nature", name: "My trip", date: "04.08.2019"),
        PhotoModel(image: "sakura", name: "Japan", date: "08.03.2023"),
        PhotoModel(image: "strawberry", name: "Summer in my village", date: "25.06.2018"),
        PhotoModel(image: "forest", name: "Magic", date: "13.09.2022"),
        PhotoModel(image: "man", name: "Someone is working", date: "13.10.2024"),
        PhotoModel(image: "sea", name: "Vacation, I miss you", date: "25.07.2024"),
        PhotoModel(image: "bird", name: "Beautiful bird", date: "13.07.2024"),
        PhotoModel(image: "nature", name: "My trip", date: "04.08.2019"),
        PhotoModel(image: "sakura", name: "Japan", date: "08.03.2023"),
        PhotoModel(image: "strawberry", name: "Summer in my village", date: "25.06.2018"),
        PhotoModel(image: "forest", name: "Magic", date: "13.09.2022"),
        PhotoModel(image: "man", name: "Someone is working", date: "13.10.2024"),
        PhotoModel(image: "sea", name: "Vacation, I miss you", date: "25.07.2024"),
        PhotoModel(image: "nature", name: "My trip", date: "04.08.2019"),
        PhotoModel(image: "sakura", name: "Japan", date: "08.03.2023"),
        PhotoModel(image: "strawberry", name: "Summer in my village", date: "25.06.2018"),
        PhotoModel(image: "forest", name: "Magic", date: "13.09.2022"),
        PhotoModel(image: "man", name: "Someone is working", date: "13.10.2024"),
        PhotoModel(image: "sea", name: "Vacation, I miss you", date: "25.07.2024"),
    ]
    
    private lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing  = 10
        let screenWidth = view.frame.width
        let width = (screenWidth - 40)/3
        layout.itemSize = CGSize(width: width, height: width*2)
        return layout
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor  = .white
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubview()
        setupConctraints()
        setupViewProperties()
    }
    
    private func setupViewProperties(){
        view.backgroundColor = .white
    }
    
    private  func setupSubview(){
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(PhotoCell.self, forCellWithReuseIdentifier: PhotoCell.identifier)
        view.addSubview(collectionView)
        
        buttonToFavorites.setTitle("Show favorites", for: .normal)
        buttonToFavorites.tintColor = .white
        buttonToFavorites.backgroundColor = .systemBlue
        buttonToFavorites.translatesAutoresizingMaskIntoConstraints = false
        buttonToFavorites.addTarget(self, action: #selector(goToFavorites), for: .touchUpInside)
        view.addSubview(buttonToFavorites)
        
        addButton.setTitle("+", for: .normal)
        addButton.tintColor = .white
        addButton.backgroundColor = .systemBlue
        addButton.translatesAutoresizingMaskIntoConstraints = false
        addButton.addTarget(self, action: #selector(addNewPhoto), for: .touchUpInside)
        view.addSubview(addButton)
        
    }
    private func setupConctraints(){
        NSLayoutConstraint.activate([
            addButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            addButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            addButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            addButton.bottomAnchor.constraint(equalTo: collectionView.topAnchor, constant: -20),
            
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            buttonToFavorites.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            buttonToFavorites.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            buttonToFavorites.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 20),
            buttonToFavorites.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    @objc private func goToFavorites(){
        let vc = FavoritesViewController()
        vc.favorites = self.favorites
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func addNewPhoto(){
        let title = ["Magic", "Beautiful photo", "Life"]
        let images = ["bird", "nature", "sakura", "sea", "man", "strawberry"]
        let dates = ["09.11.2025", "08.03.2023", "13.10.2024", "13.07.2024"]
        
        let newPhoto = PhotoModel(
            image: images.randomElement() ?? "bird",
            name: title.randomElement() ?? "Photo",
            date: dates.randomElement() ?? "26.09.2011")
        photos.insert(newPhoto, at: 0)
        collectionView.insertItems(at: [IndexPath(item: 0, section: 0)])
    }
    
}

extension ViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCell.identifier, for: indexPath) as? PhotoCell else {
            return UICollectionViewCell()
        }
        cell.configure(with: photos[indexPath.item])
        
        cell.delegate = self
        return cell
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        photos.count
    }
}

extension ViewController: PhotoCellDelegate{
    func favoriteTap(in cell: PhotoCell){
        guard let indexPath = collectionView.indexPath(for: cell) else {return}
        photos[indexPath.item].isFavorite.toggle()
        let photo = photos[indexPath.item]
        
        if photo.isFavorite{
            favorites.append(photo)
        } else {
            favorites.removeAll{$0.name == photo.name}
        }
        
        collectionView.reloadItems(at: [indexPath])
    }
    
}

extension ViewController: UICollectionViewDelegate{
    
}
