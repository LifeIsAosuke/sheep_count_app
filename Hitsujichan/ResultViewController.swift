//
//  resultViewController.swift
//  Hitsujichan
//
//  Created by A S on 2025/05/13.
//

import UIKit

class ResultViewController: UIViewController {
    
    @IBOutlet weak var ImageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(backToTop))
        ImageView.isUserInteractionEnabled = true
        ImageView.addGestureRecognizer(tapGesture)
    }
    
    @IBAction func backToTop(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

   
}
