//
//  ListVC.swift
//  Events
//
//  Created by Mike Saradeth on 6/12/19.
//  Copyright © 2019 Mike Saradeth. All rights reserved.
//

import UIKit

class ListVC: UICollectionViewController {
    var viewModel: ListViewModel
    var myTitle: String
 
    init(title: String, viewModel: ListViewModel) {
        self.viewModel = viewModel
        self.myTitle = title
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
        self.collectionView.backgroundColor = .white
        self.collectionView.register(UINib(nibName: "ListCell", bundle: nil), forCellWithReuseIdentifier: ListCell.cellIdentifier)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.loadData { [weak self] in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = myTitle
    }
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        collectionView.collectionViewLayout.invalidateLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK: UICollectionViewDatasource and UICollectionViewDelegate
extension ListVC {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ListCell.cellIdentifier, for: indexPath) as! ListCell
        cell.configure(item: viewModel[indexPath], index: indexPath.row, delegate: viewModel)
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let item = viewModel[indexPath]
        let image = item.image ?? UIImage(named: "placeholder_nomoon")
        let stretchHeader = StretchHeader(image: image, maxHeight: 300, minHeight: 0)
        let detailViewModel = DetailViewModel(item: item)
        let detailVC = DetailVC(viewModel: detailViewModel, stretchHeader: stretchHeader)
        self.title = ""
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
}


//MARK: UICollectionViewDelegateFlowLayout
extension ListVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let flowlayout = collectionViewLayout as? UICollectionViewFlowLayout else { return CGSize.zero }
        flowlayout.minimumInteritemSpacing = 0
        flowlayout.minimumLineSpacing = 0
        
        var numberOfColumns: CGFloat = UIDevice.current.userInterfaceIdiom == .phone ? 1 : 2
        if UIDevice.current.orientation == .landscapeLeft || UIDevice.current.orientation == .landscapeRight {
            numberOfColumns = UIDevice.current.userInterfaceIdiom == .phone ? 2 : 3
        }
        let availableWidth = collectionView.frame.width - flowlayout.sectionInset.left - flowlayout.sectionInset.right - (flowlayout.minimumInteritemSpacing*numberOfColumns)
         return CGSize(width: availableWidth/numberOfColumns, height: 250)
    }
}

