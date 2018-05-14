//
//  ViewController.swift
//  ImageTask
//
//  Created by Kapil Rathore on 13/05/18.
//  Copyright © 2018 Kapil Rathore. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var viewModel: ITViewModelType! {
        didSet {
            viewModel.viewDelegate = self
        }
    }
    
    @IBOutlet private weak var itCollectionView: UICollectionView! {
        didSet {
            itCollectionView.register(ITCollectionViewCell.nib, forCellWithReuseIdentifier: ITCollectionViewCell.identifier)
            itCollectionView.delegate = self
            itCollectionView.dataSource = self
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let model = ITModel()
        viewModel = ITViewModel()
        viewModel.model = model
        
        showLoadingView()
        setupFlowLayout()
    }
    
    @IBAction func changeFlowLayout(_ sender: UISegmentedControl) {
        // 0 - Vertical && 1 - Horizontal
        let scrollDir: UICollectionViewScrollDirection = UICollectionViewScrollDirection(rawValue: sender.selectedSegmentIndex)!
        
        if let layout = itCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = scrollDir
        }
        
        itCollectionView.isPagingEnabled = scrollDir == .horizontal
    }
    
    func setupFlowLayout() {
        let cellSize = UIScreen.main.bounds.width
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: cellSize, height: cellSize+100)
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        itCollectionView.setCollectionViewLayout(layout, animated: true)
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ITCollectionViewCell.identifier, for: indexPath) as? ITCollectionViewCell {
            cell.itObject = viewModel.itObjectForRow(at: indexPath)
            return cell
        }
        return UICollectionViewCell()
    }
}

extension ViewController: ITViewType {
    func apiResponse(sucess: Bool, error: String?) {
        if !sucess { showAlert(error!) }
        else {
            itCollectionView.reloadData()
        }
        hideLoadingView()
    }
}
