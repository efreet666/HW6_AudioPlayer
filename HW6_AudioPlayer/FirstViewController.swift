//
//  FirstViewController.swift
//  HW6_AudioPlayer
//
//  Created by Влад Бокин on 11.08.2021.
//

import UIKit
import AVFoundation

class FirstViewController: UIViewController {
    
    @IBOutlet weak var playPauseButtonOutlet: UIButton!
    @IBOutlet weak var currentPlayerValueLabel: UILabel!
    @IBOutlet weak var songImage: UIImageView!
    @IBOutlet weak var playerDurationLabel: UILabel!
    
    var timer: Timer?
    var activitiViewContorller: UIActivityViewController? = nil
    var player = AVAudioPlayer()
    let durationSlider = UISlider()
    let soundSlider = UISlider()
    
    var trackName: String?
    var trackNames: [String]?
    var indexCurrentTrack: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let tracks = trackNames else {return}
        indexCurrentTrack = tracks.firstIndex(of: trackName!)
//        configuratePlayer(trackName: trackName!)
//        updateUIByIndexTrack(indexTrack: indexCurrentTrack!)
        
        
        //MARK: - songImage
        songImage.layer.shadowRadius = 20
        songImage.layer.shadowOffset = .zero
        songImage.layer.shadowOpacity = 0.5
        songImage.layer.shadowColor = UIColor.black.cgColor
        songImage.layer.shadowPath = UIBezierPath(rect: songImage.bounds).cgPath
        songImage.layer.masksToBounds = false
        songImage.layer.shadowOffset = CGSize(width: 0, height: 10)
        songImage.layer.cornerRadius = 10
        
        //MARK: - VolumeSlider
        
        soundSlider.frame = CGRect(x: 40, y: self.view.frame.height - 200, width: self.view.frame.width - 80, height: 20)
        soundSlider.minimumTrackTintColor = #colorLiteral(red: 0.4988975525, green: 0.4993980527, blue: 0.5142464638, alpha: 1)
        self.view.addSubview(soundSlider)
        soundSlider.minimumValue = 0.0
        soundSlider.maximumValue = 100.0
        soundSlider.value = 70.0
        
        //MARK: - DurationSlider
        durationSlider.frame = CGRect(x: 40, y: self.view.frame.height - 330, width: self.view.frame.width - 80, height: 20)
        durationSlider.minimumTrackTintColor = #colorLiteral(red: 0.9949335456, green: 0.2728733718, blue: 0.4223648906, alpha: 1)
        self.view.addSubview(durationSlider)
        durationSlider.minimumValue = 0.0
        durationSlider.maximumValue = 100.0
        
        self.playPauseButtonOutlet.setImage(UIImage(named: "pause"), for: .normal)
        
        //MARK: - Slider addTarget
        self.durationSlider.addTarget(self, action: #selector(changeSlider), for: .valueChanged )
        self.soundSlider.addTarget(self, action: #selector(volumeSlider), for: .valueChanged)
        
        //MARK: - create audioPath
        do {
            if let audioPath = Bundle.main.path(forResource: "The_Weeknd_Blinding_Lights", ofType: "mp3"){
            try player = AVAudioPlayer(contentsOf: URL(fileURLWithPath: audioPath))
            self.durationSlider.maximumValue = Float(player.duration)
            self.soundSlider.maximumValue = Float(player.volume)
            }
        } catch {
            print("Error")
        }
        self.player.play()
        
        //MARK: - timer from extention
        createTimer()
    }
    
    
    
    @objc func changeSlider(sender: UISlider) {
        player.stop()
        player.currentTime = TimeInterval(durationSlider.value)
                if isPlaying {
                    player.prepareToPlay()
                    player.play()
                }
    }
    
    func configuratePlayerDurationLabel() {
            var minutes = Int(player.duration / 60)
            let seconds = player.duration - Double(minutes * 60)
            var secodsString = seconds < 9.5 ? "0\(String(format: "%.0f", seconds))" : "\(String(format: "%.0f", seconds))"
            if secodsString == "60" {
                secodsString = "00"
                minutes += 1
            }
            playerDurationLabel.text = "\(minutes):\(secodsString)"
        }
    
    
    @objc func volumeSlider(sender: UISlider) {
        if sender == soundSlider{
            self.player.volume = self.soundSlider.value
        }
    }
    var isPlaying = true
    
    //MARK: - Buttons
    @IBAction func playPauseButton(_ sender: Any) {
        if isPlaying == true{
            DispatchQueue.main.async {
                self.playPauseButtonOutlet.setImage(UIImage(named: "play"), for: .normal)
                self.player.stop()
            }
            isPlaying = false
            
        } else {
            DispatchQueue.main.async {
                self.playPauseButtonOutlet.setImage(UIImage(named: "pause"), for: .normal)
                self.player.play()
            }
            isPlaying = true
            }
    }
        
    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func shareButton(_ sender: Any) {
        self.activitiViewContorller = UIActivityViewController(activityItems: [self.trackName!], applicationActivities: nil)
        self.present(self.activitiViewContorller!, animated: true, completion: nil)
    }
    

}
extension FirstViewController {
    @objc func updateTimer() {
        durationSlider.value = Float(player.currentTime)
        var minutes = Int(player.currentTime / 60)
        let seconds = player.currentTime - Double(minutes * 60)
        var secodsString = seconds < 9.5 ? "0\(String(format: "%.0f", seconds))" : "\(String(format: "%.0f", seconds))"
        if secodsString == "60" {
            secodsString = "00"
            minutes += 1
        }
        currentPlayerValueLabel.text = "\(minutes):\(secodsString)"
    }
  
    func createTimer() {
        if timer == nil {
            timer = Timer.scheduledTimer(withTimeInterval: 1/5, repeats: true) { [weak self]_ in
                self?.updateTimer()
            }
        }
    }
}
