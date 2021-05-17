//
//  CatFactsUITests.swift
//  CatFactsUITests
//
//  Created by Mario Alberto Barragán Espinosa on 14/05/21.
//

import XCTest

class CatFactsUITests: XCTestCase {
    func test_onLaunch_displaysCatFacts_whenHasConnectivity() {
      let app = XCUIApplication()
      app.launchArguments = ["-connectivity", "online"]  
        
      app.launch()

      XCTAssertEqual(app.cells.count, 3)
    }
    
    func test_onLaunch_displaysEmptyCatFacts_whenHasNoConnectivity() {
        let app = XCUIApplication()
        app.launchArguments = ["-connectivity", "offline"]
        
        app.launch()
        
        XCTAssertEqual(app.cells.count, 0)
    }
}
