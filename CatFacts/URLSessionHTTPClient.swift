//
//  URLSessionHTTPClient.swift
//  CatFacts
//
//  Created by Mario Alberto Barragán Espinosa on 14/05/21.
//

import Foundation

public final class URLSessionHTTPClient: HTTPClient {
  private let session: URLSession

  public init(session: URLSession) {
    self.session = session
  }

  private struct UnexpectedValuesRepresentation: Error {}


  public func get(from url: URL, completion: @escaping (HTTPClient.Result) -> Void) {
    let task = session.dataTask(with: url) { data, response, error in
      completion(Result {
        if let error = error {
          throw error
        } else if let data = data, let response = response as? HTTPURLResponse {
          return (data, response)
        } else {
          throw UnexpectedValuesRepresentation()
        }
      })
    }
    task.resume()
  }
}
