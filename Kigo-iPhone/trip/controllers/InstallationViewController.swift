//
//  InstallationViewController.swift
//  Kigo-iPhone
//
//  Created by Florian on 07/05/2020.
//  Copyright © 2020 blandinf. All rights reserved.
//

import UIKit
import Firebase

class InstallationViewController: UIViewController {
    @IBOutlet weak var myTableView: UITableView!
    var childrens = [Child]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myTableView.delegate = self
        myTableView.dataSource = self
        initializeChildren()
    }
    
    
    func initializeChildren () {
        ChildrenService.getChildren { childrenArray, error in
            if let err = error {
                print(err)
                return
            }
            self.childrens = childrenArray
            self.myTableView.reloadData()
        }
    }
}

extension InstallationViewController:UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

extension InstallationViewController:UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 15
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.childrens.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "InstallationViewController", for: indexPath) as! InstallationTableViewCell
        
        cell.clipsToBounds = true
        
        let currentChild = self.childrens[indexPath.section]
                
        cell.childFirstnameLbl.text = currentChild.firstname
        cell.childLocation.selectedSegmentIndex = currentChild.location
        cell.listenToLocationChanges { (locationValue) in
            ChildrenService.updateLocation(id: currentChild.id, locationValue: locationValue)
            cell.childLocation.selectedSegmentIndex = locationValue
        }
        
        return cell
    }
    
    
}
