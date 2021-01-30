//
//  ViewController.swift
//  TableViewExample
//
//  Created by Ozan Gülhan on 13.01.2021.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet private weak var scrollView: UIScrollView!
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        scrollView.delegate = self
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isScrollEnabled = false
        tableView.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: "CustomCell")
        scrollView.addSubview(tableView)
        tableView.frame = CGRect(x: 0, y: 0, width: scrollView.frame.width, height: scrollView.frame.height)
        updateContentHeight()
    }

    private func updateContentHeight() {
        CATransaction.begin()
        tableView.reloadData()
        CATransaction.setCompletionBlock { [weak self] in
            guard let self = self else { return }
            let updatedContentHeight = self.tableView.contentSize.height
            self.scrollView.contentSize = CGSize(width: self.scrollView.frame.width, height: updatedContentHeight)
            self.tableView.frame = CGRect(x: 0, y: 0, width: self.scrollView.frame.width, height: updatedContentHeight)
        }
        CATransaction.commit()
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as? CustomTableViewCell {
            return cell
        }
        return UITableViewCell()
    }
    
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension ViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if self.scrollView == scrollView {
            let offset = scrollView.contentOffset.y
            let scrollViewHeight = scrollView.frame.height
            let shownRect = CGRect(x: 0, y: offset, width: scrollView.frame.width, height: scrollViewHeight)
            let currentlyShownIndexes = tableView.indexPathsForRows(in: shownRect) ?? []
            print(currentlyShownIndexes)
        }
    }
}
