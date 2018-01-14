//
//  AppDelegateSpec.swift
//  EthViewerTests
//
//  Created by Elliott Minns on 14/01/2018.
//  Copyright © 2018 Elliott Minns. All rights reserved.
//

import Quick
import Nimble
@testable import EthViewer

class AppDelegateSpec: QuickSpec {
  override func spec() {
    describe("The app delegate") {
      let application = UIApplication.shared
      var delegate: AppDelegate = AppDelegate()
      
      beforeEach {
        delegate = AppDelegate()
      }
      
      context("Calling applicationDid") {
        var result: Bool?
        
        beforeEach {
          result = delegate.application(application, didFinishLaunchingWithOptions: nil)
        }
        
        it("should set the window") {
          expect(delegate.window).toNot(beNil())
        }
        
        it("should return true") {
          expect(result) == true
        }
        
        it("should set the root view controller to a navigation controller") {
          expect(delegate.window?.rootViewController as? UINavigationController).toNot(beNil())
        }
        
        describe("the navigation controller") {
          var navigationController: UINavigationController?
          beforeEach {
            navigationController = delegate.window?.rootViewController as? UINavigationController
          }
          
          it("should have a root view controller of mainViewController") {
            expect(navigationController?.viewControllers.first as? MainScreenViewController).toNot(beNil())
          }
          
          it("should only have one view controller") {
            expect(navigationController?.viewControllers.count) == 1
          }
        }
      }
    }
  }
}
