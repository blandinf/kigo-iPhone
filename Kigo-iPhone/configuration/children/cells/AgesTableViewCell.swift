//
//  AgesTableViewCell.swift
//  Kigo-iPhone
//
//  Created by Florian on 08/05/2020.
//  Copyright © 2020 blandinf. All rights reserved.
//

import UIKit

class AgesTableViewCell: UITableViewCell {
    @IBOutlet weak var childFirstnameLbl: UILabel!
    @IBOutlet weak var childAgeLbl: UILabel!
    var localCollback: ((Int)->())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func listenToStepperValueChanges(callback: @escaping (Int)->()) {
        self.localCollback = callback
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    @IBAction func stepperValueChanges(_ sender: UIStepper) {
        childAgeLbl.text = "\(Int(sender.value))"
        
         if let callback = localCollback {
            callback(Int(sender.value))
        }
    }
    
}
