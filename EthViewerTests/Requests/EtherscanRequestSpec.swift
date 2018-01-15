//
//  EtherscanRequestSpec.swift
//  EthViewerTests
//
//  Created by Elliott Minns on 15/01/2018.
//  Copyright © 2018 Elliott Minns. All rights reserved.
//

import Quick
import Nimble
@testable import EthViewer

fileprivate class MockEtherscanRequest: EtherscanBalanceRequest {  
  typealias ParsedType = Double
  
  var action: EtherscanAction = .balance
  
  var address: String = ""
}

class EtherscanRequestSpec: QuickSpec {
  override func spec() {
    
    describe("parsing eth balances") {
     
      let req = MockEtherscanRequest()
      
      context("parsing an 18 long balance") {
        let balance = "123456789012345678"
        
        it("should give the correct value") {
          let result = req.parse(json: balance)
          expect(result).to(beCloseTo(0.123456789012345678))
        }
      }
      
      context("parsing a 10 long balance") {
        let balance = "1234567891"
        
        it("should give the correct value") {
          let result = req.parse(json: balance)
          expect(result).to(beCloseTo(0.000000001234567891))
        }
      }
      
      context("parsing a 19 long balance") {
        let balance = "9123456789012345678"
        it("should give the correct value") {
          let result = req.parse(json: balance)
          expect(result).to(beCloseTo(9.123456789012345678))
        }
      }
    }
  }
}
