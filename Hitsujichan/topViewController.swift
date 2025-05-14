//
//  topViewController.swift
//  Hitsujichan
//
//  Created by A S on 2025/05/13.
//

import UIKit

class topViewController: UIViewController {
    
    @IBOutlet var startButton: UIButton!
    
    @IBOutlet var titleLabel: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

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
        let storyboard = UIStoryboard(name: "Main", bundle: nil) // Replace "Main" with your storyboard name
        let viewController = storyboard.instantiateViewController(identifier: "ViewController") // Replace "ViewController" with the appropriate Storyboard ID
        viewController.modalPresentationStyle = .fullScreen
        present(viewController, animated: true, completion: nil)
    }

}
