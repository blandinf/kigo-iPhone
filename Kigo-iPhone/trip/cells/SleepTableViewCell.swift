//
//  SleepTableViewCell.swift
//  Kigo-iPhone
//
//  Created by Florian on 09/06/2020.
//  Copyright © 2020 blandinf. All rights reserved.
//

import UIKit

class SleepTableViewCell: UITableViewCell {
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var playBtn: UIButton!
    @IBOutlet weak var myImageView: UIImageView!
    var isLaunched = false
    var localCollback: ((Bool)->())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func play(_ sender: Any) {
        self.isLaunched = !self.isLaunched
        if let callback = localCollback {
            callback(self.isLaunched)
        }
    }
    
    func listenToPlayChanges(callback: @escaping (Bool)->()) {
        self.localCollback = callback
    }
    
}
