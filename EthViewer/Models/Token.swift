//
//  Tokens.swift
//  EthViewer
//
//  Created by Elliott Minns on 15/01/2018.
//  Copyright © 2018 Elliott Minns. All rights reserved.
//

import Foundation

enum Token: String {
  case gnt
  case omg
  case rep
}

extension Token {
  
  var ticker: String {
    return self.rawValue.uppercased()
  }
  
  var name: String {
    switch self {
    case .gnt: return "GOLEM"
    case .omg: return "OmiseGo"
    case .rep: return "Augur"
    }
  }
  
  var contractAddress: String {
    switch self {
    case .gnt: return "0xa74476443119A942dE498590Fe1f2454d7D4aC0d"
    case .omg: return "0xd26114cd6EE289AccF82350c8d8487fedB8A0C07"
    case .rep: return "0xe94327d07fc17907b4db788e5adf2ed424addff6"
    }
  }
}
