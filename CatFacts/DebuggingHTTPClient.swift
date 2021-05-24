//
//  DebuggingHTTPClient.swift
//  CatFacts
//
//  Created by Mario Alberto Barragán Espinosa on 22/05/21.
//
#if DEBUG
import Foundation

class DebuggingHTTPClient: HTTPClient {
    
    private let connectivity: String
    
    init(connectivity: String) {
        self.connectivity = connectivity
    }
    
    func get(from url: URL, completion: @escaping (HTTPClient.Result) -> Void) {
        switch connectivity {
        case "online":
            completion(.success(makeSuccessfulResponse(for: url)))
            
        default:
            completion(.failure(NSError(domain: "No connectivity", code: 0)))
        }
        
    }
    
    private func makeData(for url: URL) -> Data {
        switch url.absoluteString {
        case "https://cat-fact.herokuapp.com/facts":
            return try! JSONEncoder().encode(makeCatData())
        default:
            break
        }
        
        return Data()
    }
    
    func makeCatData() -> [CatFactElement] {
        return [CatFactElement(text: "fact1"),
                CatFactElement(text: "fact2"),
                CatFactElement(text: "fact5")]
    }
    
    func makeSuccessfulResponse(for url: URL) -> (Data, HTTPURLResponse){
        let response = HTTPURLResponse(url: url,
                                       statusCode: 200,
                                       httpVersion: nil,
                                       headerFields: nil)!
        
        return (makeData(for: url), response)
    }
}
#endif
