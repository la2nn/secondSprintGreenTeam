//
//  TasksColumnCell.swift
//  UiApp
//
//  Created by Николай Спиридонов on 11.11.2019.
//  Copyright © 2019 Artem Esolnyak. All rights reserved.
//

import UIKit

class TasksColumnCell: UICollectionViewCell {
    
    private var tableView = SelfSizedTableView()
    public var index = CollectionViewDataModel.shared.dataModel.count - 1
    public static let reuseId = "ColumnCell"
    
    var delegate: TasksColumnCellDelegate?
    
    private var cellCount: Int {
        return CollectionViewDataModel.shared.dataModel[index].textForEachLabel.count
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapGestureHandle(tap:)))
        self.addGestureRecognizer(tapGesture)
        
        tableView.frame = CGRect(x: 0, y: 0, width: frame.width, height: 150)
        tableView.backgroundColor = #colorLiteral(red: 0.9210130572, green: 0.9253756404, blue: 0.9426833987, alpha: 1)
        tableView.layer.cornerRadius = 10
        tableView.separatorStyle = .none
        tableView.rowHeight = 120
        
        tableView.tableFooterView = {
            let view = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: 30))
            let footerButton = UIButton(type: .contactAdd)
            footerButton.setTitle(" Добавить карточку", for: .normal)
            footerButton.frame = view.frame
            footerButton.addTarget(self, action: #selector(createNewTask), for: .touchUpInside)
            view.addSubview(footerButton)
            return view
        }()
        
        tableView.tableHeaderView = {
            let textField = UITextField(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: 30))
            textField.textAlignment = .center
            textField.text = CollectionViewDataModel.shared.dataModel[index].columnName
            return textField
        }()
        
        self.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.heightAnchor.constraint(lessThanOrEqualToConstant: frame.height).isActive = true
        tableView.widthAnchor.constraint(equalToConstant: frame.width).isActive = true
        
        tableView.bounces = false
        tableView.showsVerticalScrollIndicator = false
        
        tableView.dataSource = self
        
        tableView.register(TasksTableViewCell.self, forCellReuseIdentifier: TasksTableViewCell.tableCellReuseId)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension TasksColumnCell: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellCount
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TasksTableViewCell.tableCellReuseId,
                                                 for: indexPath) as! TasksTableViewCell

        cell.infoLabel.text = CollectionViewDataModel.shared.dataModel[index].textForEachLabel[indexPath.row]
        cell.selectionStyle = .none
        cell.delegate = self

        return cell
    }
    
    @objc private func createNewTask() {
        delegate?.getTextFromAlertController(completionHandler: { (str) in
            guard str != "" else { return }
            self.tableView.performBatchUpdates({
                CollectionViewDataModel.shared.dataModel[self.index].textForEachLabel.append(str)
                self.tableView.insertRows(at: [IndexPath(row: self.tableView.numberOfRows(inSection: 0), section: 0)],
                                          with: .automatic)
            }, completion: { _ in
                self.tableView.reloadData()
            })
        })
       
    }
}

extension TasksColumnCell {
    @objc private func tapGestureHandle(tap: UITapGestureRecognizer) {
        guard self.hitTest(tap.location(in: self), with: nil) as? UITextField == nil else { return }
        self.endEditing(true)
    }
}

extension TasksColumnCell: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        CollectionViewDataModel.shared.dataModel[index].columnName = textField.text ?? "Имя колонны..."
    }
}

extension TasksColumnCell: TasksTableViewCellDelegate {
    func showFull(text: String) {
        self.delegate?.showMessage(text: text)
    }
}

protocol TasksColumnCellDelegate {
    func getTextFromAlertController(completionHandler: @escaping (String) -> Void)
    func showMessage(text: String)
}
