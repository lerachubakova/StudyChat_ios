//
//  MessageTVCell.swift
//  StudyApp
//
//  Created by user on 4/29/21.
//

import UIKit

class MessageTVCell: UITableViewCell {

    static let identifier = "messageCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "MessageTVCell", bundle: nil)
    }
    
    func configure(by message: Message) {
        
    }
    
}
