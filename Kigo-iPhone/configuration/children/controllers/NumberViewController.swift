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
        numberOfChildren.text = "0"
    }
    
    @IBAction func stepperValueChanges(_ sender: UIStepper) {
        numberOfChildren.text = "\(Int(sender.value))"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       if segue.identifier == "NamesViewController" {
           if let destination = segue.destination as? NamesViewController {
                if let text = Int(numberOfChildren.text!) {
                    destination.numberOfChildrenSelected = text
                }
            }
       }
   }
}
