//
//  BizListTableViewController.swift
//  BizList
//
//  Created by justin.bitancor on 9/27/24.
//

import Foundation
import UIKit

class BizListTableViewController: UITableViewController {
    
    private var bizlistVM: BizListViewModel!
    
//MARK: IBActions
    
    @IBAction func didTapAddButton(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Create New Biz", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Biz", style: .default) { [weak self] (action) in
            if let bizTitle = textField.text {
                self?.bizlistVM.items.append(BizItemViewModel(title: bizTitle))
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bizlistVM = BizListViewModel()
        self.bizlistVM.items.append(BizItemViewModel(title: "Grocery Store"))
        self.bizlistVM.items.append(BizItemViewModel(title: "Drug Store"))
        self.bizlistVM.items.append(BizItemViewModel(title: "Coffee Shop"))
    }
    
// MARK: UITableView DataSource
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.bizlistVM.numberOfSection()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.bizlistVM.numberOfRowsInSection(section: section)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BizItemCell") else {
            fatalError("BizItemCell not registered")
        }
        
        let bizItem = bizlistVM.bizItemAtIndex(index: indexPath.row)
        cell.textLabel?.text = bizItem.title
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "ShowBizTaskList", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowBizTaskList" {
            self.prepareSegueForTaskList(with: segue)
        }
    }
    
    private func prepareSegueForTaskList(with segue: UIStoryboardSegue) {
        guard let indexPath = self.tableView.indexPathForSelectedRow else {
            print("No Found Selected Row")
            return
        }
        
        guard let navigationController = segue.destination as? UINavigationController else {
            fatalError("Error in Getting Navigation Controller")
        }
        
        guard let vc = navigationController.viewControllers.first as? TaskListViewController else {
            fatalError("No ViewController found")
        }
        
        var bizItem = bizlistVM.bizItemAtIndex(index: indexPath.row)
        bizItem.tasks.append(TaskViewModel(title: "Task 1"))
        bizItem.tasks.append(TaskViewModel(title: "Task 2"))
        bizItem.tasks.append(TaskViewModel(title: "Task 3"))
        bizItem.tasks.append(TaskViewModel(title: "Task 4"))
        vc.bizItem = bizItem
    }
}
