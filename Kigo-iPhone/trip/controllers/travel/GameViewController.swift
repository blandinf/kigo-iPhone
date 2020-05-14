//
//  GameViewController.swift
//  Kigo-iPhone
//
//  Created by Florian on 13/05/2020.
//  Copyright © 2020 blandinf. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    var destination: String?
    @IBOutlet weak var destinationLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let dest = destination {
            destinationLbl.text! += " " + dest.uppercased()
        }
    }
}
