//
//  CharactersCell.swift
//  MarvelApp
//
//  Created by karim  on 25/12/2023.
//

import UIKit

class CharactersCell: UICollectionViewCell {

    
    @IBOutlet weak var characterName: UILabel!
    
    @IBOutlet weak var characterImage: UIImageView!
    
    @IBOutlet weak var bottomView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        bottomView.backgroundColor = .black.withAlphaComponent(0.3)
    }

}
