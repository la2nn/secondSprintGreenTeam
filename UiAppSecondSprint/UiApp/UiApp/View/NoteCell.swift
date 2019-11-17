//
//  NoteCell.swift
//  UiApp
//
//  Created by Николай Спиридонов on 13.11.2019.
//  Copyright © 2019 Artem Esolnyak. All rights reserved.
//

import UIKit

class NoteCell: UITableViewCell {

    public static let reuseId = "NoteCell"
    public var noteTextLabel = UILabel()
    private var downloadedImageView = UIImageView()
    
    public var imageURL: String? {
        didSet {
            guard imageURL != nil else { return }
            setImageView()
        }
    }
    
    public var downloadedImage: UIImage? {
        didSet {
            guard downloadedImage != nil else { return }
            setImageView()
        }
    }
    
    var selfIndex: Int?
    var delegate: NoteCellDelegate?
    var addPhotoButton: UIButton?
    var view = UIView()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = .clear
        
        view.frame = self.frame
        self.contentView.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant:  -10).isActive = true
        view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        view.backgroundColor = #colorLiteral(red: 0.9031211734, green: 0.9114542603, blue: 0.9323555827, alpha: 1)
        view.layer.cornerRadius = 10
    
        view.addSubview(noteTextLabel)
        noteTextLabel.translatesAutoresizingMaskIntoConstraints = false
        
        if imageURL == nil && downloadedImage == nil {
            setButton()
        } else {
            setImageView()
        }
        noteTextLabel.backgroundColor = .clear
        noteTextLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 3).isActive = true
        noteTextLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant:  -3).isActive = true
        noteTextLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -5).isActive = true
        noteTextLabel.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.2).isActive = true
        
        noteTextLabel.numberOfLines = 1
    }
    
    func setImageView() {
        addPhotoButton?.isHidden = true
        downloadedImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(downloadedImageView)
        downloadedImageView.contentMode = .scaleAspectFit
        
        let indicator = UIActivityIndicatorView(style: .gray)
        downloadedImageView.addSubview(indicator)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.centerXAnchor.constraint(equalTo: downloadedImageView.centerXAnchor).isActive = true
        indicator.centerYAnchor.constraint(equalTo: downloadedImageView.centerYAnchor).isActive = true
        indicator.startAnimating()
        
        if downloadedImage == nil {
            downloadImage(url: imageURL!) { (image) in
                DispatchQueue.main.async {
                    NotesDataModel.shared.dataModel[self.selfIndex!].image = image
                    self.downloadedImageView.image = image
                    indicator.stopAnimating()
                }
            }
        } else {
            DispatchQueue.main.async {
                indicator.stopAnimating()
            }
            self.downloadedImageView.image = downloadedImage
        }
        
        downloadedImageView.layer.cornerRadius = 10
        
//        downloadedImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 10).isActive = true
//        downloadedImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9).isActive = true
//        downloadedImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        downloadedImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        downloadedImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 10).isActive = true
        downloadedImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9).isActive = true
        downloadedImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        downloadedImageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.6).isActive = true
    }
    
    func downloadImage(url: String, callback: @escaping (UIImage?) -> Void) {
        let config = URLSessionConfiguration.default
        var request = URLRequest(url: URL(string: url)!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 40)
        request.addValue("image/png", forHTTPHeaderField: "Content-Type")
                
        URLSession(configuration: config).dataTask(with: request) { (data, response, error) in
            guard let data = data else { callback(nil) ; return }
            callback(UIImage(data: data))
        }.resume()
    }
    
    func setButton() {
        let button = UIButton(type: .system)
        button.setTitle(" Загрузить изображение", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(button)
        button.backgroundColor = #colorLiteral(red: 0.1170291379, green: 0.6328371167, blue: 0.951066196, alpha: 1)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(addPhoto), for: .touchUpInside)
        button.topAnchor.constraint(equalTo: view.topAnchor, constant: 10).isActive = true
        button.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.4).isActive = true
        button.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6).isActive = true
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        noteTextLabel.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.6).isActive = true
        
        self.addPhotoButton = button
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    @objc private func addPhoto() {
        delegate?.addPhotoButtonPressed(cellIndex: self.selfIndex)
    }
    
    override func updateConstraints() {
        
        if imageURL == nil || downloadedImage == nil {
            self.contentView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        } else {
            self.contentView.heightAnchor.constraint(equalToConstant: 200).isActive = true
            downloadedImageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.76).isActive = true
            noteTextLabel.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.2).isActive = true
        }
        
        super.updateConstraints()
    }
    
    override class var requiresConstraintBasedLayout: Bool {
        return true
    }

}

protocol NoteCellDelegate {
    func addPhotoButtonPressed(cellIndex: Int?)
}
