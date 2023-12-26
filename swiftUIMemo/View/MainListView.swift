//
//  MainListView.swift
//  swiftUIMemo
//
//  Created by 박경준 on 12/26/23.
//

import SwiftUI

struct MainListView: View {
    @EnvironmentObject var store: MemoStore
    
    @State private var showComposer: Bool = false
    
    var body: some View {
        NavigationView {
            List(store.list) { memo in
                MemoCell(memo: memo)
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
}

#Preview {
    MainListView()
        .environmentObject(MemoStore())
}
