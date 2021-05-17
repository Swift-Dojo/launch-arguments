//
//  SceneDelegate.swift
//  CatFacts
//
//  Created by David Castro Cisneros on 07/05/21.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        
        let session = URLSession(configuration: .ephemeral)
        var client: HTTPClient = URLSessionHTTPClient(session: session)
        
        #if DEBUG
        let connectivity = UserDefaults.standard.string(forKey: "connectivity")!
        client = DebuggingHTTPClient(connectivity: connectivity)
        #endif
        
        let viewController = UINavigationController(rootViewController: CatViewController(client: client))
        
        self.window = UIWindow(windowScene: scene)
        self.window?.makeKeyAndVisible()
        self.window?.rootViewController = viewController
    }
}

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
