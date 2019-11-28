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
    var loadingIndicator = UIActivityIndicatorView(style: .gray)
    
    private lazy var imagePicker = ImagePicker()
    private weak var imageView: UIImageView!
            
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(loadingIndicator)
        loadingIndicator.translatesAutoresizingMaskIntoConstraints = false
        loadingIndicator.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        loadingIndicator.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor).isActive = true
        loadingIndicator.heightAnchor.constraint(equalToConstant: 60).isActive = true
        loadingIndicator.widthAnchor.constraint(equalToConstant: 60).isActive = true
        
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
        tableView.rowHeight = 200
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
        
        view.bringSubviewToFront(loadingIndicator)
        showIndicator()
               
        /* GET Notes
        let config = URLSessionConfiguration.default
        var request = URLRequest(url: URL(string: "https://sprint-e1df8.firebaseio.com/notes.json?auth=7ptTMrMXzwLqEHn3PnhDwDpipWCXJnhwnVwGeacW")!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 40)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession(configuration: config).dataTask(with: request) { (data, response, error) in
            guard let data = data else { self.hideIndicator() ; return }
            do {
                NotesDataModel.shared.dataModel = try JSONDecoder().decode([NotesDataModel.CellDataModel].self, from: data)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } catch {
                print(error.localizedDescription)
            }
            self.hideIndicator()
        }.resume() */
        
    }

    init() {
        super.init(nibName: nil, bundle: nil)
        self.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "notes"), tag: 1)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func showIndicator() {
        DispatchQueue.main.async {
            self.loadingIndicator.startAnimating()
        }
    }
    
    private func hideIndicator() {
        DispatchQueue.main.async {
            self.loadingIndicator.stopAnimating()
        }
    }
    
    @objc private func addButtonTapped() {
        tableView.performBatchUpdates({
            let alertController = UIAlertController(title: "Введите текст для заметки", message: nil, preferredStyle: .alert)
            
            alertController.addTextField(configurationHandler: nil)
            
            alertController.addAction(UIAlertAction(title: "Сохранить", style: .destructive, handler: { (_) in
                self.showIndicator()
                NotesDataModel.shared.dataModel.append(NotesDataModel.CellDataModel(text: alertController.textFields?.first?.text ?? ""))
                
                NotesDataModel.uploadNotesToFirebase { (_) in
                    self.hideIndicator()
                }
                
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
        let cell = NoteCell(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: tableView.rowHeight))
     //   let cell = tableView.dequeueReusableCell(withIdentifier: NoteCell.reuseId, for: indexPath) as! NoteCell
        if NotesDataModel.shared.dataModel[indexPath.row].image == nil {
            if let imageURL = NotesDataModel.shared.dataModel[indexPath.row].imageURL, imageURL != "nil", cell.imageURL == nil {
                cell.imageURL = imageURL
            }
        } else {
            cell.downloadedImage = NotesDataModel.shared.dataModel[indexPath.row].image!
        }
        cell.delegate = self
        cell.selfIndex = indexPath.row
        cell.selectionStyle = .none
        cell.noteTextLabel.textAlignment = .center
        cell.noteTextLabel.text = NotesDataModel.shared.dataModel[indexPath.row].text
        return cell
    }
}

extension NotesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.performBatchUpdates({
            let alertController = UIAlertController(title: "Содержимое заметки: ", message: NotesDataModel.shared.dataModel[indexPath.row].text, preferredStyle: .alert)
            
            alertController.addAction(UIAlertAction(title: "Ок", style: .cancel, handler: nil))
            
            present(alertController, animated: true)
            
        }, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.performBatchUpdates({
                self.showIndicator()
                NotesDataModel.shared.dataModel.remove(at: indexPath.row)
                NotesDataModel.uploadNotesToFirebase { (_) in
                    self.hideIndicator()
                }
                tableView.deleteRows(at: [indexPath], with: .automatic)
            }, completion: nil)
        }
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
            if let cell = tableView.cellForRow(at: IndexPath(row: index, section: 0)) as? NoteCell {
                cell.imageView?.image = image
            }
            tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
        }, completion: nil)
        imagePicker.dismiss()
    }

    func imagePickerDelegate(didCancel delegatedForm: ImagePicker) { imagePicker.dismiss() }

    func imagePickerDelegate(canUseGallery accessIsAllowed: Bool, delegatedForm: ImagePicker) {
        if accessIsAllowed { presentImagePicker(sourceType: .photoLibrary) }
    }

    func imagePickerDelegate(canUseCamera accessIsAllowed: Bool, delegatedForm: ImagePicker) {
        if accessIsAllowed { presentImagePicker(sourceType: .camera) }
    }
    
    private func presentImagePicker(sourceType: UIImagePickerController.SourceType) {
           imagePicker.present(parent: self, sourceType: sourceType)
       }
    
    func photoButtonTapped(cellIndex: Int?) { imagePicker.photoGalleryAsscessRequest(cellIndex: cellIndex) }
    func cameraButtonTapped(cellIndex: Int?) { imagePicker.cameraAsscessRequest(cellIndex: cellIndex) }
}
