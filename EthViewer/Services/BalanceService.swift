//
//  BalanceService.swift
//  EthViewer
//
//  Created by Elliott Minns on 15/01/2018.
//  Copyright © 2018 Elliott Minns. All rights reserved.
//

import UIKit

enum BalanceServiceError: Error {
  case incompleteAccountBalance
  case incompleteTokenBalance
}

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
    
    var errors: [Error] = []
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
      } else if case let .failure(err) = result {
        errors.append(err)
      }
    }
    
    tokens.forEach { token in
      group.enter()
      TokenBalanceRequest(address: address, token: token).perform { result in
        if case let .success(balance) = result {
          tokenBalances[token] = balance
        } else if case let .failure(err) = result {
          errors.append(err)
        }
        group.leave()
      }
      
      group.enter()
      EthConversionRequest(token: token).perform { result in
        if case let .success(rate) = result {
          rates[token] = rate
        } else if case let .failure(err) = result {
          errors.append(err)
        }
        group.leave()
      }
    }
    
    group.notify(queue: DispatchQueue.main) {
      guard errors.count == 0 else {
        let error = errors[0]
        return callback(.failure(error))
      }
      
      guard let account = accountBalance else {
        let error = BalanceServiceError.incompleteAccountBalance
        return callback(.failure(error))
      }
      
      guard tokenBalances.count == self.tokens.count &&
        rates.count == self.tokens.count else {
          
        let error = BalanceServiceError.incompleteTokenBalance
        return callback(.failure(error))
      }
      
      UIApplication.shared.isNetworkActivityIndicatorVisible = false
      
      let balance = AccountBalance(address: self.address, account: account,
                                   tokens: tokenBalances, rates: rates)
      callback(.success(balance))
    }
    
    group.leave()
  }
}
