//
//  FirstViewController.swift
//  HW6_AudioPlayer
//
//  Created by Влад Бокин on 11.08.2021.
//

import UIKit
import AVFoundation

class FirstViewController: UIViewController {
    
    @IBOutlet weak var trackLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
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
        configuratePlayer(trackName: trackName!)
        updateUIByIndexTrack(indexTrack: indexCurrentTrack!)
        createTimer()
        configuratePlayerDurationLabel()

        
        //MARK: - songImage
        
        songImage.layer.shadowRadius = 30
        songImage.layer.shadowOffset = .zero
        songImage.layer.shadowOpacity = 0.5
        songImage.layer.shadowColor = UIColor.black.cgColor
        songImage.layer.shadowPath = UIBezierPath(rect: songImage.bounds).cgPath
        songImage.layer.masksToBounds = false
        songImage.layer.shadowOffset = CGSize(width: 0, height: 10)
        songImage.layer.cornerRadius = 50
        
        
        //MARK: - VolumeSlider
        
        soundSlider.frame = CGRect(x: 40, y: self.view.frame.height - 200, width: self.view.frame.width - 80, height: 20)
        soundSlider.minimumTrackTintColor = #colorLiteral(red: 0.4988975525, green: 0.4993980527, blue: 0.5142464638, alpha: 1)
        soundSlider.minimumValue = 0.0
        soundSlider.maximumValue = 50.0
        soundSlider.value = 40.0
        self.view.addSubview(soundSlider)
        
        //MARK: - DurationSlider
        
        durationSlider.frame = CGRect(x: 40, y: self.view.frame.height - 330, width: self.view.frame.width - 80, height: 20)
        durationSlider.minimumTrackTintColor = #colorLiteral(red: 0.9949335456, green: 0.2728733718, blue: 0.4223648906, alpha: 1)
        self.view.addSubview(durationSlider)
        durationSlider.minimumValue = 0.0
        durationSlider.maximumValue = 200.0
        
        self.playPauseButtonOutlet.setImage(UIImage(named: "pause"), for: .normal)
        
        //MARK: - Slider addTarget
        
        self.durationSlider.addTarget(self, action: #selector(changeSlider), for: .valueChanged )
        self.soundSlider.addTarget(self, action: #selector(volumeSlider), for: .valueChanged)
    }
    
    
    func updateUIByIndexTrack(indexTrack: Int) {
            guard let tracks = trackNames else { return }
            trackLabel.text = tracks[indexTrack].split(separator: "-").map(String.init).last
            artistLabel.text = tracks[indexTrack].split(separator: "-").map(String.init).first
            songImage.image = UIImage(named: "\(indexTrack + 1)")
            durationSlider.maximumValue = Float(player.duration)
            configuratePlayerDurationLabel()
        }
    
    func switchingTracks(next: Bool) {
        guard let tracks = trackNames else { return }
        guard let indexOfCurrentTrack = indexCurrentTrack else { return }
        if next {
            indexCurrentTrack = indexOfCurrentTrack == tracks.count - 1 ? 0 : indexOfCurrentTrack + 1
        } else {
            indexCurrentTrack = indexOfCurrentTrack == 0 ? tracks.count - 1 : indexOfCurrentTrack - 1
            print(indexOfCurrentTrack)
        }
        configuratePlayer(trackName: tracks[indexCurrentTrack!])
        updateUIByIndexTrack(indexTrack: indexCurrentTrack!)
    }

    //MARK: - create audioPath
func configuratePlayer(trackName: String) {
    do {
        if let audioPath = Bundle.main.path(forResource: trackName, ofType: "mp3"){
        try player = AVAudioPlayer(contentsOf: URL(fileURLWithPath: audioPath))
        self.durationSlider.maximumValue = Float(player.duration)
        self.soundSlider.maximumValue = Float(player.volume)
        }
    } catch {
        print("Error")
    }
    self.player.play()
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
    
    
    //MARK: - Buttons
    
    var isPlaying = true
    
    @IBAction func playPauseButton(_ sender: Any) {
        if isPlaying == true{
            DispatchQueue.main.async {
                self.playPauseButtonOutlet.setImage(UIImage(named: "play"), for: .normal)
                self.player.stop()
                UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
                    self.songImage.transform = CGAffineTransform(scaleX: 1.08, y: 1.08)
                })
               
            }
            isPlaying = false
            
        } else {
            DispatchQueue.main.async {
                self.playPauseButtonOutlet.setImage(UIImage(named: "pause"), for: .normal)
                self.player.play()
                UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
                    self.songImage.transform = CGAffineTransform(scaleX: 1, y: 1)
                })
            }
            isPlaying = true
            }
    }
        
    @IBAction func previousTrack(_ sender: Any) {
        if player.currentTime > 5 {
        player.currentTime = 0
        } else {
            switchingTracks(next: false)
        }
    }
    
    @IBAction func nextTrack(_ sender: Any) {
        switchingTracks(next: true)
    }
    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func shareButton(_ sender: Any) {
        let items: [Any] = ["\(artistLabel.text!)-\(trackLabel.text!)"]
        self.activitiViewContorller = UIActivityViewController(activityItems: items, applicationActivities: nil)
        self.present(self.activitiViewContorller!, animated: true, completion: nil)
    }
    

}


extension FirstViewController {
     func updateTimer() {
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
