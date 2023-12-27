//
//  CoreDataManager.swift
//  swiftUIMemo
//
//  Created by Jun on 2023/12/27.
//

import Foundation
import CoreData
import SwiftUI

class CoreDataManager: ObservableObject {
    
    static let shared = CoreDataManager()
    
    let container: NSPersistentContainer
    
    var mainContext: NSManagedObjectContext {
        return container.viewContext
    }

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "swiftUIMemo")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
    
    func saveContext() {
        if mainContext.hasChanges {
            do {
                try mainContext.save()
            } catch {
                print(error)
            }
        }
    }
    
    func addMemo(content: String) {
        let newMemo = MemoEntity(context: mainContext)
        newMemo.content = content
        newMemo.insertDate = Date.now
    }
    
    @FetchRequest(sortDescriptors: [SortDescriptor(\MemoEntity.insertDate, order: .reverse)])
    var memoList: FetchedResults<MemoEntity>
    
    func update(memo: MemoEntity?, content: String) {
        memo?.content = content
        saveContext()
    }
    
    func delete(memo: MemoEntity?) {
        if let memo = memo {
            mainContext.delete(memo)
            saveContext()
        }
    }
}
