//
//  resultViewController.swift
//  Hitsujichan
//
//  Created by A S on 2025/05/13.
//

import UIKit

class ResultViewController: UIViewController {
    
    @IBOutlet var resutartButton : UIButton!

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
}
