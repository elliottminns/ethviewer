//
//  Service.swift
//  EthViewer
//
//  Created by Elliott Minns on 15/01/2018.
//  Copyright © 2018 Elliott Minns. All rights reserved.
//

import Foundation

protocol Service {
  associatedtype ResultType
}

protocol Gettable: Service {
  func get(callback: @escaping (Result<ResultType>) -> Void)
}
