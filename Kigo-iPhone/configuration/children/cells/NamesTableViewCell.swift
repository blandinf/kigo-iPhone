//
//  NamesTableViewCell.swift
//  Kigo-iPhone
//
//  Created by Florian on 08/05/2020.
//  Copyright © 2020 blandinf. All rights reserved.
//

import UIKit

class NamesTableViewCell: UITableViewCell {
    @IBOutlet weak var childIndexLbl: UILabel!
    @IBOutlet weak var childFirstnameTF: UITextField!
    @IBOutlet weak var childGender: UISegmentedControl!
    var localCollbackFirstname: ((String)->())?
    var localCollbackGender: ((Character)->())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        childFirstnameTF.addTarget(self, action: #selector(NamesTableViewCell.textFieldDidChange(_:)), for: .editingChanged)
    }
    
    func listenToFirstnameChanges(callback: @escaping (String)->()) {
        self.localCollbackFirstname = callback
    }
    
    func listenToGenderChanges(callback: @escaping (Character)->()) {
        self.localCollbackGender = callback
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if let callback = localCollbackFirstname {
            if let text = textField.text {
                callback(text)
            }
        }
    }
    
    @IBAction func firstnameValueChanges(_ sender: UITextField) {
        
    }
   
    @IBAction func genderValueChanges(_ sender: UISegmentedControl) {
        if let callback = localCollbackGender {
            var gender: Character = "M"
            if sender.selectedSegmentIndex == 1 {
                gender = "F"
            }
            callback(gender)
        }
    }
    
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
