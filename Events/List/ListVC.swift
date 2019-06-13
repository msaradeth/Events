//
//  ListVC.swift
//  Events
//
//  Created by Mike Saradeth on 6/12/19.
//  Copyright © 2019 Mike Saradeth. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ListVC: UIViewController {
    let disposeBag = DisposeBag()
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
        viewModel.loadData()
    }
    
    func setupCollectionView() {
        view.addSubview(collectionView)
        collectionView.fillsuperview()

        viewModel.subject.bind(to: collectionView.rx.items(cellIdentifier: ListCell.cellIdentifier, cellType: ListCell.self)) { (row, item, cell) in
            cell.configure(item: item)
        }
        .disposed(by: disposeBag)
        
        
        collectionView.rx.modelSelected(EventModel.self)
            .subscribe(onNext: { [weak self] (item) in
                guard let self = self, let indexPath = self.collectionView.indexPathsForSelectedItems?.first else { return }
                self.collectionView.deselectItem(at: indexPath, animated: true)
                
                
            })
            .disposed(by: disposeBag)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

