//
//  TaskListViewController.swift
//  BizList
//
//  Created by justin.bitancor on 9/27/24.
//

import Foundation
import UIKit
import CoreData

class TaskListViewController: UITableViewController {
    
    var taskItemListVM: TaskItemListViewModel = TaskItemListViewModel()
    var bizItemVM: BizItemViewModel?
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

//MARK: IBActions
    
    @IBAction func didTapAddButton(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Task", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Create Task", style: .default) { [weak self] (action) in
            guard let self = self, let taskTitle = textField.text else {    
                print("No text entered")
                return
            }
            
            let taskItem = TaskItem(context: self.context)
            taskItem.title = taskTitle
            taskItem.isDone = false
            
            if self.context.hasChanges {
                self.saveContext()
            }
            
            self.taskItemListVM.items.append(taskItem.convertToTaskItemViewModel())
            self.tableView.reloadData()
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
        self.loadTaskItems()
    }
    
// MARK: UITableView DataSource
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.taskItemListVM.numberOfSections()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.taskItemListVM.numberOfRowsInSection(section)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TaskItemCell") else {
            fatalError("TaskItemCell not registered")
        }
        
        let taskItem = self.taskItemListVM.taskItemAt(indexPath: indexPath)
        cell.textLabel?.text = taskItem.title
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

//MARK: CoreData Functions
extension TaskListViewController {
    func saveContext() {
        do {
            try self.context.save()
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
    
    func loadTaskItems() {
        let request: NSFetchRequest<TaskItem> = TaskItem.fetchRequest()
        do {
            let taskList = try self.context.fetch(request).map { $0.convertToTaskItemViewModel() }
            self.taskItemListVM.items = taskList
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
}
