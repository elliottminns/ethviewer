//
//  TokenSpec.swift
//  EthViewerTests
//
//  Created by Elliott Minns on 16/01/2018.
//  Copyright © 2018 Elliott Minns. All rights reserved.
//

import Quick
import Nimble
@testable import EthViewer

class TokenSpec: QuickSpec {
  override func spec() {
    let tests: [(token: Token, addr: String, name: String)] = [
      (token: .gnt, addr: "0xa74476443119A942dE498590Fe1f2454d7D4aC0d", name: "GOLEM"),
      (token: .omg, addr: "0xd26114cd6EE289AccF82350c8d8487fedB8A0C07", name: "OmiseGo"),
      (token: .rep, addr: "0xe94327d07fc17907b4db788e5adf2ed424addff6", name: "Augur"),
    ]
    
    tests.forEach { test in
      describe("the \(test.token.rawValue) token") {
        it("should have the correct contract address") {
          expect(test.token.contractAddress) == test.addr
        }
        
        it("should have the correct name") {
          expect(test.token.name) == test.name
        }
      }
    }
  }
}
