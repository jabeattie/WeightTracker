//
//  DashboardViewController.swift
//  Weight tracker
//
//  Created by James Beattie on 08/07/2018.
//  Copyright © 2018 James Beattie. All rights reserved.
//

import UIKit

class DashboardViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private let viewModel: DashboardViewModel
    
    init(viewModel: DashboardViewModel) {
        self.viewModel = viewModel
        super.init(nibName: String(describing: DashboardViewController.self), bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupCollectionLayout()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setupCollectionLayout()
        collectionView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func setupCollectionView() {
        collectionView.register(CurrentWeightCell.self)
        collectionView.register(BMICell.self)
        collectionView.register(DailyTargetCell.self)
        collectionView.register(ProgressCell.self)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func setupCollectionLayout() {
        let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout
        layout?.estimatedItemSize = CGSize(width: collectionView.bounds.size.width - 32, height: 100)
        layout?.sectionInset = UIEdgeInsets(top: 16, left: 0, bottom: 16, right: 0)
        layout?.minimumLineSpacing = 16
        layout?.minimumInteritemSpacing = 16
        print(collectionView.frame.size.width)
    }
    

}

extension DashboardViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.item {
        case 0:
            let cell: CurrentWeightCell = collectionView.dequeueReusableCell(for: indexPath)
            let cellVM = viewModel.currentWeightCellViewModel
            cell.update(cellVM)
            return cell
        case 1:
            let cell: BMICell = collectionView.dequeueReusableCell(for: indexPath)
            let cellVM = viewModel.bmiCellViewModel
            cell.update(cellVM)
            return cell
        case 2:
            let cell: DailyTargetCell = collectionView.dequeueReusableCell(for: indexPath)
            let cellVM = viewModel.dailyTargetCellViewModel
            cell.update(cellVM)
            return cell
        case 3:
            let cell: ProgressCell = collectionView.dequeueReusableCell(for: indexPath)
            let cellVM = viewModel.progressCellViewModel
            cell.update(cellVM)
            return cell
        default:
            fatalError()
        }
    }
}

extension DashboardViewController: UICollectionViewDelegate {
    
}
