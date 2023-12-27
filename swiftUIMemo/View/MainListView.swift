//
//  MainListView.swift
//  swiftUIMemo
//
//  Created by 박경준 on 12/26/23.
//

import SwiftUI

struct MainListView: View {
    @EnvironmentObject var manager: CoreDataManager
    
    @FetchRequest(sortDescriptors: [SortDescriptor(\MemoEntity.insertDate, order: .reverse)])
    var memoList: FetchedResults<MemoEntity>
    
    @State private var keyword = ""
    @State private var sortByDateDesc = true
    
    @State private var showComposer: Bool = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(memoList) { memo in
                    NavigationLink {
                        DetailView(memo: memo)
                    } label: {
                        MemoCell(memo: memo)
                    }
                }
                .onDelete(perform: { indexSet in
                    delete(set: indexSet)
                })
            }
            .navigationTitle("메모")
            .toolbar {
                HStack {
                    Button {
                        showComposer = true
                    } label: {
                        Image(systemName: "plus")
                    }
                    
                    Button {
                        sortByDateDesc.toggle()
                    } label: {
                        Image(systemName: "arrow.up.arrow.down")
                    }
                }
            }
            .sheet(isPresented: $showComposer, content: {
                ComposeView()
            })
            .searchable(text: $keyword, prompt: "내용을 검색합니다")
            .onChange(of: keyword) { oldValue, newValue in
                if keyword.isEmpty {
                    memoList.nsPredicate = nil
                } else {
                    memoList.nsPredicate = NSPredicate(format: "content CONTAINS[c] %@", newValue)
                }
            }
            .onChange(of: sortByDateDesc) { oldValue, newValue in
                if newValue {
                    memoList.sortDescriptors = [SortDescriptor(\MemoEntity.insertDate, order: .reverse)]
                } else {
                    memoList.sortDescriptors = [SortDescriptor(\MemoEntity.insertDate, order: .forward)]
                }
            }
        }
    }
    
    func delete(set: IndexSet) {
        for index in set {
            manager.delete(memo: memoList[index])
        }
    }
}

#Preview {
    MainListView()
        .environmentObject(CoreDataManager.shared)
        .environment(\.managedObjectContext, CoreDataManager.shared.mainContext)
}
