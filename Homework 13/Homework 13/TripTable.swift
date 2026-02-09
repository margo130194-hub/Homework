//
//  TripTable.swift
//  Homework 13
//
//  Created by Margarita Matsonko on 07/02/2026.
//

import UIKit

class TripController: UIViewController {
    
    
    private var groups = [
        Country(
            name: "Egypt",
            offers: [
                
                TripCellModel(image: "Sunrise Alma Bay", offer: "Last Minute", country: "Egypt, Hurgada", name: "Hotel Sunrise Alma Bay", date: "14.05 - 20.05", city: "Warsaw", meal: "All inclusive", cityImage: "airplane.up.right", mealImage: "fork.knife", price: "2500 zł"),
                TripCellModel(image: "Fantazia Resort", offer: "Hot  Deal", country:"Egypt, Marsa Alam", name: "Hotel Fantazia Resort", date: "28.04 - 03.05", city: "Gdansk", meal: "All inclusive", cityImage: "airplane.up.right", mealImage: "fork.knife", price: "2030 zł")
            ]
        ),
        Country(
            name: "Greece",
            offers: [
                TripCellModel(image: "blue", offer: "Choise 2025", country: "Greece, Rodos", name: "Hotel Blue Sea Beach Resort", date: "05.06 - 08.06", city: "Warsaw", meal: "All inclusive", cityImage: "airplane.up.right", mealImage: "fork.knife", price: "3050 zł"),
                TripCellModel(image: "corfu", offer: "Early booking", country: "Greece, Corfu", name: "Hotel Nobilis Corfu", date: "03.10 - 10.10", city: "Katowice", meal: "All inclusive", cityImage: "airplane.up.right", mealImage: "fork.knife", price: "3599 zł")
            ]
        )
    ]
    
    private let tableView = UITableView()
    
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
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .white
        tableView.register(TripCell.self, forCellReuseIdentifier: TripCell.reuseIdentifier)
        
        view.addSubview(tableView)
    }
    
    private func setupConctraints(){
        NSLayoutConstraint.activate([
            
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func removeOffers(at indexPath: IndexPath) {
        groups[indexPath.section].offers.remove(at: indexPath.row)
        tableView.reloadData()
    }
    
    private var favoriteOffers: [TripCellModel] = []
    private func addOffers(at indexPath: IndexPath){
        groups[indexPath.section].offers[indexPath.row].isFavorite.toggle()
        let selectedOffer = groups[indexPath.section].offers[indexPath.row]
        favoriteOffers.append(selectedOffer)
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
    private func header(with section: Int) -> UIView{
        let header = UIView()
        header.backgroundColor = .systemGroupedBackground
        
        let label = UILabel()
        label.text = groups[section].name
        label.font = .boldSystemFont(ofSize: 30)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        
        header.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.centerYAnchor.constraint(equalTo: header.centerYAnchor),
            label.leadingAnchor.constraint(equalTo: header.leadingAnchor, constant: 10)
        ])
        return header
    }
}

extension TripController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return header(with: section)
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        tableView.deselectRow(at: indexPath, animated: true)
        
        _ = groups[indexPath.section].offers[indexPath.row]
        let vc = SecondVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: TripCell.EditingStyle, forRowAt indexPath: IndexPath){
        if editingStyle == .delete{
            removeOffers(at: indexPath)
        }
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { [weak self] _, _, completion in
            self?.removeOffers(at: indexPath)
            completion(true)
        }
        
        deleteAction.image = UIImage(systemName: "trash")
        deleteAction.backgroundColor = .systemRed
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
        
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let addAction = UIContextualAction(style: .normal, title: "Favorite") { [weak self] _, _, completion in
            self?.addOffers(at: indexPath)
            completion(true)
        }
        
        addAction.image = UIImage(systemName: "star.fill")
        addAction.backgroundColor = .blue
        
        return UISwipeActionsConfiguration(actions: [addAction])
        
    }
}


extension TripController: UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        groups.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        groups[section].offers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TripCell.reuseIdentifier, for: indexPath) as? TripCell else {
            return UITableViewCell()
        }
        let model = groups[indexPath.section].offers[indexPath.row]
        cell.configure(with: model)
        
        return cell
    }
}




struct Country{
    let name: String
    var offers: [TripCellModel]
}
