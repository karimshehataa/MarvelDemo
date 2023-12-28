//
//  HeaderImageCell.swift
//  MarvelApp
//
//  Created by karim  on 27/12/2023.
//

import UIKit

class HeaderImageCell: UITableViewCell {

    @IBOutlet weak var characterImage: UIImageView!
    @IBOutlet weak var characterTitle: UILabel!
    @IBOutlet weak var charcterDescription: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
