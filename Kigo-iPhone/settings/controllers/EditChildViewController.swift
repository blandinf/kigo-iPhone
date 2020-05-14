//
//  EditChildViewController.swift
//  Kigo-iPhone
//
//  Created by Florian on 13/05/2020.
//  Copyright © 2020 blandinf. All rights reserved.
//

import UIKit

class EditChildViewController: UIViewController {
    var child: Child?
    @IBOutlet weak var profileLbl: UILabel!
    @IBOutlet weak var birthdate: UIDatePicker!
    @IBOutlet weak var firstnameTF: UITextField!
    @IBOutlet weak var gender: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let child = child {
            profileLbl.text! += " " + child.firstname
            firstnameTF.text = child.firstname
            gender.selectedSegmentIndex = child.gender == "H" ? 0 : 1
        }
    }
    
    @IBAction func update(_ sender: Any) {
        if var child = child,
            let firstname = firstnameTF.text {
            child.firstname = firstname
            child.gender = gender.selectedSegmentIndex == 0 ? "H" : "F"
            ChildrenService.updateChild(child: child)
            navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func cancel(_ sender: Any) {
        
    }
    
    
    
}
