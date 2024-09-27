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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bizlistVM = BizListViewModel()
        self.bizlistVM.items.append(BizItemViewModel(title: "Grocery Store"))
        self.bizlistVM.items.append(BizItemViewModel(title: "Drug Store"))
        self.bizlistVM.items.append(BizItemViewModel(title: "Coffee Shop"))
    }
    
// MARK: UITableView DataSource
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bizlistVM.items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BizItemCell") else {
            fatalError("BizItemCell not registered")
        }
        
        cell.textLabel?.text = bizlistVM.items[indexPath.row].title
        return cell
    }
}
