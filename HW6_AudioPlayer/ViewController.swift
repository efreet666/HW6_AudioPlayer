//
//  ViewController.swift
//  HW6_AudioPlayer
//
//  Created by Влад Бокин on 11.08.2021.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    let trackNames: [String] = ["The Weekend - Bliding light", "Michael Kiwanuka - Cold little heart", "Queen - Another One Bites The Dust", "Noize MC - На Марсе классно"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addTrackViews()
        }
    
    
    func addTrackViews() {
            for trackNum in 0..<trackNames.count {
                let trackView = TrackView(frame: CGRect(x: 0, y: trackNum * 100 + 100, width: 450, height: 100))
                trackView.setup(image: UIImage(named: "\(trackNum + 1)")!, trackName: trackNames[trackNum])
                trackView.setUnderLine(color: .lightGray)
                let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(showTrackVC(gestureRecognizer:)))
                trackView.addGestureRecognizer(gestureRecognizer)
                var player1 = AVAudioPlayer()
                func configuratePlayer(trackName: String) {
                    do {
                        if let audioPath = Bundle.main.path(forResource: trackName, ofType: "mp3"){
                        try player1 = AVAudioPlayer(contentsOf: URL(fileURLWithPath: audioPath))
                        }
                    } catch {
                        print("Error")
                    }
                }
                func configuratePlayerDurationLabel() {
                        var minutes = Int(player1.duration / 60)
                        let seconds = player1.duration - Double(minutes * 60)
                        var secodsString = seconds < 9.5 ? "0\(String(format: "%.0f", seconds))" : "\(String(format: "%.0f", seconds))"
                        if secodsString == "60" {
                            secodsString = "00"
                            minutes += 1
                        }
                    trackView.trackTimeLabel.text = "\(minutes):\(secodsString)"
                    }
                configuratePlayer(trackName: trackNames[trackNum])
               configuratePlayerDurationLabel()
                
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
extension UIView {
    func setUnderLine(color: UIColor = .darkGray) {
        let border = UIView()
        self.addSubview(border)
        
        border.backgroundColor = color
        border.translatesAutoresizingMaskIntoConstraints = false
        border.topAnchor.constraint(equalTo: self.bottomAnchor, constant: 5).isActive = true
        border.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        border.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        border.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
    }
}

