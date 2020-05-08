//
//  ChildrenViewController.swift
//  Kigo-iPhone
//
//  Created by Florian on 07/05/2020.
//  Copyright © 2020 blandinf. All rights reserved.
//

import UIKit

class NumberViewController: UIViewController {
    @IBOutlet weak var kigoLogo: UIImageView!
    @IBOutlet weak var numberOfChildren: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func stepperValueChanges(_ sender: UIStepper) {
        if let value = sender.value as? String {
            numberOfChildren.text = value
        }
    }
}
