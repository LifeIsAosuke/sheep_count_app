//
//  resultViewController.swift
//  Hitsujichan
//
//  Created by A S on 2025/05/13.
//

import UIKit

class ResultViewController: UIViewController {
    
    @IBOutlet var resutartButton : UIButton!
    
    @IBOutlet var sheep: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

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
}

