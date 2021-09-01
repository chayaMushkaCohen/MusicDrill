//
//  ViewController.swift
//  MusicProject
//
//  Created by hyperactive on 09/05/2021.
//  Copyright © 2021 hyperactive. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVAudioPlayerDelegate, UIScrollViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    var isAddingData: Bool = false
    var numberOfCells = 25
    
    @objc func stopAudio(_ sender: Any) {
        player.stop()
    }
    @objc func playAudio(_ sender: Any) {
        player.play()
    }
    var player: AVAudioPlayer = AVAudioPlayer()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        do {
            let audioPlayer = Bundle.main.path(forResource: "shtisel-end-theme", ofType: "mp3")
            try player = AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: audioPlayer!) as URL)
            
        }
        
        catch {
            
        }
        
        tableView.frame = CGRect(x: 0, y: 50, width: view.bounds.width, height: view.bounds.height)
        
        
        

    }


}
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return numberOfCells
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        cell.backgroundColor = .lightGray
        let playButton = setPlayAudioButton(cell: cell)
        cell.addSubview(playButton)

        let stopButton = setStopAudioButton(cell: cell)
 
        cell.addSubview(stopButton)
        
        return cell
    }
    
    func setStopAudioButton(cell: UITableViewCell) -> UIButton {
        let buttonWidth: CGFloat = 50

        let stopButton = UIButton(frame: CGRect(x: cell.bounds.width - 20 - buttonWidth, y: cell.bounds.height / 8, width: buttonWidth, height: (cell.bounds.height / 8) * 6))
         stopButton.backgroundColor = .red
         stopButton.addTarget(self, action: #selector(stopAudio), for: .touchUpInside)
         stopButton.setTitle("stop", for: .normal)
         stopButton.setTitleColor(.black, for: .normal)
         stopButton.titleLabel?.adjustsFontSizeToFitWidth = true
         stopButton.titleLabel?.textAlignment = .center
        return stopButton
    }
    
    func setPlayAudioButton(cell: UITableViewCell) -> UIButton {
        let buttonWidth: CGFloat = 50

        let playButton = UIButton(frame: CGRect(x: 20, y: 0, width: buttonWidth, height: cell.bounds.height) )
        print("cell: \(cell.bounds.height)")
        print(playButton.bounds.height)
        playButton.addTarget(self, action: #selector(playAudio), for: .touchUpInside)
        playButton.backgroundColor = .green
        playButton.setTitle("play", for: .normal)
        playButton.setTitleColor(.black, for: .normal)
        playButton.titleLabel?.adjustsFontSizeToFitWidth = true
        playButton.titleLabel?.textAlignment = .center
        return playButton
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 5
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.bounds.height / 6
    }
    
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if isAddingData {
            return
        }
        
        let position = scrollView.contentOffset.y
        if position > (tableView.contentSize.height - 100 - scrollView.frame.size.height) {
            isAddingData = true
            addDataToTable()
        }
    }
    
    func addDataToTable() {
        numberOfCells += 5
        tableView.reloadData()
        
        isAddingData = false
        
    }
    
    
    
    
    
    
}

