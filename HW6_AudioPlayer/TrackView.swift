//
//  TrackVC.swift
//  HW6_AudioPlayer
//
//  Created by Влад Бокин on 18.08.2021.
//

import UIKit

class TrackView: UIView {

    let albumImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 5
        imageView.frame = CGRect(x: 10, y: 15, width: 80, height: 80)
        return imageView
    }()
    
    let trackNameLabel: UILabel = {
            let label = UILabel()
            label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
            label.numberOfLines = 0
            return label
        }()
        
        
        let trackTimeLabel: UILabel = {
            let label = UILabel()
            label.text = "4:20"
            return label
        }()
    
    override init(frame: CGRect) {
          super.init(frame: frame)
      }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(image: UIImage, trackName: String) {
            albumImageView.image = image
            trackNameLabel.text = trackName
            trackNameLabel.frame = CGRect(x: albumImageView.frame.maxX + 5, y: albumImageView.frame.midY - 30, width: 230, height: 60)
            trackTimeLabel.frame = CGRect(x: 340, y: Int(trackNameLabel.frame.midY - 10), width: 40, height: 20)
            
            addSubview(albumImageView)
            addSubview(trackNameLabel)
            addSubview(trackTimeLabel)
        }
}
