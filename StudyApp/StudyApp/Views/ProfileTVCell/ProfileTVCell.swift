//
//  ProfileTVCell.swift
//  StudyApp
//
//  Created by user on 4/26/21.
//

import UIKit

class ProfileTVCell: UITableViewCell {

    @IBOutlet weak private var myBackgroundView: UIView!
    @IBOutlet weak private var photoImageView: UIImageView!
    @IBOutlet weak private var nameLabel: UILabel!
    
    static let identifier = "ProfileCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "ProfileTVCell", bundle: nil)
    }
    
    func configure(by user: User) {
        myBackgroundView.backgroundColor = UIColor.black.withAlphaComponent(0.0)
        photoImageView.layer.cornerRadius = photoImageView.frame.height / 2
        photoImageView.image = user.getPicture()
        nameLabel.text = user.getFullName()
    }
    
}
