//
//  SettingTVCell.swift
//  StudyApp
//
//  Created by user on 4/26/21.
//

import UIKit

class SettingTVCell: UITableViewCell {

    static let identifier = "SettingCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "SettingTVCell", bundle: nil)
    }
    
}
