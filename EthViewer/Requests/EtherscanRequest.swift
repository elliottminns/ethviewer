//
//  EtherscanRequest.swift
//  EthViewer
//
//  Created by Elliott Minns on 15/01/2018.
//  Copyright © 2018 Elliott Minns. All rights reserved.
//

import Foundation

protocol EtherscanRequest: JSONResultParsing, JSONBuildableRequest, SendableRequest {
}

extension EtherscanRequest {
  var baseUrl: URL? {
    return URL(string: "https://api.etherscan.io")
  }
  
  var path: String {
    return "/api"
  }
  
  func buildParameters() -> [String : Any] {
    var params = parameters
    params["apikey"] = Configuration.main.etherscanApiKey
    return params
  }
  
  func parse(data: Data) -> ParsedType? {
    guard let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
      let result = json?["result"] else { return nil }
    
    return parse(json: result)
  }
}

enum EtherscanAction {
  case balance
  case tokenBalance(Token)
}

extension EtherscanAction {
  func add(to parameters: [String: Any]) -> [String: Any] {
    var params = parameters
    switch self {
    case .balance:
      params["action"] = "balance"
      
    case .tokenBalance(let token):
      params["action"] = "tokenbalance"
      params["contractaddress"] = token.contractAddress
    }
    
    return params
  }
}

protocol EtherscanBalanceRequest: EtherscanRequest {
  var action: EtherscanAction { get }
  
  var address: String { get }
}

extension EtherscanBalanceRequest {
  
  func buildParameters() -> [String : Any] {
    var params = parameters
    params["apikey"] = Configuration.main.etherscanApiKey
    params["tag"] = "latest"
    params["module"] = "account"
    params["address"] = address
    return action.add(to: params)
  }
  
  func parse(json data: Any) -> Double? {
    let lowerMag = 18
    guard let numberStr = data as? String else { return nil }
    
    if numberStr.count >= lowerMag {
      let index = numberStr.index(numberStr.endIndex, offsetBy: -lowerMag)
      let start = String(numberStr[..<index])
      let end = String(numberStr[index...])
      let upper = Double(start) ?? 0
      let lower = (Double(end) ?? 0) * 1e-18
      return upper + lower
    } else {
      let number = Int(numberStr) ?? 0
      return Double(number) * 1e-18
    }
  }
}
