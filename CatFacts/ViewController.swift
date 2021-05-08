//
//  ViewController.swift
//  CatFacts
//
//  Created by David Castro Cisneros on 07/05/21.
//

import UIKit

final class CatViewController: UIViewController {
  /// Table View Controller
  lazy var tableViewAnimator = EnterAnimator(animation: EnterAnimator.makeSlideUp())
  lazy var tableView = UITableView()
  var catFacts = CatFacts()
  let client: HTTPClient

  init(client: HTTPClient) {
    self.client = client
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .red

    title = "Cat Facts"
    navigationController?.navigationBar.prefersLargeTitles = true

    setTableView()
    loadFacts()
  }

  private func loadFacts() {
    client.get(from: URL(string: "https://cat-fact.herokuapp.com/facts")!) { [weak self] result in
      switch result {
      case let .success(data, response):
        guard let catFacts = try? JSONDecoder().decode(CatFacts.self, from: data) else { return }
        self?.setFacts(facts: catFacts)
      case .failure(_):
        print("")
      }
    }
  }

  private func setFacts(facts: CatFacts) {
    DispatchQueue.main.async { [weak self] in
      self?.catFacts = facts
      self?.tableView.reloadData()
    }
  }

  private func setTableView() {
    tableView.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(tableView)
    tableView.delegate = self
    tableView.dataSource = self
    tableView.register(CatCell.self, forCellReuseIdentifier: String(describing: CatCell.self))

    NSLayoutConstraint.activate([
      tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      tableView.topAnchor.constraint(equalTo: view.topAnchor),
    ])
  }
}

extension CatViewController: UITableViewDelegate {
  /// Delegate
  public func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    guard !tableViewAnimator.hasAnimatedFirstReload else {
      return
    }
    tableViewAnimator.animate(cell: cell, at: indexPath, in: tableView)
    if let lastVisibleIndexPath = tableView.indexPathsForVisibleRows?.last,
       indexPath == lastVisibleIndexPath {
      tableViewAnimator.hasAnimatedFirstReload = true
    }
  }
}

extension CatViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return catFacts.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CatCell.self)) as? CatCell else { return UITableViewCell() }

    cell.setFact(catFacts[indexPath.row].text)

    return cell
  }
}

final class CatCell: UITableViewCell {
  func setFact(_ fact: String) {
    self.textLabel?.numberOfLines = 0
    self.textLabel?.text = fact
  }
}

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

// MARK: - CatFactElement
struct CatFactElement: Codable {
  let status: Status
  let type: String
  let deleted: Bool
  let id, user, text: String
  let v: Int
  let source, updatedAt, createdAt: String
  let used: Bool

  enum CodingKeys: String, CodingKey {
    case status, type, deleted
    case id = "_id"
    case user, text
    case v = "__v"
    case source, updatedAt, createdAt, used
  }
}

// MARK: - Status
struct Status: Codable {
  let verified: Bool
  let sentCount: Int
  let feedback: String?
}

typealias CatFacts = [CatFactElement]
