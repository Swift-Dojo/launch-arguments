//
//  File.swift
//  CatFacts
//
//  Created by David Castro Cisneros on 07/05/21.
//

import Foundation


public protocol HTTPClient {
  typealias Result = Swift.Result<(Data, HTTPURLResponse), Error>

  /// The completion handler can be invoked in any thread.
  /// Clients are responsible to dispatch to appropriate threads, if needed.
  func get(from url: URL, completion: @escaping (Result) -> Void)
}
