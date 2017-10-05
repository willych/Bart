//
//  HaHaViewController.swift
//  HaHa
//
//  Created by Student on 9/15/16.
//  Copyright © 2016 Willy Choi. All rights reserved.
//

import UIKit
import AVFoundation

class HaHaViewController: UIViewController {

    let HA_HA_FILE = "haha"
    let HA_HA_FORMAT = "mp3"
    
    var player: AVAudioPlayer?
    var counter: Int
    
    required init?(coder aDecoder: NSCoder) {
        counter = 0
        
        if let soundFilePath = Bundle.main.path(forResource: HA_HA_FILE, ofType: HA_HA_FORMAT) {
            let fileUrl = URL(fileURLWithPath: soundFilePath)
            do{
                player = try AVAudioPlayer(contentsOf: fileUrl)
            } catch let error as NSError {
                player = nil
                print(error)
            }
        } else {
            player = nil
        }
        
        player?.prepareToPlay() //eliminate delay
        
        super.init(coder: aDecoder)
    }
    
    //MARK: -View Methods
    
    @IBOutlet weak var label : UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        label.shadowColor = UIColor.gray
        label.shadowOffset = CGSize(width: 3, height: -3)
        label.textColor = UIColor.white
        label.font = UIFont(name: "MarkerFelt-Wide", size: 30)
        label.text = ""
        
    }
    
    //MARK: -Action Methods
    @IBAction func playSound(_ sender:UIButton){
        if player != nil {
            player!.play()
            counter += 1
            label.text = "Ha Ha #\(counter)"
            
        }
        AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
        //animate button
        let shake = CABasicAnimation(keyPath: "position")
        shake.duration = 0.1
        shake.repeatCount = 2
        shake.autoreverses = true
        shake.fromValue = NSValue(cgPoint: CGPoint(x:sender.center.x-5,y:sender.center.y))
        shake.toValue = NSValue(cgPoint: CGPoint(x:sender.center.x+5,y:sender.center.y))
        sender.layer.add(shake,forKey: "position")
    }
    
    @IBAction func stopSound(_ sender:UIButton){
        if player != nil {
            if (player?.isPlaying)! {
                player!.stop()
                player!.currentTime = 0
            }
            
        }

    }
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

