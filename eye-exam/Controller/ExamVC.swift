//
//  ExamVC.swift
//  eye-exam
//
//  Created by Zac Saltzman on 4/20/18.
//  Copyright © 2018 Zac Saltzman. All rights reserved.
//

import UIKit
import CoreData

class ExamVC: UIViewController, UITextFieldDelegate {
    
    //Outlets
    @IBOutlet weak var examQuestion: UILabel!
    @IBOutlet weak var answerTextField: UITextField!
    @IBOutlet weak var submitBtn: UIButton!
    
    var name: String!
    var level: Int = 1
    var generatedQuestion: String = ""
    var answerScore: Int = 0
    var currentScore: String = "Sight - Blind"
    var letters: [String] = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
    
    func initData(name: String) {
        self.name = name
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        answerTextField.delegate = self
        generateQuestion()
    }
    
    @IBAction func cancelBtnWasPressed(_ sender: Any) {
        dismissDetail()
    }
    
    @IBAction func submitBtnWasPressed(_ sender: Any) {
        if self.examQuestion.text?.count == self.answerTextField.text?.count {
        if self.level <= 5 {
            changeScore()
            self.level = self.level + 1
            generateQuestion()
            self.answerScore = 0
            self.answerTextField.text = ""
            print(self.currentScore)
        } else {
            changeScore()
            self.level = 1
            self.answerScore = 0
            self.answerTextField.text = ""
            print(self.currentScore)
            self.save { (complete) in
                if complete {
                    self.currentScore = "Sight - Blind"
                    dismiss(animated: true, completion: nil)
                }
            }
        }
        } else {
            return
        }
    }
    
    func generateQuestion() {
        self.generatedQuestion = ""
        for _ in 1...self.level {
            let randomArrayIndex = Int(arc4random_uniform(25))
            let randomLetter = self.letters[randomArrayIndex]
            self.generatedQuestion = self.generatedQuestion + randomLetter
        }
        self.examQuestion.text = self.generatedQuestion
        if self.level == 1 {
            self.examQuestion.font = UIFont(name: self.examQuestion.font.fontName, size: 50)
        } else if self.level == 2 {
            self.examQuestion.font = UIFont(name: self.examQuestion.font.fontName, size: 44)
        } else if self.level == 3 {
            self.examQuestion.font = UIFont(name: self.examQuestion.font.fontName, size: 36)
        } else if self.level == 4 {
            self.examQuestion.font = UIFont(name: self.examQuestion.font.fontName, size: 29)
        } else if self.level == 5 {
            self.examQuestion.font = UIFont(name: self.examQuestion.font.fontName, size: 22)
        } else if self.level == 6 {
            self.examQuestion.font = UIFont(name: self.examQuestion.font.fontName, size: 14)
        }
    }
    
    func evaluateAnswer() {
        self.answerScore = 0
        let unformattedAnswer = self.answerTextField.text
        let formattedAnswer = unformattedAnswer?.uppercased()

            for index in 1...self.level {
                let formattedIndex = formattedAnswer?.index((formattedAnswer?.startIndex)!, offsetBy: index - 1)
                let questionIndex = self.examQuestion.text?.index((self.examQuestion.text?.startIndex)!, offsetBy: index - 1)
                if formattedAnswer![formattedIndex!] == self.examQuestion.text![questionIndex!] {
                    self.answerScore = self.answerScore + 1
                } else {
                    print("Incorrect Answer")
                }
            }
    }
    
    func changeScore() {
        evaluateAnswer()
        if self.level == 1 {
            if self.answerScore == 1 {
                self.currentScore = "Sight - 20/70"
            }
        } else if self.level == 2 {
            if self.answerScore >= 1 {
                self.currentScore = "Sight - 20/60"
            }
        } else if self.level == 3 {
            if self.answerScore >= 2 {
                self.currentScore = "Sight - 20/50"
            }
        } else if self.level == 4 {
            if self.answerScore >= 2 {
                self.currentScore = "Sight - 20/40"
            }
        } else if self.level == 5 {
            if self.answerScore >= 3 {
                self.currentScore = "Sight - 20/30"
            }
        } else if self.level == 6 {
            if self.answerScore >= 3 {
                self.currentScore = "Sight - 20/20"
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
