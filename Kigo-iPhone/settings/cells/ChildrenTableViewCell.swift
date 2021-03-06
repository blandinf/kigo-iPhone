//
//  ChildrenTableViewCell.swift
//  Kigo-iPhone
//
//  Created by Florian on 13/05/2020.
//  Copyright © 2020 blandinf. All rights reserved.
//

import UIKit

class ChildrenTableViewCell: UITableViewCell {
    @IBOutlet weak var firstnameLbl: UILabel!
    @IBOutlet weak var ageLbl: UILabel!
    var localCollback: (()->())?
    @IBOutlet weak var editBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        editBtn.titleLabel!.attributedText = NSAttributedString(string: "Modifier", attributes:
                [.underlineStyle: NSUnderlineStyle.single.rawValue])
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func listenToEditClicked(callback: @escaping ()->()) {
        self.localCollback = callback
    }
    
    @IBAction func edit(_ sender: UIButton) {
        if let callback = localCollback {
            callback()
        }
    }
    
}
