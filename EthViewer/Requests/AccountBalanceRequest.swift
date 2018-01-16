//
//  AccountBalanceRequest.swift
//  EthViewer
//
//  Created by Elliott Minns on 15/01/2018.
//  Copyright © 2018 Elliott Minns. All rights reserved.
//

import Foundation

struct AccountBalanceRequest: EtherscanBalanceRequest {
  
  typealias ParsedType = Double
  
  let action: EtherscanAction = .balance
  
  let address: String
  
  init(address: String) {
    self.address = address
  }
  
  func parse(json data: Any) -> Double? {
    guard let numberStr = data as? String,
      let number = Int(numberStr) else { return nil }
    return Double(number) * 1e-18
  }
}
