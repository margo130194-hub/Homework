//
//  PickerViewController.swift
//  Homework 22
//
//  Created by Margarita Matsonko on 16/03/2026.
//

import UIKit

final class PickerViewController: UIViewController {
    
    // MARK: - Subviews
  
    private let label = UILabel()
    private let pickerView = UIPickerView()
    
    private let city = ["London", "Warsaw", "Minsk", "Riga", "Tokio", "Madrid", "Sofia", "New York", "Brest"]
    
    
    
    // MARK: - Lyfecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewProperties()
        setupSubviews()
        setupConstraints()
    }
    
    // MARK: - Layout
    private func setupViewProperties() {
        view.backgroundColor = .systemBackground
    }
    
    private func setupSubviews() {
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        pickerView.delegate = self
        pickerView.dataSource = self
        view.addSubview(pickerView)
        
        label.font = .systemFont(ofSize: 25, weight: .bold)
        label.textColor = .systemBlue
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        
        
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            pickerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pickerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            label.widthAnchor.constraint(equalToConstant: 150),
            label.heightAnchor.constraint(equalToConstant: 60)
            
        ])
    }
}

extension PickerViewController: UIPickerViewDataSource{
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        city.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
}

extension PickerViewController: UIPickerViewDelegate{
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        70
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        label.text = city[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        city[row]
    }
}

//#Preview {
//    PickerViewController()
//}

