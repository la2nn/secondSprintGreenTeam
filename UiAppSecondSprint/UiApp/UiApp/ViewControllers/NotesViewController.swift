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
        tableView.rowHeight = 100
        tableView.register(NoteCell.self, forCellReuseIdentifier: NoteCell.reuseId)
        
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
                NotesDataModel.shared.dataModel.append(alertController.textFields?.first?.text ?? "")
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
        cell.textLabel?.text = NotesDataModel.shared.dataModel[indexPath.row]
        cell.textLabel?.numberOfLines = 0
        return cell
    }
    
}

extension NotesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        tableView.performBatchUpdates({
            let alertController = UIAlertController(title: "Редактирование заметки: ", message: nil, preferredStyle: .alert)
            
            alertController.addTextField(configurationHandler: { field in
                field.text = NotesDataModel.shared.dataModel[indexPath.row]
            })
            
            alertController.addAction(UIAlertAction(title: "Сохранить", style: .destructive, handler: { (_) in
                NotesDataModel.shared.dataModel[indexPath.row] = alertController.textFields?.first?.text ?? ""
                self.tableView.reloadRows(at: [indexPath], with: .automatic)
            }))
            
            alertController.addAction(UIAlertAction(title: "Отменить", style: .cancel, handler: nil))
            
            present(alertController, animated: true)
            
        }, completion: nil)
    }
}
