//
//  MessageTVCell.swift
//  StudyApp
//
//  Created by user on 4/29/21.
//

import UIKit

class MessageTVCell: UITableViewCell {

    @IBOutlet weak private var myBackgroundView: UIView!
    @IBOutlet weak private var messageTextView: UITextView!
    @IBOutlet weak private var timeLabel: UILabel!
    @IBOutlet weak private var wasEditingLabel: UILabel!
    
    @IBOutlet weak private var timeLabelTopConstraint: NSLayoutConstraint!
    @IBOutlet weak private var timeLabelTrailingConstraint: NSLayoutConstraint!

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
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        timeLabel.text = dateFormatter.string(from: message.time)
        wasEditingLabel.text = message.wasEdited ? "Ред." : ""
     
        messageTextView.text = message.text
        myBackgroundView.layer.cornerRadius = 12

        switch message.type {
        case .sender:
            myBackgroundView.backgroundColor = .darkGray
            
            myBackgroundView.transform = CGAffineTransform(scaleX: -1, y: 1)
            contentView.transform = CGAffineTransform(scaleX: -1, y: 1)
      
        case .receiver:
            myBackgroundView.backgroundColor = tabBarColor
            
            myBackgroundView.transform = CGAffineTransform(scaleX: 1, y: 1)
            contentView.transform = CGAffineTransform(scaleX: 1, y: 1)
        }
        timeLabelTopConstraint.constant = -10
        timeLabelTrailingConstraint.constant = 0
//        messageTextView.sizeToFit()
//
//        if messageTextView.frame.size.height > 35.5 {
//            timeLabelTopConstraint.constant = -10
//            timeLabelTrailingConstraint.constant = 0
//        } else {
//            timeLabelTopConstraint.constant = -26
//            timeLabelTrailingConstraint.constant = -40
//        }
    }
    
}
