//
//  swiftUIMemoApp.swift
//  swiftUIMemo
//
//  Created by 박경준 on 12/26/23.
//

import SwiftUI

@main
struct swiftUIMemoApp: App {
    @StateObject var store = MemoStore()
    let manager = CoreDataManager.shared

    var body: some Scene {
        WindowGroup {
            MainListView()
                .environment(\.managedObjectContext, manager.mainContext)
                .environmentObject(store)
        }
    }
}
