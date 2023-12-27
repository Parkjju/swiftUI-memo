//
//  DetailView.swift
//  swiftUIMemo
//
//  Created by Jun on 2023/12/27.
//

import SwiftUI

struct DetailView: View {
    @ObservedObject var memo: Memo
    
    @EnvironmentObject var store: MemoStore
    
    var body: some View {
        VStack {
            ScrollView {
                VStack {
                    HStack {
                        Text(memo.content)
                            .padding()
                        
                        Spacer()
                    }
                    
                    
                    Text(memo.insertDate, style: .date)
                        .padding()
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                }
            }
        }
        .navigationTitle("메모 보기")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    DetailView(memo: Memo(content: "Hello"))
        .environmentObject(MemoStore())
}
