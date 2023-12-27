//
//  ComposeView.swift
//  swiftUIMemo
//
//  Created by Jun on 2023/12/27.
//

import SwiftUI

struct ComposeView: View {
    @EnvironmentObject var manager: CoreDataManager
    @Environment(\.dismiss) var dismiss
            
    @State private var content: String = ""
    
    var memo: MemoEntity? = nil
    
    var body: some View {
        NavigationView {
            VStack {
                TextEditor(text: $content)
                    .padding()
                    .onAppear {
                        if let memo = memo?.content {
                            content = memo
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
                            manager.update(memo: memo, content: content)
                        } else {
                            manager.addMemo(content: content)
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
        .environmentObject(CoreDataManager.shared)
}
