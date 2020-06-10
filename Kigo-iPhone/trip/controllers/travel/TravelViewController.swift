//
//  TravelViewController.swift
//  Kigo-iPhone
//
//  Created by Florian on 13/05/2020.
//  Copyright © 2020 blandinf. All rights reserved.
//

import UIKit
import Firebase

class TravelViewController: UIViewController {
    var destination: String?
    var childrens = [Child]()
    @IBOutlet weak var myTableView: UITableView!
    @IBOutlet weak var effectView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(hex: "#F04E23ff")
        self.effectView.backgroundColor = UIColor(hex: "#CC421Eff")
        self.view.sendSubviewToBack(self.effectView)
        myTableView.delegate = self
        myTableView.dataSource = self
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
            self.myTableView.reloadData()
        }
    }
    
    func updateActivity (activity: String, currentGame: String) -> String {
        if activity == "gaming" {
            if currentGame.isEmpty {
                return "Est en train de choisir son jeu..."
            } else {
                return "Joue actuellement au jeu : " + currentGame
            }
        } else if (activity == "drawing") {
            return "Dessine dans l'espace créatif."
        } else {
            return "N'utilise pas sa vitre."
        }
    }
}

extension TravelViewController:UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 220
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

extension TravelViewController:UITableViewDataSource {
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor(hex: "#F04E23ff")
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 20
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.childrens.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TravelViewController", for: indexPath) as! TravelTableViewCell
        
        cell.clipsToBounds = true
        cell.layer.cornerRadius = 20
        
        var currentChild = self.childrens[indexPath.section]

        cell.firstnameLbl.text = currentChild.firstname.uppercased()
        
        if currentChild.activity == "" || currentChild.activity == "drawing" {
            cell.actionLbl.text = "Pas d'actions disponibles"
            cell.blockBtn.isHidden = true
        }
        
        cell.listenToBlockGameChanges { () in
            let gameName = currentChild.currentGame
            if !gameName.isEmpty {
                if currentChild.gamesNotAllowed.contains(gameName) {
                    let index = currentChild.gamesNotAllowed.firstIndex(of: gameName)
                    currentChild.gamesNotAllowed.remove(at: index!)
                    
                } else {
                    currentChild.gamesNotAllowed.append(gameName)
                    ChildrenService.updateActivity(id: currentChild.id, activity: "")
                    ChildrenService.updateCurrentGame(id: currentChild.id, currentGame: "")
                }
                ChildrenService.updateGamesNotAllowed(id: currentChild.id, gamesNotAllowed: currentChild.gamesNotAllowed)
            }
        }
        
        
        Firestore.firestore().collection("child").document(currentChild.id)
        .addSnapshotListener { documentSnapshot, error in
            guard let snapshot = documentSnapshot else {
                print("Error fetching snapshots: \(error!)")
                return
            }
            if let activity = snapshot.data()!["activity"] as? String,
               let currentGame = snapshot.data()!["currentGame"] as? String
            {
                cell.activityLbl.text = self.updateActivity(activity: activity, currentGame: currentGame)
                if activity == "gaming" && !currentGame.isEmpty {
                    cell.blockBtn.isHidden = false
                    cell.actionLbl.text = "Interdir le jeu"
                } else {
                    cell.actionLbl.text = "Pas d'actions disponibles"
                    cell.blockBtn.isHidden = true
                }
            }
        }
        
        cell.activityLbl.text = self.updateActivity(activity: currentChild.activity, currentGame: currentChild.currentGame)
        
        
        return cell
    }
    
    
}
