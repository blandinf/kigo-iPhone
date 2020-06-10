//
//  ViewController.swift
//  Kigo-iPhone
//
//  Created by Florian on 07/05/2020.
//  Copyright © 2020 blandinf. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
    
    @IBOutlet weak var settingsBackgroundView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingsBackgroundView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner, .layerMinXMinYCorner]
    }
    
    @IBAction func newDeparture(_ sender: Any) {
        let defaults = UserDefaults.standard
        if let alreadyLaunched = defaults.object(forKey: "launchForFirstTime") {
            let installationViewController = storyBoard.instantiateViewController(withIdentifier: "InstallationViewController") as! InstallationViewController
            self.navigationController?.pushViewController(installationViewController, animated: true)
        } else {
            defaults.set(true, forKey: "launchForFirstTime")
            let numberViewController = storyBoard.instantiateViewController(withIdentifier: "NumberViewController") as! NumberViewController
            self.navigationController?.pushViewController(numberViewController, animated: true)
        }
    }

}

