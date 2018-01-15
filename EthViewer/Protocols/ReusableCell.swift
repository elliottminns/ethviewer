//
//  ReusableCell.swift
//  EthViewer
//
//  Created by Elliott Minns on 15/01/2018.
//  Copyright © 2018 Elliott Minns. All rights reserved.
//

import UIKit

protocol ReusableCell: class {}

extension ReusableCell where Self: UITableViewCell {
  static var reusableIdentifier: String { return String(describing: self) }
}

extension UITableView {
  func register<T: ReusableCell>(cellClass: T.Type) where T: UITableViewCell {
    self.register(cellClass, forCellReuseIdentifier: cellClass.reusableIdentifier)
  }
  
  func dequeReusableCell<T: ReusableCell>(for classType: T.Type) -> T where T: UITableViewCell {
    return self.dequeueReusableCell(withIdentifier: classType.reusableIdentifier) as! T
  }
  
  func dequeReusableCell<T: ReusableCell>(for classType: T.Type, for indexPath: IndexPath) -> T where T: UITableViewCell {
    return self.dequeueReusableCell(withIdentifier: classType.reusableIdentifier, for: indexPath) as! T
  }
}
