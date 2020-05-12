//
//  AgesViewController.swift
//  Kigo-iPhone
//
//  Created by Florian on 07/05/2020.
//  Copyright © 2020 blandinf. All rights reserved.
//

import UIKit

class AgesViewController: UIViewController {
    @IBOutlet weak var myTableView: UITableView!
    var numberOfChildrenSelected: Int = 0
    var firstnames = [String]()
    var genders = [Character]()
    var ages = [Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.myTableView.delegate = self
        self.myTableView.dataSource = self
    }
}

extension AgesViewController:UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return firstnames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AgesViewController", for: indexPath) as! AgesTableViewCell
        
        cell.childFirstnameLbl.text = firstnames[indexPath.row]
        
        cell.listenToStepperValueChanges { (ageValue) in
            if indexPath.row < self.ages.count  {
                self.ages[indexPath.row] = ageValue
            } else {
                self.ages.insert(ageValue, at: indexPath.row)
            }
        }
        
        return cell
    }
    
    
}

extension AgesViewController:UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
