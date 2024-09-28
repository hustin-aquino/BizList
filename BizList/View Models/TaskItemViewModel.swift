//
//  TaskItemViewModel.swift
//  BizList
//
//  Created by justin.bitancor on 9/28/24.
//

import Foundation

struct TaskItemListViewModel {
    var items: [TaskItemViewModel] = [TaskItemViewModel]()
}

extension TaskItemListViewModel {
    init? (taskItems: [TaskItem]) {
        let itemList = taskItems.map { $0.convertToTaskItemViewModel() }
        self.items = itemList
    }
}

extension TaskItemListViewModel {
    
    func numberOfSections() -> Int {
        return 1
    }
    
    func numberOfRowsInSection(_ section: Int) -> Int {
        return self.items.count
    }
    
    func taskItemAt(indexPath: IndexPath) -> TaskItemViewModel {
        return self.items[indexPath.row]
    }
}

struct TaskItemViewModel {
    var title: String
    var isDone: Bool
}

extension TaskItem {
    func convertToTaskItemViewModel() -> TaskItemViewModel {
        let item = TaskItemViewModel(title: self.title ?? "", isDone: self.isDone)
        print("Item: \(item)")
        return item
    }
}
