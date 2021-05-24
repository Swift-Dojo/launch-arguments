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
        
        let client = makeClient()
        let viewController = UINavigationController(rootViewController: 
                                                        CatViewController(client: client))
        
        self.window = UIWindow(windowScene: scene)
        self.window?.makeKeyAndVisible()
        self.window?.rootViewController = viewController
    }
    
    func makeClient() -> HTTPClient {
        let session = URLSession(configuration: .ephemeral)
        let client: HTTPClient = URLSessionHTTPClient(session: session)
        
        return client
    }
}
