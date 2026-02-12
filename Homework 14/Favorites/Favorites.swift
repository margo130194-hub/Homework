//
//  FavoriteCollection.swift
//  Homework 14
//
//  Created by Margarita Matsonko on 12/02/2026.
//



import UIKit

class FavoritesViewController: UIViewController {
    
    var favorites: [PhotoModel] = []
    
    private lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing  = 10
        let screenWidth = view.frame.width
        let width = (screenWidth - 40)/2
        layout.itemSize = CGSize(width: width, height: width*1.5)
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
        self.title = "Favorites"
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
        
    }
    
    private func setupConctraints(){
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}

extension FavoritesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        favorites.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCell.identifier, for: indexPath) as? PhotoCell else {
            return UICollectionViewCell()
        }
        cell.configureFavorites(with: favorites[indexPath.item])
        
        // cell.delegate = self
        return cell
        
    }
}
extension FavoritesViewController: UICollectionViewDelegate{
    
}
