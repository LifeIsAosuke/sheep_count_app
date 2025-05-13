//
//  topViewController.swift
//  Hitsujichan
//
//  Created by A S on 2025/05/13.
//

import UIKit

class topViewController: UIViewController {
    
    @IBOutlet var startButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

    }
    
    override func viewWillAppear(_ animated: Bool) {
//        self.startButton.center = self.view.center
        UIView.animate(withDuration: 1.0, delay : 0, options : [.curveEaseIn, .autoreverse, .repeat], animations : {
            self.startButton.center.y += 10.0
        }) { _ in
            self.startButton.center.y -= 10.0
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
