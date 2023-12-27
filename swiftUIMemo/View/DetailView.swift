//
//  DetailView.swift
//  swiftUIMemo
//
//  Created by Jun on 2023/12/27.
//

import SwiftUI

struct DetailView: View {
    @ObservedObject var memo: MemoEntity
    
    @EnvironmentObject var manager: CoreDataManager
    
    @State private var showComposer = false
    @State private var showDeleteAlert = false
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            ScrollView {
                VStack {
                    HStack {
                        Text(memo.content ?? "")
                            .padding()
                        
                        Spacer()
                    }
                    
                    
                    Text(memo.insertDate ?? .now, style: .date)
                        .padding()
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                }
            }
        }
        .navigationTitle("메모 보기")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItemGroup(placement: .bottomBar) {
                Button {
                    showDeleteAlert = true
                } label: {
                    Image(systemName: "trash")
                }
                .foregroundStyle(.red)
                .alert("삭제 확인", isPresented: $showDeleteAlert) {
                    Button(role: .destructive) {
                        manager.delete(memo: memo)
                        dismiss()
                    } label: {
                        Text("삭제")
                    }
                } message: {
                    Text("메모를 삭제할까요?")
                }
                
                Button {
                    showComposer = true
                } label: {
                    Image(systemName: "square.and.pencil")
                }
            }
        }
        .sheet(isPresented: $showComposer, content: {
            ComposeView(memo: memo)
        })
    }
}

#Preview {
    NavigationStack {
        DetailView(memo: MemoEntity(context: CoreDataManager.shared.mainContext))
            .environmentObject(CoreDataManager.shared)
    }
}
