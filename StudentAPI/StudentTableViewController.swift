//
//  StudentTableViewController.swift
//  StudentAPI
//
//  Created by Michael Montoya on 10/19/16.
//  Copyright © 2016 Michael Montoya. All rights reserved.
//

import UIKit

class StudentTableViewController: UITableViewController {
    
    
    //==================================================
    // MARK: Properties
    //==================================================
    
    @IBOutlet weak var nameTextField: UITextField!
    
    var students = [Student]() {
        
        didSet{
            
            DispatchQueue.main.async {
                
                self.tableView.reloadData()
                
            }
        }
    }
    
    
    //==================================================
    // MARK: General
    //==================================================
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      fetchStudents()
        
    }
    
    
    //==================================================
    // MARK: Methods
    //==================================================
    
    private func fetchStudents() {
        
        StudentController.fetchStudents { (students) in
            
            self.students = students
            
        }
        
    }
    
    // MARK: - Table view data source
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return students.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "studentCell", for: indexPath)
        
        // Configure the cell...
        let student = students[indexPath.row]
        
        cell.textLabel?.text = student.name
        
        return cell
    }
    
    
    
    
//    // Override to support editing the table view.
//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            // Delete the row from the data source
//            tableView.deleteRows(at: [indexPath], with: .fade)
//        }
//        
//        
//        /*
//         // MARK: - Navigation
//         
//         // In a storyboard-based application, you will often want to do a little preparation before navigation
//         override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//         // Get the new view controller using segue.destinationViewController.
//         // Pass the selected object to the new view controller.
//         }
//         */
//        
//    }
    
    @IBAction func addButtonTapped(_ sender: UIButton) {
        
        guard let name = nameTextField.text , name.characters.count > 0
            else { return }
        
        StudentController.send(studentWithName: name) { (success) in
            guard success else { return }
            
            DispatchQueue.main.async {
                
                self.nameTextField.text = ""
                self.nameTextField.resignFirstResponder()
                
                self.fetchStudents()
            }
        }
    }
}
