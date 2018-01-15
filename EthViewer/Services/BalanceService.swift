//
//  BalanceService.swift
//  EthViewer
//
//  Created by Elliott Minns on 15/01/2018.
//  Copyright © 2018 Elliott Minns. All rights reserved.
//

import UIKit

struct BalanceService: Gettable {
  
  let address: String
  
  let tokens: [Token]
  
  typealias ResultType = AccountBalance
  
  init(address: String, tokens: [Token]) {
    self.address = address
    self.tokens = tokens
  }
  
  func get(callback: @escaping (Result<AccountBalance>) -> Void) {
    UIApplication.shared.isNetworkActivityIndicatorVisible = true
    
    var accountBalance: Double?
    var tokenBalances: [Token: Double] = [:]
    var rates: [Token: Double] = [:]

    let group = DispatchGroup()
    group.enter()
    
    group.enter()
    AccountBalanceRequest(address: address).perform { (result) in
      group.leave()
      if case let .success(balance) = result {
        accountBalance = balance
      }
    }
    
    tokens.forEach { token in
      group.enter()
      TokenBalanceRequest(address: address, token: token).perform { result in
        if case let .success(balance) = result {
          tokenBalances[token] = balance
        }
        group.leave()
      }
      
      group.enter()
      EthConversionRequest(token: token).perform { result in
        if case let .success(rate) = result {
          rates[token] = rate
        }
        group.leave()
      }
    }
    
    group.notify(queue: DispatchQueue.main) {
      guard let account = accountBalance else {
        let error = RequestError(message: "Could not load up the accounts")
        return callback(.failure(error))
      }
      
      let balance = AccountBalance(address: self.address, account: account,
                                   tokens: tokenBalances, rates: rates)

      UIApplication.shared.isNetworkActivityIndicatorVisible = false
      callback(.success(balance))
    }
    group.leave()
  }
}
