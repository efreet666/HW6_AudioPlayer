//
//  ViewController.swift
//  HW6_AudioPlayer
//
//  Created by Влад Бокин on 11.08.2021.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @objc func buttonAction(sender: UIButton!) {
        self.performSegue(withIdentifier: "FirstViewController", sender: "John")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "showVC" {
                if let vc = segue.destination as? FirstViewController {
                    guard let text = sender as? String else { return }
                }
            }
        }
    
    var artistName: String!
    var songName: [String : String] = ["Weekend" : "Bliding light", "Michael Kiwanuka" : "Cold little heart"]
    
//    var songName: [String] = ["Weekend - Bliding light", "Michael Kiwanuka - Cold little heart"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var i = 1
        func createCell(){
            for (name, artist) in songName {
            let areaButton = UIButton()
                areaButton.frame = CGRect(x: 0, y: 100 * i , width: Int(self.view.frame.width), height: 100)
   
            
            areaButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
            self.view.addSubview(areaButton)

            let musicLabel = UILabel()
                musicLabel.frame = CGRect(x: Int(self.view.frame.width) / 2 - 50, y: 50, width: 250, height: 30)
            musicLabel.font = UIFont(name:"HelveticaNeue", size: 20.0)
            musicLabel.text = "Music player"
            self.view.addSubview(musicLabel)
            
            let cellView = UIView()
                cellView.frame = CGRect(x: 20, y: 200, width: Int(self.view.frame.width) - 40, height: 1)
            cellView.backgroundColor = UIColor.lightGray
            self.view.addSubview(cellView)
            
            let nameLabel = UILabel()
            nameLabel.frame = CGRect(x: 110, y: 105 * i, width: 250, height: 50)
                nameLabel.text = "\(name)"
                nameLabel.font = UIFont(name:"HelveticaNeue-Bold", size: 20.0)
                self.view.addSubview(nameLabel)
            
            let songLabel = UILabel()
            songLabel.frame = CGRect(x: 110, y: 125 * i, width: 250, height: 50)
                songLabel.text = "\(artist)"
            songLabel.font = UIFont(name:"HelveticaNeue-Bold", size: 20.0)
                self.view.addSubview(songLabel)
            
            let songImage = UIImageView()
            songImage.frame = CGRect(x: 10, y: 105 * i , width: 90, height: 90) //song count
            songImage.image = UIImage(named: "\(name)")
            self.view.addSubview(songImage)
            i += 1
            }
        }
        createCell()
           
        
    }

 
    

}

