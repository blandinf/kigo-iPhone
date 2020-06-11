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
    @IBOutlet weak var nextButton: UIButton!
    var childrens = [Child]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        destinationTF.addTarget(self, action: #selector(MapViewController.textFieldDidChange(_:)), for: .editingChanged)
        destinationTF.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: destinationTF.frame.height))
        destinationTF.leftViewMode = .always
    }
    
    override func viewWillAppear(_ animated: Bool) {
        initializeChildren()
    }
    
    func initializeChildren () {
        ChildrenService.getChildren { childrenArray, error in
            if let err = error {
                print(err)
                return
            }
            self.childrens = childrenArray
        }
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if textField.text!.isEmpty {
            nextButton.setTitle("RENSEIGNER PLUS TARD", for: .normal)
        } else {
            nextButton.setTitle("VALIDER", for: .normal)
        }
    }
    
    @IBAction func next(_ sender: UIButton) {
        if let destination = destinationTF.text {
            for child in self.childrens {
                ChildrenService.updateDestination(id: child.id, destination: destination)
            }
        }
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
