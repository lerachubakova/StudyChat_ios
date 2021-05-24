//
//  PhotoMessageTVCell.swift
//  StudyApp
//
//  Created by user on 5/24/21.
//

import AVFoundation
import UIKit

class PhotoMessageTVCell: UITableViewCell {

    @IBOutlet private weak var myBackgroundView: UIView!
    @IBOutlet private weak var myContentView: UIView!
    @IBOutlet private weak var timeLabel: UILabel!
    @IBOutlet private weak var photoImageView: UIImageView!
    
    static let identifier = "photoMessageCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "PhotoMessageTVCell", bundle: nil)
    }
    
    func configure(by message: Message) {
        myBackgroundView.layer.cornerRadius = 12
        photoImageView.layer.cornerRadius = 12
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        timeLabel.text = dateFormatter.string(from: message.time)
        
        switch message.type {
        case .sender:
            myBackgroundView.backgroundColor = .darkGray
            myBackgroundView.transform = CGAffineTransform(scaleX: -1, y: 1)
            myContentView.transform = CGAffineTransform(scaleX: -1, y: 1)
           contentView.transform = CGAffineTransform(scaleX: -1, y: 1)
      
        case .receiver:
            myBackgroundView.backgroundColor = tabBarColor
            myBackgroundView.transform = CGAffineTransform(scaleX: 1, y: 1)
            myContentView.transform = CGAffineTransform(scaleX: 1, y: 1)
            contentView.transform = CGAffineTransform(scaleX: 1, y: 1)
        }
//        if let movies = message.movies {
//            if !movies.isEmpty {
//                do {
//                let asset = AVURLAsset(url: movies[0], options: nil)
//                       let imgGenerator = AVAssetImageGenerator(asset: asset)
//                       imgGenerator.appliesPreferredTrackTransform = true
//                    let cgImage = try imgGenerator.copyCGImage(at: CMTimeMake(value: 0, timescale: 5), actualTime: nil)
//                    photoImageView.image = UIImage(cgImage: cgImage)
//                } catch {print(error.localizedDescription)}
//            }
//        }
//
        guard let images = message.images else { return }
        if !images.isEmpty {
            photoImageView.image = UIImage(data: images[0]) ?? UIImage()
        }
    }
}
