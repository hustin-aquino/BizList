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

struct BizItemViewModel {
    var title: String
    var isDone: Bool = false
}
