//
//  ViewController.swift
//  Homework 31
//
//  Created by Margarita Matsonko on 16/04/2026.
//

import UIKit

final class ViewController: UIViewController {
    
    // MARK: - Subviews
    private let table = UITableView()
    private var users: [Users] = []
    private let networkService = NetworkService.shared
    
    // MARK: - Lyfecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewProperties()
        setupSubviews()
        setupConstraints()
        fetchData()
    }
    
    // MARK: - Layout
    private func setupViewProperties() {
        view.backgroundColor = .white
    }
    
    private func setupSubviews() {
        table.translatesAutoresizingMaskIntoConstraints = false
        table.separatorStyle = .singleLine
        table.separatorColor = .blue
        table.rowHeight = 70
        table.backgroundColor = .white
        table.delegate = self
        table.dataSource = self
        table.register(TableCell.self, forCellReuseIdentifier: "TableCell")
        
        
        view.addSubview(table)
        
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            table.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            table.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            table.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            table.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func fetchData(){
        users = []
        table.reloadData()
        Task{ [weak self] in
            guard let self else { return }
            await fetchDataAsync()}
    }
    private func fetchDataAsync() async{
        do {
            let fetchedUsers = try await networkService.fetchUsersAsync()
            
            await MainActor.run {
                users = fetchedUsers
                table.reloadData()
            }
        } catch {
            
        }
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell", for: indexPath) as? TableCell else {
            return UITableViewCell()
        }
        let user = users[indexPath.row]
        cell.configure(with: user, index: indexPath.row)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedUser = users[indexPath.row]
        let vc = UsersInfoViewController()
        vc.user = selectedUser
        navigationController?.pushViewController(vc, animated: true)
    }}


