//
//  ComposeView.swift
//  swiftUIMemo
//
//  Created by Jun on 2023/12/27.
//

import SwiftUI

struct ComposeView: View {
    @EnvironmentObject var store: MemoStore
    @Environment(\.dismiss) var dismiss
            
    @State private var content: String = ""
    
    var memo: Memo? = nil
    
    var body: some View {
        NavigationView {
            VStack {
                TextEditor(text: $content)
                    .padding()
                    .onAppear {
                        if let memo = memo {
                            content = memo.content
                        }
                    }
            }
            .navigationTitle(memo != nil ? "메모 편집" : "새 메모")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItemGroup(placement: .topBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Text("취소")
                    }
                }
                
                ToolbarItemGroup(placement: .topBarTrailing) {
                    Button {
                        if let memo = memo {
                            store.update(memo: memo, content: content)
                        } else {
                            store.insert(memo: content)
                        }
                        dismiss()
                    } label: {
                        Text("저장")
                    }
                }
            }
        }
    }
}

#Preview {
    ComposeView()
        .environmentObject(MemoStore())
}
