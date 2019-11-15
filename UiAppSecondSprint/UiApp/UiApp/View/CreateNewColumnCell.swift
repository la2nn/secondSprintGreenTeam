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
    
   /* override class var requiresConstraintBasedLayout: Bool {
        return true
    }
    
    override func updateConstraints() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.widthAnchor.constraint(equalToConstant: frame.width).isActive = true
        self.heightAnchor.constraint(equalToConstant: 60).isActive = true
        self.topAnchor.constraint(equalTo: self.collectionView!.topAnchor, constant: 30).isActive = true
        
        if collectionView!.numberOfItems(inSection: 0) != 0 {
            if let lastCell = collectionView?.cellForItem(at: IndexPath(item: collectionView!.numberOfItems(inSection: 0) - 1, section: 0)) {
                NSLayoutConstraint(item: self, attribute: .leading, relatedBy: .equal, toItem: lastCell, attribute: .trailing, multiplier: 1, constant: 20).isActive = true
                
               // self.constraints.filter({$0.firstAnchor == leadingAnchor }).forEach{ $0.isActive = false }
               // self.leadingAnchor.constraint(equalTo: lastCell.trailingAnchor).isActive = true
            }
            
        }
        
        self.setNeedsLayout()
        self.layoutIfNeeded()

        super.updateConstraints()
    } */
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func buttonDidTouch() {
        delegate?.buttonDidTouch(item: self)
    }
    
}

protocol CreateNewColumnCellDelegate {
    func buttonDidTouch(item: CreateNewColumnCell)
}

//extension UIView {
//    func parentView<T: UIView>(of type: T.Type) -> T? {
//        guard let view = superview else {
//            return nil
//        }
//        return (view as? T) ?? view.parentView(of: T.self)
//    }
//}
//
//extension UICollectionReusableView {
//    var collectionView: UICollectionView? {
//        return parentView(of: UICollectionView.self)
//    }
//}
