//
//  SelfSizedTableView.swift
//  UiApp
//
//  Created by Николай Спиридонов on 12.11.2019.
//  Copyright © 2019 Artem Esolnyak. All rights reserved.
//

import UIKit

class SelfSizedTableView: UITableView {

      override var contentSize: CGSize {
          didSet {
              invalidateIntrinsicContentSize()
          }
      }

      override var intrinsicContentSize: CGSize {
          layoutIfNeeded()
          return CGSize(width: UIView.noIntrinsicMetric, height: contentSize.height)
      }

}
