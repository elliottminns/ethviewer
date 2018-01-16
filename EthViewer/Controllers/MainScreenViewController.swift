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
  
  let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
  
  let accountBalanceView: BalanceView
  
  let tokenBalanceView: BalanceView
  
  let viewMoreButton = UIButton()
  
  let stack = UIStackView()
  
  var refreshButton: UIBarButtonItem?
  
  var activityItem = UIActivityIndicatorView(activityIndicatorStyle: .gray)
  
  let tokens = [Token.gnt, .omg, .rep]
  
  let retryButton = UIButton()
  
  var balance: AccountBalance? {
    didSet {
      guard let balance = balance else { return }
      
      if stack.alpha == 0.0 {
        activityIndicator.stopAnimating()
        UIView.animate(withDuration: 0.6, delay: 0.0, options: .curveEaseInOut, animations: {
          self.stack.alpha = 1.0
        }, completion: nil)
      }
      
      let fmt = { (balance: Double) -> String in
        return String(format: "%.2f", balance)
      }
      accountBalanceView.balance = fmt(balance.account)
      tokenBalanceView.balance = fmt(balance.ethValue(for: self.tokens))
    }
  }
  
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
    stack.alpha = 0.0
    activityIndicator.hidesWhenStopped = true
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func setupViews() {
    view.addSubview(activityIndicator)
    view.addSubview(stack)
    view.addSubview(retryButton)
    
    activityIndicator.translatesAutoresizingMaskIntoConstraints = false
    activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    activityIndicator.startAnimating()
    
    stack.translatesAutoresizingMaskIntoConstraints = false
    
    view.backgroundColor = UIColor.white
    
    retryButton.translatesAutoresizingMaskIntoConstraints = false
    retryButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    retryButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    retryButton.setTitle(NSLocalizedString("Retry", comment: ""), for: .normal)
    retryButton.titleLabel?.font = UIFont.systemFont(ofSize: 22)
    retryButton.layer.borderWidth = 1.0
    retryButton.layer.cornerRadius = 5
    retryButton.addTarget(self, action: #selector(retry), for: .touchUpInside)
    retryButton.isHidden = false
    retryButton.heightAnchor.constraint(greaterThanOrEqualToConstant: 44).isActive = true
    retryButton.widthAnchor.constraint(greaterThanOrEqualToConstant: 120).isActive = true
    
    viewMoreButton.setTitle(NSLocalizedString("View More", comment: ""), for: .normal)
    viewMoreButton.titleLabel?.font = UIFont.systemFont(ofSize: 26, weight: .semibold)
    viewMoreButton.addTarget(self, action: #selector(viewMoreButtonPressed),
                             for: .touchUpInside)
    
    stack.addArrangedSubview(accountBalanceView)
    stack.addArrangedSubview(tokenBalanceView)
    stack.addArrangedSubview(viewMoreButton)


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
    let buttonColor = navigationController?.navigationBar.tintColor
    viewMoreButton.setTitleColor(buttonColor, for: .normal)
    retryButton.setTitleColor(buttonColor, for: .normal)
    retryButton.layer.borderColor = buttonColor?.cgColor
    refresh()
  }
  
  @objc
  func retry() {
    retryButton.isHidden = true
    activityIndicator.startAnimating()
    refresh()
  }
  
  @objc
  func refresh() {
    updateBalances(with: BalanceService(address: address,
                                        tokens: [Token.gnt, .omg, .rep]))
  }
  
  func updateBalances<T: Gettable>(with service: T) where T.ResultType == AccountBalance {
    navigationItem.rightBarButtonItem = UIBarButtonItem(customView: activityItem)
    activityItem.startAnimating()
    
    refreshButton?.isEnabled = false
    viewMoreButton.isEnabled = false
    
    service.get { (result) in
      switch result {
        
      case .success(let balance):
        self.balance = balance
        
      case .failure(let error):
        self.showError(error: error)
      }
      
      self.navigationItem.rightBarButtonItem = self.refreshButton
      self.refreshButton?.isEnabled = true
      self.viewMoreButton.isEnabled = true
    }
  }
  
  func showError(error: Error) {
    let title: String
    let message: String
    
    activityIndicator.stopAnimating()
    
    if let serviceError = error as? BalanceServiceError {
      title = NSLocalizedString("Network Error", comment: "")
      switch serviceError {
      case .incompleteAccountBalance:
        message = NSLocalizedString("Could not obtain account balance, please try again.", comment: "")
      case .incompleteTokenBalance:
        message = NSLocalizedString("Could not obtain token balance, please try again.", comment: "")
      }
    } else {
      title = NSLocalizedString("Something went wrong", comment: "")
      message = error.localizedDescription
    }
    
    showAlert(title: title, message: message)
    
    if balance == nil {
      retryButton.isHidden = false
    }
  }
  
  func showAlert(title: String, message: String) {
    let alert = UIAlertController(title: title, message: message,
                                  preferredStyle: .alert)
    
    let closeAction = UIAlertAction(title: NSLocalizedString("Close", comment: ""),
                                    style: .cancel, handler: nil)
    alert.addAction(closeAction)
    present(alert, animated: true, completion: nil)
  }
  
  @objc
  func viewMoreButtonPressed() {
    guard let balance = balance else { return }
    let controller = TokenTableViewController(tokens: self.tokens,
                                              amounts: balance.tokens,
                                              rates: balance.rates)
    navigationController?.pushViewController(controller, animated: true)
  }
}
