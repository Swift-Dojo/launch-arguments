//
//  CatCell.swift
//  CatFacts
//
//  Created by Mario Alberto Barragán Espinosa on 14/05/21.
//

import UIKit

final class CatCell: UITableViewCell {
  func setFact(_ fact: String) {
    self.textLabel?.numberOfLines = 0
    self.textLabel?.text = fact
  }
}
