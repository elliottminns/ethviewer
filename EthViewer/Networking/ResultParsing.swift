//
//  ResultParsing.swift
//  EthViewer
//
//  Created by Elliott Minns on 15/01/2018.
//  Copyright © 2018 Elliott Minns. All rights reserved.
//

import Foundation

typealias JSON = [String: Any]

class JSONParser {
  
  static func parse(data: Data) -> [String: AnyObject]? {
    do {
      let serial = try JSONSerialization.jsonObject(with: data, options: [])
      return serial as? [String: AnyObject]
    } catch {
      print(error)
    }
    
    return nil
  }
}

protocol ResultParsing {
  
  associatedtype ParsedType
  
  func parse(data: Data) -> ParsedType?
  
  func parse(error data: Data) -> Error?
}

protocol JSONResultParsing: ResultParsing {
  func parse(json data: Any) -> ParsedType?
}

extension JSONResultParsing {
  
  func parse(error data: Data) -> Error? {
    return RequestError(message: "Something went wrong")
  }
  
  func parse(data: Data) -> ParsedType? {
    guard let json = try? JSONSerialization.jsonObject(with: data, options: []) else { return nil }
    return parse(json: json)
  }
}

protocol JSONConstructable {
  init?(json data: Any)
}

extension JSONConstructable {
  static func create(json data: [[String: Any]]) -> [Self] {
    return data.flatMap { item in
      Self.init(json: item)
    }
  }
}

extension JSONResultParsing where ParsedType: JSONConstructable {
  func parse(json data: Any) -> ParsedType? {
    guard let json = data as? [String: Any] else { return nil }
    return ParsedType(json: json)
  }
}

extension JSONResultParsing where ParsedType: Sequence, ParsedType.Element: JSONConstructable {
  func parse(json data: Any) -> ParsedType? {
    guard let array = data as? [JSON] else { return nil }
    return ParsedType.Element.create(json: array) as? ParsedType
  }
}
