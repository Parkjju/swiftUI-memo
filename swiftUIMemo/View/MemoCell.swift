//
//  MemoCell.swift
//  swiftUIMemo
//
//  Created by 박경준 on 12/27/23.
//

import Foundation
import SwiftUI

struct MemoCell: View {
    @ObservedObject var memo: MemoEntity
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(memo.content ?? "")
                .font(.body)
                .lineLimit(1)
            
            Text(memo.insertDate ?? .now, style: .date)
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }
}

#Preview {
    MemoCell(memo: MemoEntity(context: CoreDataManager.shared.mainContext))
}
