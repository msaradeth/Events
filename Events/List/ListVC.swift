//
//  ListVC.swift
//  Events
//
//  Created by Mike Saradeth on 6/12/19.
//  Copyright © 2019 Mike Saradeth. All rights reserved.
//

import UIKit

class ListVC: UIViewController {
    var viewModel: ListViewModel
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        collectionView.register(UINib(nibName: "ListCell", bundle: nil), forCellWithReuseIdentifier: ListCell.cellIdentifier)
        return collectionView
    }()
    
    init(title: String, viewModel: ListViewModel) {
        self.viewModel = viewModel        
        super.init(nibName: nil, bundle: nil)
        self.title = title
        self.view.backgroundColor = .white
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        viewModel.loadData { [weak self] in
            self?.collectionView.reloadData()
        }
    }
    
    func setupCollectionView() {
        view.addSubview(collectionView)
        collectionView.fillsuperview()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension ListVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.items.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ListCell.cellIdentifier, for: indexPath) as! ListCell
        cell.configure(item: viewModel[indexPath], index: indexPath.row, delegate: viewModel)
        return cell
    }
}

extension ListVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}

