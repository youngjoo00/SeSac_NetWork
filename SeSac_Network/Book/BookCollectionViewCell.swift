//
//  BookCollectionViewCell.swift
//  SeSac_Network
//
//  Created by youngjoo on 1/17/24.
//

import UIKit
import Kingfisher

class BookCollectionViewCell: UICollectionViewCell {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var priceLabel: UILabel!
    @IBOutlet var bookImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        designCell()
    }
    
    func configureCell(data: Document) {
        titleLabel.text = data.title
        priceLabel.text = "\(data.price)원"
        
        let url = URL(string: "\(data.thumbnail)")
        bookImageView.kf.setImage(with: url)
    }
    
    func designCell() {
        backgroundColor = .systemGray5
        layer.cornerRadius = 16
        
        titleLabel.font = .boldSystemFont(ofSize: 20)
        titleLabel.textColor = .black
        
        priceLabel.font = .boldSystemFont(ofSize: 15)
        priceLabel.textColor = .black
    }
}
