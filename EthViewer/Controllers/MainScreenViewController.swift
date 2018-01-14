//
//  MainScreenViewController.swift
//  EthViewer
//
//  Created by Elliott Minns on 14/01/2018.
//  Copyright © 2018 Elliott Minns. All rights reserved.
//

import UIKit

class MainScreenViewController: UIViewController {
  
  let accountBalanceView: BalanceView
  
  let tokenBalanceView: BalanceView
  
  let viewMoreButton = UIButton()
  
  let stack = UIStackView()
  
  init() {
    accountBalanceView = BalanceView(title: "Account Balance", balance: "0.00")
    tokenBalanceView = BalanceView(title: "ERC-20 Balance", balance: "0.00")
    super.init(nibName: nil, bundle: nil)
    setupViews()
    title = "Balances"
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
}
