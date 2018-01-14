//
//  BalanceView.swift
//  EthViewer
//
//  Created by Elliott Minns on 14/01/2018.
//  Copyright © 2018 Elliott Minns. All rights reserved.
//

import UIKit

class BalanceView: UIView {
  
  let titleLabel = UILabel()
  
  let balanceLabel = UILabel()
  
  let title: String
  
  var balance: String {
    didSet {
      updateBalance()
    }
  }
  
  init(title: String, balance: String) {
    self.title = title
    self.balance = balance
    super.init(frame: CGRect.zero)
    setupViews()
    updateBalance()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func setupViews() {
    titleLabel.text = title
    
    let titleFont = UIFont.systemFont(ofSize: 24)
    let balanceFont = UIFont.systemFont(ofSize: 28)
    
    titleLabel.font = titleFont
    balanceLabel.font = balanceFont
    
    let stackView = UIStackView(arrangedSubviews: [titleLabel, balanceLabel])
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.axis = .vertical
    stackView.alignment = .center
    stackView.distribution = .equalCentering
    addSubview(stackView)
    
    stackView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    stackView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
  }
  
  func updateBalance() {
    balanceLabel.text = "\(balance) ETH"
  }
}
