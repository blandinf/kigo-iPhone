//
//  SleepViewController.swift
//  Kigo-iPhone
//
//  Created by Florian on 09/06/2020.
//  Copyright © 2020 blandinf. All rights reserved.
//

import UIKit

class SleepViewController: UIViewController {
    @IBOutlet weak var childSelected: UISegmentedControl!
    @IBOutlet weak var sleepMode: UISwitch!
    @IBOutlet weak var myTableView: UITableView!
    var sleeps = [Sleep]()
    var childrens = [Child]()
    var currentChild: Child?
    @IBOutlet weak var sleepModeLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.myTableView.delegate = self
        self.myTableView.dataSource = self
        self.view.backgroundColor = UIColor(hex: "#10294Cff")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        initializeSleeps()
        initializeChildren()
    }
    
    @IBAction func sleepModeChanges(_ sender: UISwitch) {
        if sender.isOn {
            sleepModeLbl.text = "Désactiver le mode repos"
            self.myTableView.isHidden = false
        } else {
            sleepModeLbl.text = "Activer le mode repos"
            self.myTableView.isHidden = true
        }
    }
    
    @IBAction func selectedChildChanges(_ sender: UISegmentedControl) {
        self.currentChild = self.childrens[sender.selectedSegmentIndex]
    }
    
    func initializeSleeps () {
        SleepService.getSleeps { sleepsArray, error in
            if let err = error {
                print(err)
                return
            }
            self.sleeps = sleepsArray
            self.myTableView.reloadData()
        }
    }
    
    func initializeChildren () {
        ChildrenService.getChildren { childrenArray, error in
            if let err = error {
                print(err)
                return
            }
            self.childrens = childrenArray
            self.currentChild = self.childrens[self.childSelected.selectedSegmentIndex]
            for (index, child) in self.childrens.enumerated() {
               self.childSelected.setTitle(child.firstname, forSegmentAt: index)
            }
        }
    }
}

extension SleepViewController:UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

extension SleepViewController:UITableViewDataSource {
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor(hex: "#10294Cff")
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 15
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.sleeps.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SleepViewController", for: indexPath) as! SleepTableViewCell
        
        cell.clipsToBounds = true
        
        var currentSleep = self.sleeps[indexPath.section]
        
        cell.title.text = currentSleep.title.uppercased()
        cell.descriptionLbl.text = currentSleep.description
        cell.myImageView.image = UIImage(named: currentSleep.icon)
        
        cell.listenToPlayChanges { (isLaunched) in
            if let child = self.currentChild {
                if isLaunched {
                    cell.playBtn.setImage(UIImage(named: "pause"), for: .normal)
                    cell.title.textColor = UIColor(hex: "#F04E23ff")
                    cell.descriptionLbl.text = "En cours de lecture"
                    cell.descriptionLbl.textColor = UIColor(hex: "#F04E23ff")
                    ChildrenService.updateActivity(id: child.id, activity: "sleeping")
                    ChildrenService.updateCurrentSleep(id: child.id, currentSleep: currentSleep.title)
                } else {
                    cell.playBtn.setImage(UIImage(named: "play"), for: .normal)
                    cell.title.textColor = UIColor(hex: "#10294Cff")
                    cell.descriptionLbl.textColor = UIColor(hex: "#10294Cff")
                    cell.descriptionLbl.text = currentSleep.description
                    ChildrenService.updateActivity(id: child.id, activity: "")
                    ChildrenService.updateCurrentSleep(id: child.id, currentSleep: "")
                }
            }
        }
        
        return cell
    }
    
    
}

