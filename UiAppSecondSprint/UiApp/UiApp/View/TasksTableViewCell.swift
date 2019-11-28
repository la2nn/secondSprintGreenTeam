//
//  TasksTableViewCell.swift
//  UiApp
//
//  Created by Николай Спиридонов on 11.11.2019.
//  Copyright © 2019 Artem Esolnyak. All rights reserved.


import UIKit

class TasksTableViewCell: UITableViewCell {
    
    public var infoLabel = SelfSizedUILabel()
    public static let tableCellReuseId = "TableCell"
    var delegate: TasksTableViewCellDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let view = UIView(frame: self.frame)
        view.backgroundColor = #colorLiteral(red: 0.9210130572, green: 0.9253756404, blue: 0.9426833987, alpha: 1)

        view.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(view)
        view.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        view.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        view.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        view.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(infoLabel)
        infoLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5).isActive = true
        infoLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5).isActive = true
        infoLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10).isActive = true
        infoLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 10).isActive = true
        
        infoLabel.lineBreakMode = .byTruncatingTail
        infoLabel.numberOfLines = 0
        infoLabel.layer.cornerRadius = 10
        infoLabel.clipsToBounds = true
        infoLabel.backgroundColor = .white
        infoLabel.isUserInteractionEnabled = true
        
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    @objc private func handleTap() {
        guard let text = self.infoLabel.text else { return }
        delegate?.showFull(text: text)
    }

}

protocol TasksTableViewCellDelegate {
    func showFull(text: String)
}
