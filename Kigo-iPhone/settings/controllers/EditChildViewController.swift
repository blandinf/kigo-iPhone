//
//  EditChildViewController.swift
//  Kigo-iPhone
//
//  Created by Florian on 13/05/2020.
//  Copyright © 2020 blandinf. All rights reserved.
//

import UIKit

class EditChildViewController: UIViewController {
    var child: Child?
    @IBOutlet weak var birthdate: UIDatePicker!
    @IBOutlet weak var firstnameTF: UITextField!
    @IBOutlet weak var gender: UISegmentedControl!
    @IBOutlet weak var txtDatePicker: UITextField!
    let formatter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialization()
    }
    
    func initialization () {
        formatter.dateFormat = "dd/MM/yyyy"
        
        firstnameTF.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: firstnameTF.frame.height))
        firstnameTF.leftViewMode = .always
        txtDatePicker.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: firstnameTF.frame.height))
        txtDatePicker.leftViewMode = .always
        
        if let child = child {
            firstnameTF.text = child.firstname
            gender.selectedSegmentIndex = child.gender == "H" ? 0 : 1
            birthdate.date = child.birthdate
            txtDatePicker.text = formatter.string(from: birthdate.date)
        }
        showDatePicker()
        txtDatePicker.becomeFirstResponder()
    }
    
    func showDatePicker () {
        //Formate Date
        birthdate.datePickerMode = .date

        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()

        let doneButton = UIBarButtonItem(title: "Valider", style: .plain, target: self, action: #selector(donedatePicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Annuler", style: .plain, target: self, action: #selector(cancelDatePicker));

        toolbar.setItems([cancelButton,spaceButton,doneButton], animated: false)

        txtDatePicker.inputAccessoryView = toolbar
        txtDatePicker.inputView = birthdate
    }

     @objc func donedatePicker () {
       txtDatePicker.text = formatter.string(from: birthdate.date)
       self.view.endEditing(true)
     }

     @objc func cancelDatePicker () {
        self.view.endEditing(true)
     }
    
    @IBAction func back(_ sender: Any) {
        cancel(sender)
    }
    
    @IBAction func update(_ sender: Any) {
        if var child = child,
            let firstname = firstnameTF.text {
            child.firstname = firstname
            child.gender = gender.selectedSegmentIndex == 0 ? "H" : "F"
            child.birthdate = birthdate.date
            ChildrenService.updateChild(child: child)
            navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func cancel(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}
