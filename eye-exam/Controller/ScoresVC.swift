//
//  ScoresVC.swift
//  eye-exam
//
//  Created by Zac Saltzman on 4/20/18.
//  Copyright © 2018 Zac Saltzman. All rights reserved.
//

import UIKit
import CoreData

let appDelegate = UIApplication.shared.delegate as? AppDelegate

class ScoresVC: UIViewController {
    
    //Outlets
    @IBOutlet weak var tableView: UITableView!
    
    var patients: [Patient] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.fetchCoreDataObjects()
        tableView.reloadData()
        print(patients)
    }
    
    func fetchCoreDataObjects() {
        self.fetch { (complete) in
            if complete {
                if patients.count >= 1 {
                    tableView.isHidden = false
                } else {
                    tableView.isHidden = true
                }
            }
        }
    }
    
    @IBAction func examBtnWasPressed(_ sender: Any) {
        guard let nameVC = storyboard?.instantiateViewController(withIdentifier: "NameVC") else { return }
        presentDetail(nameVC)
    }
    

}

extension ScoresVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return patients.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "patientCell") as? PatientCell else { return UITableViewCell() }
        let patient = patients[indexPath.row]
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.borderWidth = 1
        cell.clipsToBounds = true
        cell.configureCell(patient: patient)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 75.0
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .none
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .destructive, title: "DELETE") { (rowAction, indexPath) in
            self.removePatient(atIndexPath: indexPath)
            self.fetchCoreDataObjects()
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        
        deleteAction.backgroundColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
        return [deleteAction]
    }
    
}


extension ScoresVC {
    func fetch(completion: (_ complete: Bool) -> ()) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        
        let fetchRequest = NSFetchRequest<Patient>(entityName: "Patient")
        
        do {
            patients = try managedContext.fetch(fetchRequest)
            print("Successfully Fetched Data")
            completion(true)
        } catch {
            debugPrint("Could not fetch: \(error.localizedDescription)")
            completion(false)
        }
    }
    
    func removePatient(atIndexPath indexPath: IndexPath) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else { return }
        
        managedContext.delete(patients[indexPath.row])
        
        do {
            try managedContext.save()
            print("Successfully Removed Goal!")
        } catch {
            debugPrint("Could not remove: \(error.localizedDescription)")
        }
    }
}
