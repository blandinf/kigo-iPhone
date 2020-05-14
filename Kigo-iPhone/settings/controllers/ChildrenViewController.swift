//
//  ChildrenViewController.swift
//  Kigo-iPhone
//
//  Created by Florian on 07/05/2020.
//  Copyright © 2020 blandinf. All rights reserved.
//

import UIKit

class ChildrenViewController: UIViewController {
    @IBOutlet weak var myTableView: UITableView!
    var childrens = [Child]()
    var selectedChild: Child?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myTableView.delegate = self
        myTableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.initializeChildren()
        }
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EditChildViewController" {
            if let destination = segue.destination as? EditChildViewController {
                if let child = selectedChild {
                    destination.child = child
                }
            }
        }
    }
    
}

extension ChildrenViewController:UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

extension ChildrenViewController:UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return childrens.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChildrenTableViewCell", for: indexPath) as! ChildrenTableViewCell
        
        cell.firstnameLbl.text = childrens[indexPath.row].firstname
        cell.listenToEditClicked { () in
            self.selectedChild = self.childrens[indexPath.row]
        }
        
        return cell
    }
    
    
}
