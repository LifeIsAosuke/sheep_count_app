//
//  resultViewController.swift
//  Hitsujichan
//
//  Created by A S on 2025/05/13.
//

import UIKit
import AVFoundation

class ResultViewController: UIViewController {
    
    @IBOutlet var resutartButton : UIButton!
    
    @IBOutlet var sheep: UIImageView!
    
    @IBOutlet var advice: UILabel!
    
    let musicPlayer = try!AVAudioPlayer(data:NSDataAsset(name:"成功音")!.data)

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        musicPlayer.play()
        
        // 画面呼び出し時にランダムに励ましの言葉を表示
        let message = getEncouragementMessage()
        advice.text = message
        advice.numberOfLines = 0
    }
    
    @IBAction func resultToTop(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let topViewController = storyboard.instantiateViewController(withIdentifier: "topViewController") as? topViewController {
            topViewController.modalPresentationStyle = .fullScreen
            self.present(topViewController, animated: true, completion: nil)
        }
    }
    
    // 羊のアニメーション
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        UIView.animateKeyframes(withDuration: 2.0, delay: 0, options: [.repeat], animations: {
            // 小さく跳ねる（上に15ポイント）
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.25) {
                self.sheep.transform = CGAffineTransform(translationX: 0, y: -15)
            }
            // 戻る（元の位置）
            UIView.addKeyframe(withRelativeStartTime: 0.25, relativeDuration: 0.25) {
                self.sheep.transform = .identity
            }
            // 大きく跳ねる（上に40ポイント）
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.25) {
                self.sheep.transform = CGAffineTransform(translationX: 0, y: -40)
            }
            // 戻る（元の位置）
            UIView.addKeyframe(withRelativeStartTime: 0.75, relativeDuration: 0.25) {
                self.sheep.transform = .identity
            }
        })
    }
    
    // リザルト画面が表示された際、ランダムで励ましの言葉を表示
    func getEncouragementMessage() -> String {
        // ランダムな数字を生成
        let randomNumber = Int.random(in: 1...10)

        // ランダムなメッセージを選ぶ
        switch randomNumber {
        case 1:
            return "今日も素晴らしい一日になるよ！自分を信じて進もう。"
        case 2:
            return "昨日よりも一歩前進！小さな努力が大きな成果になるよ。"
        case 3:
            return "笑顔で始めると、きっと素敵なことが待っているよ。"
        case 4:
            return "挑戦は成長のチャンス！今日も楽しもう！"
        case 5:
            return "君の努力は確実に報われるよ。自信を持って！"
        case 6:
            return "どんな困難も乗り越えられる力が君にはあるよ。"
        case 7:
            return "周りを照らす明るさを忘れずにね。君は素敵だよ！"
        case 8:
            return "どんな小さな成功も君を前に進めているよ。"
        case 9:
            return "新しいチャンスが今日も待っているよ。勇気を持って踏み出そう！"
        case 10:
            return "君はそのままで十分素晴らしいよ。今日も自分らしく！"
        default:
            return "今日も一日頑張ろう！"
        }
    }
}


