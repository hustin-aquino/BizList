//
//  TaskListViewController.swift
//  BizList
//
//  Created by justin.bitancor on 9/27/24.
//

import Foundation
import UIKit

class TaskListViewController: UITableViewController {
    
    var bizItemVM: BizItemViewModel?

//MARK: IBActions
    
    @IBAction func didTapAddButton(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Task", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Create Task", style: .default) { [weak self] (action) in
            if let taskTitle = textField.text {
                self?.bizItemVM?.tasks.append(TaskViewModel(title: taskTitle))
                self?.tableView.reloadData()
            }
        }
        
        alert.addTextField { alertTextField in
            alertTextField.placeholder = "Please enter new Biz"
            textField = alertTextField
        }
        
        alert.addAction(action)
        present(alert, animated: true)
    }
    
    @IBAction func didtapCloseButton(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
// MARK: UITableView DataSource
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.bizItemVM?.numberOfSection() ?? 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.bizItemVM?.numberOfRowsInSection(section: section) ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TaskItemCell") else {
            fatalError("TaskItemCell not registered")
        }
        
        let bizItem = bizItemVM?.taskAtIndex(index: indexPath.row)
        cell.textLabel?.text = bizItem?.title
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) else { return }
        if  cell.accessoryType == .checkmark {
            cell.accessoryType = .none
        } else {
            cell.accessoryType = .checkmark
        }
        
        self.tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
