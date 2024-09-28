//
//  TaskListViewController.swift
//  BizList
//
//  Created by justin.bitancor on 9/27/24.
//

import CoreData
import Foundation
import UIKit


class TaskListViewController: UITableViewController {
    
    var taskItemListVM: TaskItemListViewModel = TaskItemListViewModel()
    var bizItemVM: BizItemViewModel?
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

//MARK: IBActions
    
    @IBAction func didTapAddButton(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Create New Task", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Task", style: .default) { [weak self] (action) in
            guard let self = self, let bizItemVM = self.bizItemVM, let taskTitle = textField.text else {
                print("No text entered")
                return
            }
            
            let taskItem = TaskItem(context: self.context)
            taskItem.title = taskTitle
            taskItem.isDone = false
            taskItem.parentBiz = bizItemVM.bizItem
            
            
            if self.context.hasChanges {
                self.saveContext()
            }
            
            self.taskItemListVM.items.append(TaskItemViewModel(task: taskItem))
            self.tableView.reloadData()
        }
        
        alert.addTextField { alertTextField in
            alertTextField.placeholder = "Please enter new Task"
            textField = alertTextField
        }
        
        alert.addAction(action)
        present(alert, animated: true)
    }
    
    @IBAction func didtapCloseButton(_ sender: UIBarButtonItem) {
        if context.hasChanges {
            self.saveContext()
        }
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
        cell.accessoryType = taskItem.isDone ? .checkmark : .none
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) else { return }
        var taskItem = self.taskItemListVM.taskItemAt(indexPath: indexPath)
        taskItem.task.isDone.toggle()
        
        cell.accessoryType = taskItem.isDone ? .checkmark : .none
        
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
        guard let bizItemVM = self.bizItemVM else { return }
        let request: NSFetchRequest<TaskItem> = TaskItem.fetchRequest()
        let predicate = NSPredicate(format: "parentBiz == %@", bizItemVM.bizItem)
        request.predicate = predicate
        do {
            let taskList = try self.context.fetch(request).map { TaskItemViewModel(task: $0) }
            self.taskItemListVM.items = taskList
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
}
