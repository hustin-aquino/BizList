//
//  BizListTableViewController.swift
//  BizList
//
//  Created by justin.bitancor on 9/27/24.
//

import CoreData
import Foundation
import UIKit


class BizListTableViewController: UITableViewController {
    
    private var bizlistVM: BizListViewModel = BizListViewModel()
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
//MARK: IBActions
    
    @IBAction func didTapAddButton(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Create New Biz", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Biz", style: .default) { [weak self] (action) in
            guard let self = self, let bizTitle = textField.text else {
                print("No text entered")
                return
            }
            
            let bizItem = BizItem(context: self.context)
            bizItem.name = bizTitle
            
            if self.context.hasChanges {
                self.saveContext()
            }
            
            self.bizlistVM.items.append(BizItemViewModel(bizItem: bizItem))
            self.tableView.reloadData()
        }
        
        alert.addTextField { alertTextField in
            alertTextField.placeholder = "Please enter new Biz"
            textField = alertTextField
        }
        
        alert.addAction(action)
        present(alert, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadBizItems()
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
        cell.textLabel?.text = bizItem.name
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
        
        vc.bizItemVM = bizlistVM.bizItemAtIndex(index: indexPath.row)
        self.tableView.deselectRow(at: indexPath, animated: true)
    }
}

//MARK: CoreData Functions
extension BizListTableViewController {
    func saveContext() {
        do {
            try self.context.save()
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
    
    func loadBizItems() {
        let request: NSFetchRequest<BizItem> = BizItem.fetchRequest()
        do {
            let bizList = try self.context.fetch(request).map { BizItemViewModel(bizItem: $0) }
            self.bizlistVM.items = bizList
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
}

