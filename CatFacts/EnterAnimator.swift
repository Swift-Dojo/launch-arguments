//
//  EnterAnimator.swift
//  CatFacts
//
//  Created by Mario Alberto Barragán Espinosa on 14/05/21.
//

import UIKit

final class EnterAnimator {
  typealias Animation = (UITableViewCell, IndexPath, UITableView) -> Void

  var hasAnimatedFirstReload: Bool = false
  private let animation: Animation

  init(animation: @escaping Animation) {
    self.animation = animation
  }

  func animate(cell: UITableViewCell, at indexPath: IndexPath, in tableView: UITableView) {
    guard !hasAnimatedFirstReload else { return }

    animation(cell, indexPath, tableView)
  }

  static func makeSlideUp(duration: TimeInterval = 1.25, delay: Double = 0.05) -> Animation {
    return { cell, indexPath, tableView in
      cell.transform = CGAffineTransform(translationX: 0, y: tableView.bounds.height)
      cell.alpha = 0.25
      UIView.animate(withDuration: duration,
                     delay: (delay * Double(indexPath.row)),
                     usingSpringWithDamping: 0.75,
                     initialSpringVelocity: 0.1,
                     options: [.curveEaseInOut],
                     animations: {
                      cell.transform = CGAffineTransform(translationX: 0, y: 0)
                      cell.alpha = 1
                     })
    }
  }
}
