//
//  MainListView.swift
//  swiftUIMemo
//
//  Created by 박경준 on 12/26/23.
//

import SwiftUI

struct MainListView: View {
    @EnvironmentObject var store: MemoStore
    var body: some View {
        NavigationView {
            List(store.list) { memo in
                VStack(alignment: .leading) {
                    Text(memo.content)
                        .font(.body)
                        .lineLimit(1)
                    
                    Text(memo.insertDate, style: .date)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }
            .navigationTitle("메모")
        }
    }
}

#Preview {
    MainListView()
        .environmentObject(MemoStore())
}
