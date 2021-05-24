//
//  DebuggingSceneDelegate.swift
//  CatFacts
//
//  Created by Mario Alberto Barragán Espinosa on 22/05/21.
//
#if DEBUG
import UIKit

class DebuggingSceneDelegate: SceneDelegate {
    
    override func makeClient() -> HTTPClient {
        let connectivity = UserDefaults.standard.string(forKey: "connectivity")!
        return DebuggingHTTPClient(connectivity: connectivity)
    }
}
#endif
