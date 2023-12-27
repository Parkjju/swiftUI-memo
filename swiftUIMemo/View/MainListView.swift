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
                Button {
                    showComposer = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showComposer, content: {
                ComposeView()
            })
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
