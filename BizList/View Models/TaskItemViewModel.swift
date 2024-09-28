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
    var task: TaskItem
}

extension TaskItemViewModel {
    var title: String {
        return task.title ?? ""
    }
    
    var isDone: Bool {
        return task.isDone
    }
}
