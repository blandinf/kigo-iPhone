//
//  TravelTableViewCell.swift
//  Kigo-iPhone
//
//  Created by Florian on 09/06/2020.
//  Copyright © 2020 blandinf. All rights reserved.
//

import UIKit

class TravelTableViewCell: UITableViewCell {
    @IBOutlet weak var firstnameLbl: UILabel!
    @IBOutlet weak var activityLbl: UILabel!
    @IBOutlet weak var actionLbl: UILabel!
    @IBOutlet weak var blockBtn: UIButton!
    var localCollback: (()->())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func blockGame(_ sender: Any) {
        if let callback = localCollback {
            callback()
        }
    }
    
    func listenToBlockGameChanges(callback: @escaping ()->()) {
        self.localCollback = callback
    }
}
