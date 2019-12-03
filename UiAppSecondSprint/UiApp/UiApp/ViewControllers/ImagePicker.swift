//
//  ImagePickerViewController.swift
//  UiApp
//
//  Created by Николай Спиридонов on 13.11.2019.
//  Copyright © 2019 Artem Esolnyak. All rights reserved.
//

import AVFoundation
import Photos
import UIKit

protocol ImagePickerDelegate  {
    func imagePickerDelegate(canUseCamera accessIsAllowed: Bool, delegatedForm: ImagePicker)
    func imagePickerDelegate(canUseGallery accessIsAllowed: Bool, delegatedForm: ImagePicker)
    func imagePickerDelegate(didSelect image: UIImage, delegatedForm: ImagePicker)
    func imagePickerDelegate(didCancel delegatedForm: ImagePicker)
}

class ImagePicker: NSObject {
    
    weak var controller: UIImagePickerController?
    var cellIndex: Int?
    var delegate: ImagePickerDelegate?
    var imageIndicator = UIActivityIndicatorView(style: .gray)
    
    func present(parent viewController: UIViewController, sourceType: UIImagePickerController.SourceType) {
        let controller = UIImagePickerController()
        controller.delegate = self
        controller.sourceType = sourceType
        self.controller = controller
        DispatchQueue.main.async {
            viewController.present(controller, animated: true, completion: nil)
        }
    }
    
    func dismiss() { controller?.dismiss(animated: true, completion: nil) }
}

extension ImagePicker {
    
    private func showAlert(targetName: String, completion: @escaping (Bool)->()) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            let alertVC = UIAlertController(title: "Access to the \(targetName)",
                message: "Please provide access to your \(targetName)",
                preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "Settings", style: .default, handler: { action in
                guard let settingsUrl = URL(string: UIApplication.openSettingsURLString),
                    UIApplication.shared.canOpenURL(settingsUrl) else { completion(false); return }
                UIApplication.shared.open(settingsUrl, options: [:]) {
                    [weak self] _ in self?.showAlert(targetName: targetName, completion: completion)
                }
            }))
            alertVC.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { _ in completion(false) }))
            UIApplication.shared.delegate?.window??.rootViewController?.present(alertVC, animated: true, completion: nil)
        }
    }
    
    func cameraAsscessRequest(cellIndex: Int?) {
        self.cellIndex = cellIndex
        if AVCaptureDevice.authorizationStatus(for: .video) == .authorized {
            delegate?.imagePickerDelegate(canUseCamera: true, delegatedForm: self)
        } else {
            AVCaptureDevice.requestAccess(for: .video) { [weak self] granted in
                guard let self = self else { return }
                if granted {
                    self.delegate?.imagePickerDelegate(canUseCamera: granted, delegatedForm: self)
                } else {
                    self.showAlert(targetName: "camera") { self.delegate?.imagePickerDelegate(canUseCamera: $0, delegatedForm: self) }
                }
            }
        }
    }
    
    func photoGalleryAsscessRequest(cellIndex: Int?) {
        self.cellIndex = cellIndex
        PHPhotoLibrary.requestAuthorization { [weak self] result in
            guard let self = self else { return }
            if result == .authorized {
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    self.delegate?.imagePickerDelegate(canUseGallery: result == .authorized, delegatedForm: self)
                }
            } else {
                self.showAlert(targetName: "photo gallery") { self.delegate?.imagePickerDelegate(canUseCamera: $0, delegatedForm: self) }
            }
        }
    }
}

extension ImagePicker: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        self.controller?.view.addSubview(imageIndicator)
        imageIndicator.translatesAutoresizingMaskIntoConstraints = false
        imageIndicator.centerXAnchor.constraint(equalTo: self.controller!.view.centerXAnchor).isActive = true
        imageIndicator.centerYAnchor.constraint(equalTo: self.controller!.view.centerYAnchor).isActive = true
        imageIndicator.startAnimating()
        
        if let image = info[.editedImage] as? UIImage, let index = self.cellIndex {
            if image.pngData()!.getSizeInMB() > 15.0 {
                print("wrong size")
                delegate?.imagePickerDelegate(didCancel: self)
                return
            }
            NotesDataModel.shared.dataModel[index].image = image
            setNetworking(image: image, index: index) {
                DispatchQueue.main.async {
                    self.imageIndicator.stopAnimating()
                    self.delegate?.imagePickerDelegate(didSelect: image, delegatedForm: self)
                }
            }
            return
        }
        
        if let image = info[.originalImage] as? UIImage, let index = self.cellIndex {
            if image.pngData()!.getSizeInMB() > 15.0 {
                print("wrong size")
                delegate?.imagePickerDelegate(didCancel: self)
                return
            }
            NotesDataModel.shared.dataModel[index].image = image
            setNetworking(image: image, index: index) {
                DispatchQueue.main.async {
                    self.imageIndicator.stopAnimating()
                    self.delegate?.imagePickerDelegate(didSelect: image, delegatedForm: self)
                }
            }
        }
    }
    
    func setNetworking(image: UIImage, index: Int, _ callback: @escaping() -> ()){
        let config = URLSessionConfiguration.default
        var request = URLRequest(url: URL(string: "https://api.imgbb.com/1/upload?key=7285e498926e9680f20c71e000616bc4")!)
        request.addValue("multipart/form-data", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        try! request.setMultipartFormData(["image" : image.pngData()!.base64EncodedString(options: .lineLength64Characters)], encoding: .utf8)
        
        URLSession(configuration: config).dataTask(with: request) { (data, response, error) in
            guard let data = data else { return }
            do {
                let json = try JSONDecoder().decode(JSONDecodable.self, from: data)
                NotesDataModel.shared.dataModel[index].imageURL = json.data.url
                NotesDataModel.uploadNotesToFirebase { (_) in  }
            } catch {
                print(error.localizedDescription)
            }
            callback()
        }.resume()
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        delegate?.imagePickerDelegate(didCancel: self)
    }    
    
    // MARK: - DecodeJSON
    struct JSONDecodable: Codable {
        let data: DataClass
        let success: Bool
        let status: Int
    }

    // MARK: - DataClass
    struct DataClass: Codable {
        let id: String
        let urlViewer: String
        let url, displayURL: String
        let title, time: String
        let image: Image
        let thumb, medium: Medium
        let deleteURL: String

        enum CodingKeys: String, CodingKey {
            case id
            case urlViewer = "url_viewer"
            case url
            case displayURL = "display_url"
            case title, time, image, thumb, medium
            case deleteURL = "delete_url"
        }
    }

    // MARK: - Image
    struct Image: Codable {
        let filename, name, mime, imageExtension: String
        let url: String
        let size: Int

        enum CodingKeys: String, CodingKey {
            case filename, name, mime
            case imageExtension = "extension"
            case url, size
        }
    }

    // MARK: - Medium
    struct Medium: Codable {
        let filename, name, mime, mediumExtension: String
        let url: String
        let size: String

        enum CodingKeys: String, CodingKey {
            case filename, name, mime
            case mediumExtension = "extension"
            case url, size
        }
    }
}
