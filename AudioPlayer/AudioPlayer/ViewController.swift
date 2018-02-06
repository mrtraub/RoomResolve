//
//  ViewController.swift
//  AudioPlayer
//
//  Created by Logan Riddick on 1/28/18.
//  Copyright © 2018 Logan Riddick. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVAudioRecorderDelegate, AVAudioPlayerDelegate{

    var audioPlayer = AVAudioPlayer()
    var audioRecorder: AVAudioRecorder?
    var player: AVAudioPlayer?
    var isRecording = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func playSoundWith(fileName: String, fileExtension: String) -> Void {
        let audioSourceURL: URL!
        audioSourceURL = Bundle.main.url(forResource: fileName, withExtension: fileExtension)
        
        if audioSourceURL == nil {
            print("Can't Find that Song!")
        }
        else{
            do {
                audioPlayer = try AVAudioPlayer.init(contentsOf: audioSourceURL!)
                audioPlayer.prepareToPlay()
                audioPlayer.play()
            }
            catch {
                print(error)
            }
        }
    }
    
    func startRecording() {
        // 1)create the session
        let session = AVAudioSession.sharedInstance()
        
        do {
            // 2)configure the session for recording and playback
            try session.setCategory(AVAudioSessionCategoryPlayAndRecord, with: .defaultToSpeaker)
            try session.setActive(true)
            // 3)set up high quality recording session
            let settings = [
                AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
                AVSampleRateKey: 44100,
                AVNumberOfChannelsKey: 2,
                AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
            ]
            
            
            // 4)create the audio recording and assign ouselves as the delegate
            audioRecorder = try AVAudioRecorder(url: getAudioFileUrl(), settings: settings)
            audioRecorder?.delegate = self
            audioRecorder?.record(forDuration: 39.0)
            
            isRecording = true
            print("I am recording you.")
        }
            catch let error {
            print("Failed to record")
        }
    }
    
    
    func getAudioFileUrl() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let docsDirect = paths[0]
        let audioUrl = docsDirect.appendingPathComponent("freqResp.m4a")
        return audioUrl
    }
    
    func finishRecording() {
        audioRecorder?.stop()
        isRecording = false
        print("I finished recording you.")
        
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag {
            finishRecording()
        } else {
            // Recording interrupted by other reasons like call coming, reached time limit.
        }
    }
    
    func playRecording() {
        let url = getAudioFileUrl()
        do {
            
            /*audioPlayer = try AVAudioPlayer.init(contentsOf: url)
            audioPlayer.prepareToPlay()
            audioPlayer.play()*/
            
            
            //AVAudioPlayer setting up with saved file URL
            let sound = try AVAudioPlayer(contentsOf: url)
            self.player = sound
            
            //conforming to AVAudioPlayerDelegate
            sound.delegate = self
            sound.prepareToPlay()
            sound.play()
            
        } catch {
            print("Error playing back the recording")
        }
    }
    
    
    //IB Actions
    @IBAction func playButton(_ sender: UIButton) {
        
        AVAudioSession.sharedInstance().requestRecordPermission() {
            [unowned self] allowed in
            if allowed {
                print("Thanks")
            }
            else {
                print("Error")
            }
        }
        
        self.startRecording()
        self.playSoundWith(fileName: "WhiteNoise", fileExtension: "wav")
    }
    
    @IBAction func playbackTapped(_ sender: UIButton) {
        print("Playing the recording!")
        //playSoundWith(fileName: "freqResp", fileExtension: "mp4")
        playRecording()
        print("Finished playing the recording.")
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

