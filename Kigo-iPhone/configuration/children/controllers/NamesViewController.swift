//
//  NamesViewController.swift
//  Kigo-iPhone
//
//  Created by Florian on 07/05/2020.
//  Copyright © 2020 blandinf. All rights reserved.
//

import UIKit

class NamesViewController: UIViewController {
    var numberOfChildrenSelected: Int = 0
    var firstnames: [String] = []
    var genders: [Character] = []
    @IBOutlet weak var myTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.myTableView.delegate = self
        self.myTableView.dataSource = self
        for index in 0..<numberOfChildrenSelected {
            self.genders.insert("H", at: index)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AgesViewController" {
            if let destination = segue.destination as? AgesViewController {
                destination.firstnames = self.firstnames
                destination.genders = self.genders
                destination.numberOfChildrenSelected = self.numberOfChildrenSelected
            }
        }
    }
}

extension NamesViewController:UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

extension NamesViewController:UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfChildrenSelected
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NamesViewController") as! NamesTableViewCell
        
        let index = indexPath.row + 1
        cell.childIndexLbl.text = "\(index)"
        
        cell.listenToFirstnameChanges { (firstnameValue) in
            if indexPath.row < self.firstnames.count {
                self.firstnames[indexPath.row] = firstnameValue
            } else {
                self.firstnames.insert(firstnameValue, at: indexPath.row)
            }
        }
        
        cell.listenToGenderChanges { (genderValue) in
            if indexPath.row < self.genders.count {
                self.genders[indexPath.row] = genderValue
            } else {
                self.genders.insert(genderValue, at: indexPath.row)
            }
        }
                
        return cell
    }
    
    
}
