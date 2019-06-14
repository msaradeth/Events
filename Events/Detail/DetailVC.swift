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
    lazy var menuView: MenuView = {
        let menuView = MenuView(frame: .zero)
        menuView.translatesAutoresizingMaskIntoConstraints = false
        menuView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        return menuView
    }()
    var titleTopConstraint: NSLayoutConstraint!
    var titleLeadingConstraint: NSLayoutConstraint!
    var titleCenterXConstraint: NSLayoutConstraint!
    var titleViewConstraint: NSLayoutConstraint!
    var viewModel: DetailViewModel
    var stretchHeader: StretchHeader
    
    
    init(viewModel: DetailViewModel, stretchHeader: StretchHeader) {
        self.viewModel = viewModel
        self.stretchHeader = stretchHeader
        super.init(nibName: nil, bundle: nil)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareButtonAction))

        //setup subviews
        self.view.addSubview(self.stretchHeader)
        self.stretchHeader.anchorToSuperview()
        self.setupDateLabel()
        self.setupTitleLabel()
        self.setupTableView()
        self.view.backgroundColor = .white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.alpha = 0.3
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.alpha = 1
    }
    

    
    func setupDateLabel() {
        view.addSubview(dateLabel)
        dateLabel.topAnchor.constraint(equalTo: stretchHeader.bottomAnchor).isActive = true
        dateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        dateLabel.text = viewModel.item.date?.toLocalTime()
    }
    
    func setupTitleLabel() {
        view.addSubview(titleLabel)
        titleLabel.text = viewModel.item.title
        titleTopConstraint = titleLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor)
        titleLeadingConstraint =  titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16)
        
        titleViewConstraint = titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 50)
        titleCenterXConstraint =  titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        NSLayoutConstraint.activate([titleTopConstraint, titleLeadingConstraint])
    }

    func setupTableView() {
        view.addSubview(tableview)
        tableview.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 30).isActive = true
        tableview.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableview.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableview.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    @objc func backButtonAction() {
        self.navigationController?.popViewController(animated: true)
    }
    @objc func shareButtonAction() {
        let activityViewController = UIActivityViewController(activityItems: [viewModel.item.description], applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        self.present(activityViewController, animated: true, completion: nil)
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
        let curHeight = stretchHeader.heightConstraint.constant - scrollView.contentOffset.y
        stretchHeader.stretch(height: curHeight)
        self.view.layoutIfNeeded()
        
        //Animate Title
        if curHeight < 100 {
            NSLayoutConstraint.deactivate([self.titleLeadingConstraint, self.titleTopConstraint])
            NSLayoutConstraint.activate([self.titleCenterXConstraint, self.titleViewConstraint])
            self.navigationController?.navigationBar.alpha = 0
        }else {
            NSLayoutConstraint.deactivate([self.titleCenterXConstraint,  self.titleViewConstraint])
            NSLayoutConstraint.activate([self.titleTopConstraint, self.titleLeadingConstraint])
            self.navigationController?.navigationBar.alpha = 0.5
        }
        UIView.animate(withDuration: 0.9) {
            self.view.layoutIfNeeded()
        }
    }
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        stretchHeader.setDefaulHeight(scrollView: scrollView)
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        stretchHeader.setDefaulHeight(scrollView: scrollView)
    }
}
