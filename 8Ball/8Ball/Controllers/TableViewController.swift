//
//  TableViewController.swift
//  8Ball
//
//  Created by Kolya Tatarenko on 29.01.2022.
//

import UIKit

class TableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    
    func setupUI(){
        title = "Settings"
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewHardcoreAnswer))
        
        navigationItem.rightBarButtonItem = addButton
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return HardcoreAnswers.shared.myAnswers.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        var customCell = cell.defaultContentConfiguration()
        
        customCell.text = HardcoreAnswers.shared.myAnswers[indexPath.row]
        
        cell.contentConfiguration = customCell
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            HardcoreAnswers.shared.myAnswers.remove(at: indexPath.row)
            HardcoreAnswers.shared.saveAnswer(answer: nil)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
        }    
    }
    
    
    @objc func addNewHardcoreAnswer() {
        let alert = UIAlertController(title: "Add new answer", message: nil, preferredStyle: .alert)
        
        let saveButton = UIAlertAction(title: "Add", style: .destructive) { _ in
            
            HardcoreAnswers.shared.saveAnswer(answer: alert.textFields?[0].text)
            
            self.tableView.reloadData()
        }
        
        alert.addTextField { answerTF in
            answerTF.placeholder = "Enter your answer"
        }
        
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel)
        
        alert.addAction(saveButton)
        alert.addAction(cancelButton)
        
        present(alert, animated: true)
    }
}
