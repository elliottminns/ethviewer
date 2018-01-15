//
//  ShapeShiftRequest.swift
//  EthViewer
//
//  Created by Elliott Minns on 15/01/2018.
//  Copyright © 2018 Elliott Minns. All rights reserved.
//

import Foundation

protocol ShapeShiftRequest: JSONBuildableRequest, JSONResultParsing, SendableRequest {
  
}

extension ShapeShiftRequest {
  var baseUrl: URL? {
    return URL(string: "https://shapeshift.io")
  }
}
