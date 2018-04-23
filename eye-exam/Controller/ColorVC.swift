//
//  ColorVC.swift
//  eye-exam
//
//  Created by Zac Saltzman on 4/20/18.
//  Copyright © 2018 Zac Saltzman. All rights reserved.
//

import UIKit
import CoreData

class ColorVC: UIViewController, UITextFieldDelegate {

    //Outlets
    @IBOutlet weak var cb1: UIImageView!
    @IBOutlet weak var cb2: UIImageView!
    @IBOutlet weak var cb3: UIImageView!
    @IBOutlet weak var cb4: UIImageView!
    @IBOutlet weak var cb5: UIImageView!
    @IBOutlet weak var cb6: UIImageView!
    @IBOutlet weak var answerTextField: UITextField!
    
    var name: String!
    var level: Int = 1
    var currentScore: String = "Color Blind - Negative"
    
    func initData(name: String) {
        self.name = name
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        answerTextField.delegate = self
        cb1.isHidden = false
        cb2.isHidden = true
        cb3.isHidden = true
        cb4.isHidden = true
        cb5.isHidden = true
        cb6.isHidden = true
    }

    @IBAction func cancelBtnWasPressed(_ sender: Any) {
        dismissDetail()
    }
    
    @IBAction func submitBtnWasPressed(_ sender: Any) {
        if self.answerTextField.text != "" {
            if self.level < 6 {
                evaluateAnswer()
                self.answerTextField.text = ""
                self.level = self.level + 1
            } else {
                evaluateAnswer()
                self.cb1.isHidden = false
                self.cb2.isHidden = true
                self.cb3.isHidden = true
                self.cb4.isHidden = true
                self.cb5.isHidden = true
                self.cb6.isHidden = true
                self.answerTextField.text = ""
                self.level = 1
                self.save { (complete) in
                    if complete {
                        self.currentScore = "Color Blind - Negative"
                        dismiss(animated: true, completion: nil)
                    }
                }
            }
        }
    }
    
    func evaluateAnswer() {
        if self.level == 1 {
            if self.answerTextField.text != "7" {
                print("Incorrect Answer")
                self.currentScore = "Color Blind - Positive"
            }
            self.cb2.isHidden = false
        } else if self.level == 2 {
            if self.answerTextField.text != "6" {
                print("Incorrect Answer")
                self.currentScore = "Color Blind - Positive"
            }
            self.cb3.isHidden = false
        } else if self.level == 3 {
            if self.answerTextField.text != "26" {
                print("Incorrect Answer")
                self.currentScore = "Color Blind - Positive"
            }
            self.cb4.isHidden = false
        } else if self.level == 4 {
            if self.answerTextField.text != "15" {
                print("Incorrect Answer")
                self.currentScore = "Color Blind - Positive"
            }
            self.cb5.isHidden = false
        } else if self.level == 5 {
            if self.answerTextField.text != "16" {
                print("Incorrect Answer")
                self.currentScore = "Color Blind - Positive"
            }
            self.cb6.isHidden = false
        } else if self.level == 6 {
            if self.answerTextField.text != "12" {
                print("Incorrect Answer")
                self.currentScore = "Color Blind - Positive"
            }
        }
    }
    
    func save(completion: (_ finished: Bool) -> ()) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        let patient = Patient(context: managedContext)
        
        patient.name = name
        patient.score = currentScore
        
        do {
            try managedContext.save()
            print("Successfully saved data")
            completion(true)
        } catch {
            debugPrint("Could not save: \(error.localizedDescription)")
            completion(false)
        }
    }
    
}
