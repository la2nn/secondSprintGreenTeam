//
//  CreateNoteViewController.swift
//  UiApp
//
//  Created by Artem Esolnyak on 08.11.2019.
//  Copyright © 2019 Artem Esolnyak. All rights reserved.
//

import UIKit

class NotesViewController: UIViewController {
    
    var tableView: UITableView!
    
    private lazy var imagePicker = ImagePicker()
    private weak var imageView: UIImageView!
            
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        tableView = UITableView(frame: view.frame)
        tableView.backgroundColor = #colorLiteral(red: 0.9589001536, green: 0.9590606093, blue: 0.9588790536, alpha: 1)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        tableView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        tableView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        tableView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        tableView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        tableView.dataSource = self
        tableView.delegate = self
        
        imagePicker.delegate = self

        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(NoteCell.self, forCellReuseIdentifier: NoteCell.reuseId)
        
        tableView.separatorStyle = .none
        tableView.bounces = false

        tableView.tableHeaderView = {
            let button = UIButton(type: .contactAdd)
            button.frame = CGRect(x: 0, y: 0, width: 0.7 * self.view.frame.width, height: 30)
            button.center.x = view.center.x
            button.setTitle("", for: .normal)
            button.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
            return button
        }()
        
       
    }

    init() {
        super.init(nibName: nil, bundle: nil)
        self.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "notes"), tag: 1)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func addButtonTapped() {
        tableView.performBatchUpdates({
            let alertController = UIAlertController(title: "Введите текст для заметки", message: nil, preferredStyle: .alert)
            
            alertController.addTextField(configurationHandler: nil)
            
            alertController.addAction(UIAlertAction(title: "Сохранить", style: .destructive, handler: { (_) in
                NotesDataModel.shared.dataModel.append(NotesDataModel.CellDataModel(text: alertController.textFields?.first?.text ?? ""))
                self.tableView.insertRows(at: [IndexPath(row: NotesDataModel.shared.dataModel.count - 1, section: 0)],
                                          with: .automatic)
            }))
            
            alertController.addAction(UIAlertAction(title: "Отменить", style: .cancel, handler: nil))
            
            present(alertController, animated: true)
            
        }, completion: nil)
    }
    
}

extension NotesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return NotesDataModel.shared.dataModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NoteCell.reuseId, for: indexPath) as! NoteCell
        if let image = NotesDataModel.shared.dataModel[indexPath.row].image {
            cell.downloadedImage = image
        }
        cell.delegate = self
        cell.selfIndex = indexPath.row
        cell.selectionStyle = .none
        cell.noteTextLabel.text = NotesDataModel.shared.dataModel[indexPath.row].text
        return cell
    }
    
}

extension NotesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.performBatchUpdates({
            let alertController = UIAlertController(title: "Содержимое заметки: ", message: NotesDataModel.shared.dataModel[indexPath.row].text, preferredStyle: .alert)
            
            if let titleView = alertController.view.subviews[0].subviews[0].subviews[0].subviews[0].subviews[0].subviews[1] as? UILabel,
                let messageView = alertController.view.subviews[0].subviews[0].subviews[0].subviews[0].subviews[0].subviews[2] as? UILabel,
                let image = NotesDataModel.shared.dataModel[indexPath.row].image {
                
                let imageView = UIImageView(image: image)
                imageView.translatesAutoresizingMaskIntoConstraints = false
                imageView.contentMode = .scaleAspectFit
                alertController.view.addSubview(imageView)
                imageView.topAnchor.constraint(equalTo: titleView.bottomAnchor).isActive = true
                imageView.leadingAnchor.constraint(equalTo: titleView.leadingAnchor, constant: 10).isActive = true
                imageView.trailingAnchor.constraint(equalTo: titleView.trailingAnchor, constant: -10).isActive = true
                imageView.heightAnchor.constraint(equalToConstant: self.view.frame.height * 0.3).isActive = true
                messageView.topAnchor.constraint(equalTo: imageView.bottomAnchor).isActive = true
            }
          
            
            alertController.addAction(UIAlertAction(title: "Ок", style: .cancel, handler: nil))
            
            present(alertController, animated: true)
            
        }, completion: nil)
    }
}

extension NotesViewController: NoteCellDelegate {
    func addPhotoButtonPressed(cellIndex: Int?) {
        
        let alertController = UIAlertController(title: "Загрузить фото", message: nil, preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (action) in
            self.cameraButtonTapped(cellIndex: cellIndex)
        }))
        
        alertController.addAction(UIAlertAction(title: "Library", style: .default, handler: { (action) in
            self.photoButtonTapped(cellIndex: cellIndex)
        }))
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(alertController, animated: true)
    }
}

extension NotesViewController: ImagePickerDelegate {

    func imagePickerDelegate(didSelect image: UIImage, delegatedForm: ImagePicker) {
        tableView.performBatchUpdates({
            guard let index = delegatedForm.cellIndex else { return }
            tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
        }, completion: nil)
        imagePicker.dismiss()
    }

    func imagePickerDelegate(didCancel delegatedForm: ImagePicker) { imagePicker.dismiss() }

    func imagePickerDelegate(canUseGallery accessIsAllowed: Bool, delegatedForm: ImagePicker) {
        if accessIsAllowed { presentImagePicker(sourceType: .photoLibrary) }
    }

    func imagePickerDelegate(canUseCamera accessIsAllowed: Bool, delegatedForm: ImagePicker) {
        // works only on real device (crash on simulator)
        if accessIsAllowed { presentImagePicker(sourceType: .camera) }
    }
    
    private func presentImagePicker(sourceType: UIImagePickerController.SourceType) {
           imagePicker.present(parent: self, sourceType: sourceType)
       }
    
    func photoButtonTapped(cellIndex: Int?) { imagePicker.photoGalleryAsscessRequest(cellIndex: cellIndex) }
    func cameraButtonTapped(cellIndex: Int?) { imagePicker.cameraAsscessRequest(cellIndex: cellIndex) }
}
