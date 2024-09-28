//
//  BizItemViewModel.swift
//  BizList
//
//  Created by justin.bitancor on 9/27/24.
//

import Foundation

struct BizListViewModel {
    var items: [BizItemViewModel]
}

extension BizListViewModel {
    init () {
        self.items = [BizItemViewModel]()
    }
}

extension BizListViewModel {
    func numberOfSection() -> Int {
        return 1
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        return self.items.count
    }
    
    func bizItemAtIndex(index: Int) -> BizItemViewModel {
        return self.items[index]
    }
}

struct BizItemViewModel {
    var title: String
    var tasks: [TaskViewModel] = []
    var isDone: Bool = false
}

extension BizItemViewModel {
    init (title: String) {
        self.title = title
        self.tasks = [TaskViewModel]()
    }
}

extension BizItemViewModel {
    func numberOfSection() -> Int {
        return 1
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        return self.tasks.count
    }
    
    func taskAtIndex(index: Int) -> TaskViewModel {
        return self.tasks[index]
    }
}

struct TaskViewModel {
    var taskItem: TaskItem
    var title: String
    var isDone: Bool = false
}

extension TaskViewModel {
    init (taskItem: TaskItem) {
        self.taskItem = taskItem
        self.title = taskItem.title
    }
}
