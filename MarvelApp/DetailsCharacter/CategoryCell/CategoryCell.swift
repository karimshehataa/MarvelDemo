//
//  CategoryCell.swift
//  MarvelApp
//
//  Created by karim  on 27/12/2023.
//

import UIKit
import RxSwift

class CategoryCell: UITableViewCell {
    var categorList:[CategoryItem]?
    var comics:[ComicsEnum.Result]?
    var disposeBag : DisposeBag?
     var viewModel:DetailsCharacterViewModel!
    @IBOutlet weak var collectionView: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCollection()
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.subscribeToResponse()
//        }
        // Initialization code
    }
    override func prepareForReuse() {
            super.prepareForReuse()
            disposeBag = DisposeBag()
        }
    private func setupCollection() {
        collectionView.register(UINib(nibName: "CategoryCollectionCell", bundle: nil), forCellWithReuseIdentifier: "CategoryCollectionCell")
//        collectionView.dataSource = self
//        collectionView.delegate = self
    }
    func subscribeToResponse() {
        viewModel?.comicsObservable.bind(to: collectionView.rx.items(cellIdentifier: "CategoryCollectionCell", cellType: CategoryCollectionCell.self)) {index,comic,cell in
            print(comic.thumbnail)
        }.disposed(by: disposeBag!)
    }
}

extension CategoryCell:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return comics?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCollectionCell", for: indexPath) as! CategoryCollectionCell
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.size.width
        let height = collectionView.frame.size.height

        print(width,height)
        return CGSize(width: collectionView.frame.size.width/3, height: 300)
    }
}
