//
//  BeerTableViewCell.swift
//  SeSac_Network
//
//  Created by youngjoo on 1/16/24.
//

import UIKit
import Kingfisher

class BeerTableViewCell: UITableViewCell {
    
    @IBOutlet var beerImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        designUI()
    }

    func configureCell(_ data: Beer) {
        nameLabel.text = data.name
        
        let url = URL(string: "\(data.image_url)")
        beerImageView.kf.setImage(with: url)

        descriptionLabel.text = data.description
    }
    
    func designUI() {
        beerImageView.contentMode = .scaleAspectFit
        
        nameLabel.font = .boldSystemFont(ofSize: 18)
        
        descriptionLabel.textColor = .lightGray
        descriptionLabel.numberOfLines = 0
    }
}


