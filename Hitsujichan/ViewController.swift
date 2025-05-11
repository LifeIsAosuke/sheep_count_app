//
//  ViewController.swift
//  Hitsujichan
//
//  Created by 酒井みな実 on 2025/05/11.
//

import UIKit
import AVFoundation // ← 追加！

class ViewController: UIViewController {

    var number: Int = 0
    var sheepStack: [UIImageView] = []
    let sheepSize = CGSize(width: 100, height: 100)
    let stackStartY: CGFloat = UIScreen.main.bounds.height - 100
    let stackCenterX: CGFloat = UIScreen.main.bounds.width / 2

    var player: AVAudioPlayer? // ← 音声プレイヤーの変数
    let drumSoundPlayer = try!AVAudioPlayer(data: NSDataAsset (name: "sheep_sound" )!.data)

    @IBOutlet var label: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func plus() {
        switch number {
        case 0 ..< 30:
            self.view.backgroundColor = UIColor.cyan
        case 30 ..< 60:
            self.view.backgroundColor = UIColor.blue
        case 60 ..< 90:
            self.view.backgroundColor = UIColor.systemIndigo
        case 90 ..< 101:
            self.view.backgroundColor = UIColor.black
            
        default:
            break

        }
        drumSoundPlayer.currentTime = 0
        drumSoundPlayer.play()
        let sheepImageView = UIImageView(image: UIImage(named: "hitsuji"))
        sheepImageView.frame.size = sheepSize

        let stackHeight = CGFloat(sheepStack.count) * sheepSize.height
        sheepImageView.center = CGPoint(x: stackCenterX, y: stackStartY - stackHeight)

        view.addSubview(sheepImageView)
        sheepStack.append(sheepImageView)

        number += 1
        label.text = String(number)

//        playSheepSound() // ← 音を再生！
    }

    func playSheepSound() {
        guard let soundURL = Bundle.main.url(forResource: "sheep_sound", withExtension: "mp3") else {
            print("音声ファイルが見つかりません")
            return
        }

        do {
            player = try AVAudioPlayer(contentsOf: soundURL)
            player?.play()
        } catch {
            print("音声の再生に失敗しました: \(error.localizedDescription)")
        }
    }
}
