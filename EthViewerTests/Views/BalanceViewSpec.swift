//
//  BalanceViewSpec.swift
//  EthViewerTests
//
//  Created by Elliott Minns on 14/01/2018.
//  Copyright © 2018 Elliott Minns. All rights reserved.
//

import Quick
import Nimble
@testable import EthViewer

class BalanceViewSpec: QuickSpec {
  override func spec() {
    describe("the balance view") {
      
      var view: BalanceView!
      
      beforeEach {
        view = BalanceView(title: "Some title", balance: "some balance")
      }
      
      it("should have the correct title in the title label") {
        expect(view.titleLabel.text) == "Some title"
      }
      
      it("should have the correct balance in the balance label") {
        expect(view.balanceLabel.text) == "some balance ETH"
      }
      
      it("should have a stack as the subview") {
        expect(view.subviews.first as? UIStackView).toNot(beNil())
      }
      
      describe("the stack view") {
        var stackView: UIStackView!
        
        beforeEach {
          stackView = view.subviews.first as! UIStackView
        }
        
        it("should have 2 arranged subviews of title and balance labels") {
          expect(stackView.arrangedSubviews) == [view.titleLabel, view.balanceLabel]
        }
        
        it("should have a vertical axis") {
          expect(stackView.axis) == UILayoutConstraintAxis.vertical
        }
        
        it("should have the correct alignment") {
          expect(stackView.alignment) == UIStackViewAlignment.center
        }
        
        it("should have the correct distribution") {
          expect(stackView.distribution) == UIStackViewDistribution.equalCentering
        }
        
        it("should not translate constraints") {
          expect(stackView.translatesAutoresizingMaskIntoConstraints) == false
        }
      }
      
      describe("Updating the balance") {
        it("should change when updated") {
          view.balance = "new"
          expect(view.balanceLabel.text) == "new ETH"
        }
      }
    }
  }
}
