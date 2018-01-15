//
//  EthConversionRequest.swift
//  EthViewer
//
//  Created by Elliott Minns on 15/01/2018.
//  Copyright © 2018 Elliott Minns. All rights reserved.
//

import Foundation

extension Token {
  var ethPair: String {
    switch self {
    case .gnt: return "gnt_eth"
    case .omg: return "omg_eth"
    case .rep: return "rep_eth"
    }
  }
}

struct EthConversionRequest {
  let path: String
  
  typealias ParsedType = Double
  
  init(token: Token) {
    path = "/rate/\(token.ethPair)"
  }
  
  func parse(json data: Any) -> Double? {
    guard let dict = data as? [String: Any],
      let rateStr = dict["rate"] as? String else { return nil }
    
    return Double(rateStr)
  }
}

extension EthConversionRequest: ShapeShiftRequest {
  
}
