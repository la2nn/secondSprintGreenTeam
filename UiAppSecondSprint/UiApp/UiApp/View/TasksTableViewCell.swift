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
    private var heightLabelConstraint: NSLayoutConstraint!
    var delegate: TasksTableViewCellDelegate?
    var isTapped = false {
        didSet {
            delegate?.didTouch(cell: self)
        }
    }
    
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
        heightLabelConstraint = NSLayoutConstraint(item: infoLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 100)
        heightLabelConstraint.isActive = true
        infoLabel.addConstraint(heightLabelConstraint)
       // infoLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        //infoLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
       
        infoLabel.addConstraint(heightLabelConstraint)
       // infoLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10).isActive = true
        infoLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 10).isActive = true
        
        infoLabel.lineBreakMode = .byTruncatingTail
        infoLabel.numberOfLines = 0
        infoLabel.layer.cornerRadius = 10
        infoLabel.clipsToBounds = true
        infoLabel.backgroundColor = .white
        infoLabel.isUserInteractionEnabled = true
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap(sender:))))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    @objc private func handleTap(sender: UITapGestureRecognizer) {
        guard let label = hitTest(sender.location(in: self), with: nil) as? UILabel else { return }
        
        if label.frame.height == 100 {
            //let height = NSLayoutDimension()
           // height.constraint(equalToConstant: label.textRect(forBounds: CGRect(x: 0, y: 0, width: label.frame.width, height: 9999), limitedToNumberOfLines: 0).height)
            
            UIView.animate(withDuration: 0.3, animations: {
                let increaseValue = label.textRect(forBounds: CGRect(x: 0, y: 0, width: label.frame.width, height: 9999), limitedToNumberOfLines: 0).height
                self.heightLabelConstraint.constant = max(increaseValue, 100)
                label.setNeedsLayout()
                label.layoutIfNeeded()
            }) { (_) in
                self.isTapped = true
            }
            
           
            //UIView.animate(withDuration: 0.3) {
             //   label.heightAnchor.constraint(equalToConstant: label.textRect(forBounds: CGRect(x: 0, y: 0, width: label.frame.width, height: 9999), limitedToNumberOfLines: 0).height).isActive = true
            //}
        }
    }

}

protocol TasksTableViewCellDelegate {
    func didTouch(cell: TasksTableViewCell)
}
