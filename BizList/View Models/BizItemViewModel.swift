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
}

