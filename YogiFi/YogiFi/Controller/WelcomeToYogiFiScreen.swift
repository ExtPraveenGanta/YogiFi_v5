//
//  WelcomeToYogiFiScreen.swift
//  YogiFi
//
//  Created by Girish Nandagiri on 11/08/20.
//  Copyright © 2020 Girish Nandagiri. All rights reserved.
//

import UIKit
import SwiftyJSON
import Lottie
import AVFoundation

class WelcomeToYogiFiScreen: UIViewController {
    @IBOutlet weak var logoAnimation: AnimationView!
    @IBOutlet weak var nameLabel: UILabel!
    var audioPlayer: AVAudioPlayer?
    @IBOutlet weak var startedBtn: CustomButtonCornerRadius8!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLabel.text = Constant.name?.uppercased()
        

    }
    
    override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(animated)
        logoAnimation.setupAnimationView(numberCircles: 3)
        playAudio()
       }
    


    @IBAction func backToLastScreen(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func get_started_action(_ sender: Any) {
        
        if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "YogaExpertiseScreen") as? YogaExpertiseScreen {
                   if let navigator = navigationController {
                       navigator.pushViewController(viewController, animated: true)
                   }
               }
    }
    
}



extension WelcomeToYogiFiScreen: AVAudioPlayerDelegate {
    func playAudio() {
        guard let url = Bundle.main.url(forResource: "namaste", withExtension: "mp3") else { return }
        do {
            audioPlayer = try AVAudioPlayer(contentsOf:url)
            audioPlayer?.delegate = self
            audioPlayer?.prepareToPlay()
            audioPlayer?.play()
        } catch {
            print("Cannot play the file")
        }
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        print("Ended playing namaste")
        UIView.animate(withDuration: 0.5) {
            self.startedBtn.isEnabled = true
            self.startedBtn.backgroundColor = .tealish
            self.startedBtn.setTitleColor(.white, for:.normal)
        }
    }
}
