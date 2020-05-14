//
//  MapViewController.swift
//  Kigo-iPhone
//
//  Created by Florian on 07/05/2020.
//  Copyright © 2020 blandinf. All rights reserved.
//

import UIKit

class MapViewController: UIViewController {
    @IBOutlet weak var destinationTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "TabBarController" {
            if let tabBarController = segue.destination as? UITabBarController {
                if let text = destinationTF.text {
                    if let travelViewController = tabBarController.viewControllers![0] as? TravelViewController {
                        travelViewController.destination = text
                    }
                    if let gameViewController = tabBarController.viewControllers![1] as? GameViewController {
                        gameViewController.destination = text
                    }
                }
            }
        }
    }
}
