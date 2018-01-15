//
//  TokenTableViewController.swift
//  EthViewer
//
//  Created by Elliott Minns on 15/01/2018.
//  Copyright © 2018 Elliott Minns. All rights reserved.
//

import UIKit

class TokenTableViewController: UITableViewController {
  
  let tokens: [Token]
  
  let amounts: [Token: Double]
  
  let rates: [Token: Double]
  
  init(tokens: [Token], amounts: [Token: Double], rates: [Token: Double]) {
    self.tokens = tokens
    self.amounts = amounts
    self.rates = rates
    super.init(nibName: nil, bundle: nil)
    tableView.register(cellClass: TokenTableViewCell.self)
    title = "ERC-20 Tokens"
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return tokens.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let token = self.tokens[indexPath.row]
    let cell = tableView.dequeReusableCell(for: TokenTableViewCell.self)

    let amount = amounts[token] ?? 0
    let etherValue = (self.rates[token] ?? 0) * amount
    cell.configure(with: token, amount: amount, etherValue: etherValue)
    
    return cell
  }
  
  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 64
  }
}
