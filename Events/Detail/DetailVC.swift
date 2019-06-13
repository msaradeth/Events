//
//  DetailVC.swift
//  Events
//
//  Created by Mike Saradeth on 6/13/19.
//  Copyright © 2019 Mike Saradeth. All rights reserved.
//

import UIKit
import MessageUI

class DetailVC: UIViewController {
    var viewModel: DetailViewModel
    var stretchHeader: StretchHeader
    lazy var dateLabel: UILabel = {
        let dateLabel = UILabel()
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.font = UIFont.boldSystemFont(ofSize: 17)
        dateLabel.textColor = .gray
        return dateLabel
    }()
    lazy var titleLabel: UILabel = {
       let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        return titleLabel
    }()
    lazy var tableview: UITableView = {
        let tableview = UITableView(frame: .zero)
        tableview.translatesAutoresizingMaskIntoConstraints = false
        tableview.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableview.tableFooterView = UIView(frame: .zero)        
        tableview.rowHeight = UITableView.automaticDimension
        tableview.estimatedRowHeight = 200
        tableview.allowsSelection = false
        tableview.dataSource = self
        tableview.delegate = self
        return tableview
    }()
    var titleTopConstraint: NSLayoutConstraint!
    var titleLeadingConstraint: NSLayoutConstraint!
    var titleCenterXConstraint: NSLayoutConstraint!
    var titleViewConstraint: NSLayoutConstraint!
    
    
    init(viewModel: DetailViewModel, stretchHeader: StretchHeader) {
        self.viewModel = viewModel
        self.stretchHeader = stretchHeader
        super.init(nibName: nil, bundle: nil)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(share))

        //setup subview
        self.view.addSubview(self.stretchHeader)
        self.stretchHeader.anchorToSuperview()
        self.setupDateLabel()
        self.setupTitleLabel()
        self.setupTableView()
        self.view.backgroundColor = .white
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func setupDateLabel() {
        view.addSubview(dateLabel)
        dateLabel.topAnchor.constraint(equalTo: stretchHeader.bottomAnchor).isActive = true
        dateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        dateLabel.text = viewModel.item.date
    }
    
    func setupTitleLabel() {
        view.addSubview(titleLabel)
        titleLabel.text = viewModel.item.title
        titleTopConstraint = titleLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor)
        titleLeadingConstraint =  titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16)
        
        titleViewConstraint = titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: -40)
        titleCenterXConstraint =  titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        NSLayoutConstraint.activate([titleTopConstraint, titleLeadingConstraint])
    }

    func setupTableView() {
        view.addSubview(tableview)
        tableview.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 60).isActive = true
        tableview.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableview.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableview.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    @objc func share() {
        print("share button")
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension DetailVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "cell", for: indexPath) //as UITableViewCell
        cell.textLabel?.text = viewModel.item.description
        cell.textLabel?.textColor = .gray
        cell.textLabel?.numberOfLines = 0
        return cell
    }
 
    
}

extension DetailVC: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        stretchHeader.stretch(scrollview: scrollView, navigationItem: navigationItem)
        
        let curHeight = stretchHeader.heightConstraint.constant - scrollView.contentOffset.y
        stretchHeader.heightConstraint.constant = curHeight
        self.view.layoutIfNeeded()
        
        print("curHeight:", curHeight)
//        if curHeight < 200 {
//            let titleView = UILabel(frame: CGRect(origin: .zero, size: CGSize(width: 100, height: 40)))
//            titleView.text = viewModel.item.title
//            titleView.font = UIFont.systemFont(ofSize: 21, weight: .medium)
//            navigationItem.titleView = titleView
//            titleLabel.isHidden = true
//        }else {
//            navigationItem.titleView = nil
//            titleLabel.isHidden = false
//        }
        
        UIView.animate(withDuration: 0.6) {
            if curHeight < 100 {
                NSLayoutConstraint.deactivate([self.titleLeadingConstraint, self.titleTopConstraint])
                NSLayoutConstraint.activate([self.titleCenterXConstraint, self.titleViewConstraint])
            }else {
                NSLayoutConstraint.deactivate([self.titleCenterXConstraint,  self.titleViewConstraint])
                NSLayoutConstraint.activate([self.titleTopConstraint, self.titleLeadingConstraint])
            }
            self.view.layoutIfNeeded()
        }
    }
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        stretchHeader.setHeight(scrollView: scrollView)
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        stretchHeader.setHeight(scrollView: scrollView)
    }
}
