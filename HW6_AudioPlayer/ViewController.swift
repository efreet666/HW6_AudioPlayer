//
//  ViewController.swift
//  HW6_AudioPlayer
//
//  Created by Влад Бокин on 11.08.2021.
//

import UIKit

class ViewController: UIViewController {
    let trackNames: [String] = ["Weekend - Bliding light", "Michael Kiwanuka - Cold little heart", "Queen - Another One Bites The Dust", "Noize MC - На Марсе классно"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(appNameLabel)
        addTrackViews()
        }
    
    let appNameLabel: UILabel = {
         let label = UILabel()
         label.text = "Playlist"
         label.font = UIFont.systemFont(ofSize: 30, weight: .medium)
         label.translatesAutoresizingMaskIntoConstraints = false
         return label
     }()
    
    func addTrackViews() {
            for trackNum in 0..<trackNames.count {
                let trackView = TrackView(frame: CGRect(x: 0, y: trackNum * 100 + 100, width: 390, height: 100))
                trackView.setup(image: UIImage(named: "\(trackNum + 1)")!, trackName: trackNames[trackNum])
//                trackView.setUnderLine(color: .lightGray)
                let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(showTrackVC(gestureRecognizer:)))
                trackView.addGestureRecognizer(gestureRecognizer)
                view.addSubview(trackView)
            }
        }
           
    @objc func showTrackVC(gestureRecognizer: UITapGestureRecognizer) {
           let storyboard = UIStoryboard(name: "Main", bundle: nil)
           guard let trackVC = storyboard.instantiateViewController(identifier: "FirstViewController") as? FirstViewController else { return }
           guard let trackView = gestureRecognizer.view as? TrackView else { return }
           trackVC.trackName = trackView.trackNameLabel.text
           trackVC.trackNames = trackNames
           show(trackVC, sender: nil)
       }

 
    

}

