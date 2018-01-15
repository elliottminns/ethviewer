//
//  MainScreenViewController.swift
//  EthViewer
//
//  Created by Elliott Minns on 14/01/2018.
//  Copyright © 2018 Elliott Minns. All rights reserved.
//

import UIKit

class MainScreenViewController: UIViewController {
  
  let address: String = "0x082d3e0f04664b65127876e9A05e2183451c792a"
  
  let accountBalanceView: BalanceView
  
  let tokenBalanceView: BalanceView
  
  let viewMoreButton = UIButton()
  
  let stack = UIStackView()
  
  var refreshButton: UIBarButtonItem?
  
  init() {
    accountBalanceView = BalanceView(title: "Account Balance", balance: "0.00")
    tokenBalanceView = BalanceView(title: "ERC-20 Balance", balance: "0.00")
    super.init(nibName: nil, bundle: nil)
    setupViews()
    title = "Balances"
    self.refreshButton = UIBarButtonItem(barButtonSystemItem: .refresh,
                                         target: self,
                                         action: #selector(refresh))
    navigationItem.rightBarButtonItem = refreshButton
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func setupViews() {
    stack.translatesAutoresizingMaskIntoConstraints = false
    
    view.backgroundColor = UIColor.white
    
    viewMoreButton.setTitle("view more", for:.normal)
    viewMoreButton.setTitleColor(UIColor.blue, for: .normal)
    
    stack.addArrangedSubview(accountBalanceView)
    stack.addArrangedSubview(tokenBalanceView)
    stack.addArrangedSubview(viewMoreButton)

    view.addSubview(stack)
    
    stack.axis = .vertical
    stack.alignment = .center
    stack.distribution = .fillEqually

    stack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
    stack.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
    stack.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    stack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    refresh()
  }
  
  @objc
  func refresh() {
    updateBalances(with: BalanceService(address: address,
                                        tokens: [Token.gnt, .omg, .rep]))
  }
  
  func updateBalances<T: Gettable>(with service: T) where T.ResultType == AccountBalance {
    refreshButton?.isEnabled = false

    service.get { (result) in
      switch result {
      case .success(let balance):
        let fmt = { (balance: Double) -> String in
          return String(format: "%.5f", balance)
        }
        self.accountBalanceView.balance = fmt(balance.account)
        self.tokenBalanceView.balance = fmt(balance.ethValue(for: [Token.gnt, .omg, .rep]))
      case .failure(_): break
      }
      
      self.refreshButton?.isEnabled = true
    }
  }
}
