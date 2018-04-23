//
//  PatientCell.swift
//  eye-exam
//
//  Created by Zac Saltzman on 4/20/18.
//  Copyright © 2018 Zac Saltzman. All rights reserved.
//

import UIKit

class PatientCell: UITableViewCell {
    
    //Outlets
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var scoreLbl: UILabel!
    
    func configureCell(patient: Patient) {
        self.nameLbl.text = patient.name
        self.scoreLbl.text = patient.score
    }

}
