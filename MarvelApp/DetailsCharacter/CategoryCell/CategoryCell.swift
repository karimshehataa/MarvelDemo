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
    var disposeBag = DisposeBag()
    let viewModel = DetailsCharacterViewModel()
    @IBOutlet weak var collectionView: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCollection()
        // Initialization code
        
    }
    private func setupCollection() {
        collectionView.register(UINib(nibName: "CategoryCollectionCell", bundle: nil), forCellWithReuseIdentifier: "CategoryCollectionCell")
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
}

extension CategoryCell:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(categorList?.count)
        return categorList?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCollectionCell", for: indexPath) as! CategoryCollectionCell
        let imageUrl = categorList?[indexPath.item].resourceURI ?? ""
        let stringUrl = imageUrl + "/landscape_amazing.jpg"
        let url = URL(string: stringUrl)
        print(url)
        cell.categoryImage.af.setImage(withURL: url ?? URL(filePath: ""))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.size.width
        let height = collectionView.frame.size.height

        print(width,height)
        return CGSize(width: collectionView.frame.size.width/3, height: 300)
    }
}
