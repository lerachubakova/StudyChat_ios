//
//  SettingTVCell.swift
//  StudyApp
//
//  Created by user on 4/26/21.
//

import UIKit

class SettingTVCell: UITableViewCell {

    @IBOutlet weak private var settingIconImageView: UIImageView!
    @IBOutlet weak private var nameLabel: UILabel!
    @IBOutlet weak private var otherImageView: UIImageView!
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
    
    func configure(setting: (String, String)) {
        nameLabel.text = setting.0
        settingIconImageView.image = UIImage(named: setting.1)
        otherImageView.isHidden = (setting.0 == "Log Out") ? true : false
    }
    
}
