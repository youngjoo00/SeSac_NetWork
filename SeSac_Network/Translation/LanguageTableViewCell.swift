//
//  LanguageTableViewCell.swift
//  SeSac_Network
//
//  Created by youngjoo on 1/17/24.
//

import UIKit

class LanguageTableViewCell: UITableViewCell {

    @IBOutlet var languageLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
 
    func configureCell(data: String) {
        languageLabel.text = data
    }
}
