//
//  TokenTableViewCell.swift
//  EthViewer
//
//  Created by Elliott Minns on 15/01/2018.
//  Copyright © 2018 Elliott Minns. All rights reserved.
//

import UIKit

class TokenTableViewCell: UITableViewCell {
  
  let tokenLabel = UILabel()
  
  let amountLabel = UILabel()
  
  let etherLabel = UILabel()
  
  let stack = UIStackView()
  
  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setupViews()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func setupViews() {
    stack.translatesAutoresizingMaskIntoConstraints = false
    stack.axis = .vertical
    
    stack.addArrangedSubview(tokenLabel)
    stack.addArrangedSubview(etherLabel)
    
    contentView.addSubview(stack)
    
    stack.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 15).isActive = true
    stack.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
    
    tokenLabel.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.bold)
    amountLabel.textAlignment = .right
    
    amountLabel.translatesAutoresizingMaskIntoConstraints = false
    
    contentView.addSubview(amountLabel)
    amountLabel.topAnchor.constraint(equalTo: stack.topAnchor).isActive = true
    amountLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -8).isActive = true
    amountLabel.leftAnchor.constraint(lessThanOrEqualTo: contentView.rightAnchor, constant: 8).isActive = true
  }
  
  func configure(with token: Token, amount: Double, etherValue: Double) {
    tokenLabel.text = "\(token.name) (\(token.ticker))"
    etherLabel.text = "\(String(format: "%.3f", etherValue)) ETH"
    amountLabel.text = "\(String(format: "%.2f", amount))"
  }
}

extension TokenTableViewCell: ReusableCell {}
