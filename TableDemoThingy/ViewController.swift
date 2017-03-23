//
//  ViewController.swift
//  TableDemoThingy
//
//  Created by Paul Wilkinson on 23/3/17.
//  Copyright © 2017 Paul Wilkinson. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var containerConstraint: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func buttonTaped(_ sender: UIButton) {
        if containerConstraint.constant != 0 {
            containerConstraint.constant = 0
        } else {
            containerConstraint.constant = -90
        }
        
        UIView.animate(withDuration: 0.5) { 
            self.view.layoutIfNeeded()
        }
    }


}

