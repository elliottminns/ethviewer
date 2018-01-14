//
//  MainScreenViewControllerSpec.swift
//  EthViewerTests
//
//  Created by Elliott Minns on 14/01/2018.
//  Copyright © 2018 Elliott Minns. All rights reserved.
//

import Quick
import Nimble
@testable import EthViewer

class MainScreenViewControllerSpec: QuickSpec {
  override func spec() {
    describe("the main screen view controller") {
      var controller: MainScreenViewController!
      
      beforeEach {
        controller = MainScreenViewController()
      }
      
      it("should have the correct title") {
        expect(controller.title) == "Balances"
      }
      
      it("should have the stack as it's subview") {
        expect(controller.stack.superview) == controller.view
      }
      
      it("should have only 1 subview") {
        expect(controller.view.subviews.count) == 1
      }
      
      describe("the stack view") {
        
        it("should have 3 arranged subviews in order") {
          expect(controller.stack.arrangedSubviews) == [
            controller.accountBalanceView,
            controller.tokenBalanceView,
            controller.viewMoreButton
          ]
        }
        
        it("should have a vertical axis") {
          expect(controller.stack.axis) == UILayoutConstraintAxis.vertical
        }
        
        it("should have the correct alignment") {
          expect(controller.stack.alignment) == UIStackViewAlignment.center
        }
        
        it("should have the correct distribution") {
          expect(controller.stack.distribution) == UIStackViewDistribution.fillEqually
        }
        
        it("should not translate constraints") {
          expect(controller.stack.translatesAutoresizingMaskIntoConstraints) == false
        }
      }
      
      describe("the account balance view") {
        it("should have the title of Account Balance") {
          expect(controller.accountBalanceView.title) == "Account Balance"
        }
      }
      
      describe("the token balance view") {
        it("should have the title of ERC-20 Balance") {
          expect(controller.tokenBalanceView.title) == "ERC-20 Balance"
        }
      }
      
      describe("the view more button") {
        it("should have the title of 'view more'") {
          expect(controller.viewMoreButton.title(for: .normal)) == "view more"
        }
      }
    }
  }
}
