//
//  TravelViewController.swift
//  Kigo-iPhone
//
//  Created by Florian on 13/05/2020.
//  Copyright © 2020 blandinf. All rights reserved.
//

import UIKit

class TravelViewController: UIViewController {
    var destination: String?
    @IBOutlet weak var destinationLbl: UILabel!
    @IBOutlet weak var childSelected: UISegmentedControl!
    var childrens = [Child]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let dest = destination {
            destinationLbl.text! += " " + dest.uppercased()
        }
        initializeChildren()
    }
    
    func initializeChildren () {
        ChildrenService.getChildren { childrenArray, error in
            if let err = error {
                print(err)
                return
            }
            self.childrens = childrenArray
            for (index, child) in self.childrens.enumerated() {
                self.childSelected.setTitle(child.firstname, forSegmentAt: index)
            }
        }
    }
    
    @IBAction func childSelectedChanges(_ sender: Any) {
        
    }
    
    @IBAction func stopGame(_ sender: Any) {
        
    }
    
    @IBAction func pauseGame(_ sender: Any) {
        
    }
    
}
