//
//  NameVC.swift
//  eye-exam
//
//  Created by Zac Saltzman on 4/20/18.
//  Copyright © 2018 Zac Saltzman. All rights reserved.
//

import UIKit

class NameVC: UIViewController, UITextFieldDelegate {
    //Outlets
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var takeExamBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextField.delegate = self
    }

    @IBAction func backBtnWasPressed(_ sender: Any) {
        dismissDetail()
    }
    
    @IBAction func takeExamBtnWasPressed(_ sender: Any) {
    }
    
    @IBAction func sightBtnWasPressed(_ sender: Any) {
        if nameTextField.text != "" {
            guard let examVC = storyboard?.instantiateViewController(withIdentifier: "ExamVC") as? ExamVC else { return }
            examVC.initData(name: nameTextField.text!)
            presentingViewController?.presentSecondaryDetail(examVC)
        }
    }
    
    @IBAction func colorBtnWasPressed(_ sender: Any) {
        if nameTextField.text != "" {
            guard let colorVC = storyboard?.instantiateViewController(withIdentifier: "ColorVC") as? ColorVC else { return }
            colorVC.initData(name: nameTextField.text!)
            presentingViewController?.presentSecondaryDetail(colorVC)
        }
    }
    
    
    
}
