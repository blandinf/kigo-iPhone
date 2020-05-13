//
//  InstallationTableViewCell.swift
//  Kigo-iPhone
//
//  Created by Florian on 12/05/2020.
//  Copyright © 2020 blandinf. All rights reserved.
//

import UIKit

class InstallationTableViewCell: UITableViewCell {
    var localCollback: ((Int)->())?
    @IBOutlet weak var childFirstnameLbl: UILabel!
    @IBOutlet weak var childLocation: UISegmentedControl!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func listenToLocationChanges(callback: @escaping (Int)->()) {
        self.localCollback = callback
    }
    
    @IBAction func locationValueChanges(_ sender: UISegmentedControl) {
        if let callback = localCollback {
            callback(sender.selectedSegmentIndex)
        }
    }
    

}
