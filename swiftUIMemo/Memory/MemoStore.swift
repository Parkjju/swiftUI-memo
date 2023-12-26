//
//  MemoStore.swift
//  swiftUIMemo
//
//  Created by 박경준 on 12/26/23.
//

import Foundation

class MemoStore: ObservableObject {
    @Published var list: [Memo]
    
    init() {
        self.list = [
            Memo(content: "day1"),
            Memo(content: "day2", insertDate: Date.now.addingTimeInterval(3600 * -24)),
            Memo(content: "day3", insertDate: Date.now.addingTimeInterval(3600 * -48))
        ]
    }
    
    func insert(memo: String) {
        list.insert(Memo(content: memo), at: 0)
    }
    
    func update(memo: Memo?, content: String) {
        guard let memo = memo else { return }
        memo.content = content
    }
    
    func delete(memo: Memo) {
        list.removeAll { $0.id == memo.id }
    }
    
    func delete(set: IndexSet) {
        for index in set {
            list.remove(at: index)
        }
    }
}
