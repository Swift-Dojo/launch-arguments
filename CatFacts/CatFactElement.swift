//
//  CatFactElement.swift
//  CatFacts
//
//  Created by Mario Alberto Barragán Espinosa on 14/05/21.
//

import Foundation

struct CatFactElement: Codable {
  let text: String
}

typealias CatFacts = [CatFactElement]
