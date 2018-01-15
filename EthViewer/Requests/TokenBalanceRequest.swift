//
//  TokenBalanceRequest.swift
//  EthViewer
//
//  Created by Elliott Minns on 15/01/2018.
//  Copyright © 2018 Elliott Minns. All rights reserved.
//

import Foundation

struct TokenBalanceRequest: EtherscanBalanceRequest {
  
  typealias ParsedType = Double
  
  let action: EtherscanAction
  
  let address: String
  
  init(address: String, token: Token) {
    self.action = EtherscanAction.tokenBalance(token)
    self.address = address
  }
}
