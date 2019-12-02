//
//  CreateNewColumnCell.swift
//  UiApp
//
//  Created by Николай Спиридонов on 11.11.2019.
//  Copyright © 2019 Artem Esolnyak. All rights reserved.
//

import UIKit

class CreateNewColumnCell: UICollectionReusableView {
    
    var delegate: CreateNewColumnCellDelegate?
    private let createColumnButton = UIButton(type: .contactAdd)
    public static let reuseId = "NewColumnCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = #colorLiteral(red: 0.4858267307, green: 0.807525456, blue: 0.5585768819, alpha: 1)
        
        self.frame = CGRect(x: 0, y: 0, width: frame.width, height: 60)
  
        createColumnButton.frame = CGRect(x: 0, y: 0, width: frame.width, height: 60)
        createColumnButton.setTitle("Добавить список", for: .normal)
        createColumnButton.addTarget(self, action: #selector(buttonDidTouch), for: .touchUpInside)
        self.addSubview(createColumnButton)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func buttonDidTouch() {
        delegate?.buttonDidTouch(item: self)
    }
    
    @objc private func backgroundColorDidChange() {
        delegate?.backgroundColorDidChange?(newColor: self.backgroundColor!)
    }
    
}

@objc protocol CreateNewColumnCellDelegate {
    func buttonDidTouch(item: CreateNewColumnCell)
    @objc optional func backgroundColorDidChange(newColor: UIColor)
}
