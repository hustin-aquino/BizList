//
//  BizItemViewModel.swift
//  BizList
//
//  Created by justin.bitancor on 9/27/24.
//

import Foundation

struct BizListViewModel {
    var items: [BizItemViewModel] = [BizItemViewModel]()
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
    var bizItem: BizItem
}

extension BizItemViewModel {
    var name: String {
        return self.bizItem.name ?? ""
    }
}
