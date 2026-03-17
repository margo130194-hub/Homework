//
//  ImagePickerViewController.swift
//  Homework 22
//
//  Created by Margarita Matsonko on 16/03/2026.
//
import UIKit
import Photos
import AVFoundation
import SafariServices

final class ImagePickerViewController: UIViewController {
    
    // MARK: - Subviews
    private let imagePicker = UIImagePickerController()
    private let image = UIImageView()
    private let label = UILabel()
    private let nameLabel = UILabel()
    private let numberLabel = UILabel()
    private let instagramButton = UIButton(type: .system)
    private let changeImage = UIButton(type: .system)
    
    
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
        [label, nameLabel, numberLabel].forEach{
            $0.textColor = .blue
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.font = .systemFont(ofSize: 20, weight: .medium)
            view.addSubview($0)
        }
        
        label.text = "User profile"
        nameLabel.text = "Jane"
        numberLabel.text = "+48 984 087 999"
        
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.layer.cornerRadius = 60
        image.backgroundColor = .lightGray
        image.clipsToBounds = true
        image.layer.borderWidth = 2
        image.layer.borderColor = UIColor.black.cgColor
        
        changeImage.setTitle("Change photo", for: .normal)
        changeImage.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        changeImage.translatesAutoresizingMaskIntoConstraints = false
        changeImage.setTitleColor(.blue, for: .normal)
        changeImage.backgroundColor = .secondarySystemBackground
        changeImage.layer.borderWidth = 1
        changeImage.layer.borderColor = UIColor.blue.cgColor
        changeImage.layer.cornerRadius = 10
        changeImage.addTarget(self, action: #selector(changePhoto), for: .touchUpInside)
        view.addSubview(changeImage)
        view.addSubview(image)
        
        instagramButton.setTitle("Instagram", for: .normal)
        instagramButton.setTitleColor(.systemPink, for: .normal)
        instagramButton.titleLabel?.font = .boldSystemFont(ofSize: 20)
        instagramButton.translatesAutoresizingMaskIntoConstraints = false
        instagramButton.addTarget(self, action: #selector(goToInstagram), for: .touchUpInside)
        view.addSubview(instagramButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            
            image.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            image.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 50),
            image.widthAnchor.constraint(equalToConstant: 120),
            image.heightAnchor.constraint(equalToConstant: 120),
            
            changeImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            changeImage.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 40),
            changeImage.widthAnchor.constraint(equalToConstant: 150),
            changeImage.heightAnchor.constraint(equalToConstant: 50),
            
            nameLabel.topAnchor.constraint(equalTo: changeImage.bottomAnchor, constant: 100),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            
            numberLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 30),
            numberLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            
            instagramButton.topAnchor.constraint(equalTo: numberLabel.bottomAnchor, constant: 30),
            instagramButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            
        ])
    }
    
    @objc private func changePhoto(){
        let alert = UIAlertController(
            title: "Change photo",
            message: "Choose option",
            preferredStyle: .actionSheet)
        
        let camera = UIAlertAction(title: "Camera", style: .default){_ in
            let status = AVCaptureDevice.authorizationStatus(for: .video)
            switch status {
            case .authorized:
                self.callImagePicker(source: .camera)
            case .denied, .restricted:
                self.showAlert(text: "Denied", message: "Go to settings to get permission")
            case .notDetermined:
                AVCaptureDevice.requestAccess(for: .video){ granted in
                    if granted {
                        DispatchQueue.main.async {
                            self.callImagePicker(source: .camera)
                        }
                    }else {
                        DispatchQueue.main.async {
                            self.showAlert(text: "Denied", message: "Go to settings to get permission")
                        }
                    }
                }
            @unknown default:
                break
            }
        }
        
        let library = UIAlertAction(title: "Photo", style: .default){_ in
            let statusLibrary = PHPhotoLibrary.authorizationStatus()
            switch statusLibrary {
            case .authorized, .limited :
                self.callImagePicker(source: .photoLibrary)
            case .denied, .restricted:
                self.showAlert(text: "Denied", message: "Go to settings to get permission")
            case .notDetermined:
                PHPhotoLibrary.requestAuthorization { statusLibrary in
                    if statusLibrary == .authorized || statusLibrary == .limited {
                        DispatchQueue.main.async{
                            self.callImagePicker(source: .photoLibrary)
                        }
                    } else {
                        DispatchQueue.main.async {
                            self.showAlert(text: "Denied", message: "Go to settings to get permission")
                        }
                    }
                }
            @unknown default:
                break
            }
        }
        
        let deletePhoto = UIAlertAction(title: "Delete photo", style: .destructive){_ in 
            self.image.image = nil
            self.image.backgroundColor = .lightGray
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(camera)
        alert.addAction(library)
        alert.addAction(deletePhoto)
        alert.addAction(cancel)
        present(alert, animated: true)
    }
    
    @objc private func goToInstagram(){
        guard let url = URL(string: "https://www.instagram.com") else {return}
        openSafari(with: url)
    }
    
    private func showAlert(text: String, message: String){
        let alert = UIAlertController(title: text, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        present(alert, animated: true)
    }
    private func callImagePicker(source: UIImagePickerController.SourceType){
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = source
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        present(imagePicker, animated: true)
    }
    
    private func openSafari(with url: URL){
        let safari = SFSafariViewController(url: url)
        safari.delegate = self
        present(safari, animated: true)
    }
}


extension ImagePickerViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let newImage = info[.editedImage] as? UIImage{
            image.image = newImage
        }
        dismiss(animated: true)
    }
}

extension ImagePickerViewController: SFSafariViewControllerDelegate{
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        controller.dismiss(animated: true)
    }
}



//#Preview {
//    ImagePickerViewController()
//}
