//
//  Configuration.swift
//  EthViewer
//
//  Created by Elliott Minns on 15/01/2018.
//  Copyright © 2018 Elliott Minns. All rights reserved.
//

import Foundation

enum Environment: String {
  case debug = "Debug"
  case release = "Release"
}

class Configuration {
  static let main: Configuration = {
    return Configuration()
  }()
  
  let environment: Environment
  
  let settings: [String: Any]
  
  var etherscanApiKey: String {
    return settings["etherscanApiKey"] as! String
  }

  init(bundle: Bundle = Bundle.main) {
    let config = bundle.infoDictionary?["Configuration"] as! String
    environment = Environment(rawValue: config)!
    
    let path = bundle.path(forResource: "Configurations", ofType: "plist")
    let settings = NSDictionary(contentsOfFile: path!) as! [String: Any]
    self.settings = settings[environment.rawValue] as! [String: Any]
  }
}
