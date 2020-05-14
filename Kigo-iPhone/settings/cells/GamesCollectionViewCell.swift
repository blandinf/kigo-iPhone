//
//  GamesCollectionViewCell.swift
//  Kigo-iPhone
//
//  Created by Florian on 14/05/2020.
//  Copyright © 2020 blandinf. All rights reserved.
//

import UIKit

class GamesCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var myImageView: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    var localCollback: (()->())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func listenToBanClicked(callback: @escaping ()->()) {
        self.localCollback = callback
    }
    
    @IBAction func banGame(_ sender: Any) {
        if let callback = localCollback {
            callback()
        }
    }
}
