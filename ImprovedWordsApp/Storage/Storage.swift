//
//  Storage.swift
//  ImprovedWordsApp
//
//  Created by Svetlana Gladysheva on 11.06.2023.
//

import Foundation
import SwiftData

@MainActor
final class Storage {
    private let modelContainer: ModelContainer?
    private var modelContext: ModelContext?
    
    static let shared = Storage()
    
    init() {
        modelContainer = try? ModelContainer(for: [Category.self, Word.self])
        modelContext = modelContainer?.mainContext
    }
    
    func fetchCategories() -> [Category] {
        let modelContext = modelContainer?.mainContext
        let fetchDescriptor = FetchDescriptor(sortBy: [SortDescriptor(\Category.name)])
        let categories = try? modelContext?.fetch(fetchDescriptor)
        return categories ?? []
    }
    
    func createCategory(name: String) {
        let category = Category(name: name)
        modelContext?.insert(category)
    }
    
    func deleteCategory(_ category: Category) {
        modelContext?.delete(category)
    }
    
    func fetchWords(category: Category) -> [Word] {
        let categoryName = category.name
        let fetchDescriptor: FetchDescriptor<Word> = FetchDescriptor(
            predicate: #Predicate { $0.category?.name == categoryName },
            sortBy: [SortDescriptor(\.original)]
        )
        let words = try? modelContext?.fetch(fetchDescriptor)
        return words ?? []
    }
    
    func createWord(original: String, translation: String, category: Category) {
        let word = Word(original: original, translation: translation)
        word.category = category
        modelContext?.insert(word)
    }
    
    func deleteWord(_ word: Word) {
        modelContext?.delete(word)
    }
}
