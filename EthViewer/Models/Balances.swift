//
//  Balances.swift
//  EthViewer
//
//  Created by Elliott Minns on 15/01/2018.
//  Copyright © 2018 Elliott Minns. All rights reserved.
//

import Foundation

struct AccountBalance {
  
  let address: String
  
  let account: Double
  
  let tokens: [Token: Double]
  
  let rates: [Token: Double]
  
  func ethValue(for tokens: [Token]) -> Double {
    let tokenBalance = tokens.reduce(0, { (result, token) -> Double in
      guard let tokenAmount = self.tokens[token],
        let rate = rates[token] else { return result }
      
      return result + tokenAmount * rate
    })
    return tokenBalance
  }
}
