//
//  topViewController.swift
//  Hitsujichan
//
//  Created by A S on 2025/05/13.
//

import UIKit
import AVFoundation

class topViewController: UIViewController {
    
    @IBOutlet var startButton: UIButton!
    
    @IBOutlet var titleLabel: UIImageView!
    
    // スタートボタンが押されたらメーと鳴くよ！！　メ〜メ〜
    let sheep_soundPlayer = try!AVAudioPlayer(data:NSDataAsset(name:"sheep_sound")!.data)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        startBlinkingAnimation(for: startButton)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIView.animate(withDuration: 1.0, delay: 0, options: [.curveEaseIn, .autoreverse, .repeat], animations: {
            self.titleLabel.transform = CGAffineTransform(translationX: 0, y: 10.0)
        }) { _ in
            self.titleLabel.transform = .identity
        }
    }
    
    @IBAction func startButtonTapped(_ sender: UIButton) {
        
        // 羊の鳴き声を再生する
        sheep_soundPlayer.play()
        
        // Create a circular layer for the animation
        let circleLayer = CAShapeLayer()
        let startPath = UIBezierPath(ovalIn: CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0))
        let endRadius = sqrt(pow(self.view.bounds.width, 2) + pow(self.view.bounds.height, 2))
        let endPath = UIBezierPath(ovalIn: CGRect(x: self.view.bounds.midX - endRadius, y: self.view.bounds.midY - endRadius, width: endRadius * 2, height: endRadius * 2))
        
        circleLayer.path = endPath.cgPath
        circleLayer.fillColor = UIColor.black.cgColor
        self.view.layer.addSublayer(circleLayer)
        
        // Animate the circle expansion
        let animation = CABasicAnimation(keyPath: "path")
        animation.fromValue = startPath.cgPath
        animation.toValue = endPath.cgPath
        animation.duration = 2.0 // Increased duration for a slower animation
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        circleLayer.add(animation, forKey: "path")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            let storyboard = UIStoryboard(name: "Main", bundle: nil) // Replace "Main" with your storyboard name
            let viewController = storyboard.instantiateViewController(identifier: "ViewController") // Replace "ViewController" with the appropriate Storyboard ID
            viewController.modalPresentationStyle = .fullScreen
            self.present(viewController, animated: false, completion: nil)
        }
        
        // コミット用テストメッセージ
    }
    
}
// ボタンをチカチカ点灯させるメソッド
func startBlinkingAnimation(for button: UIButton) {
    UIView.animate(withDuration: 1,
                   delay: 0,
                   options: [.repeat, .autoreverse],
                   animations: {
        button.alpha = 0.5 // Adjust transparency to create a blinking effect
    },
                   completion: nil)
}

