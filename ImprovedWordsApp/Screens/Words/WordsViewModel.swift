//
//  WordsViewModel.swift
//  ImprovedWordsApp
//
//  Created by Svetlana Gladysheva on 11.06.2023.
//

import Foundation

@MainActor
final class WordsViewModel: ObservableObject {
    @Published var words: [Word] = []
    
    private let category: Category
    private let storage: Storage
    
    init(category: Category, storage: Storage) {
        self.category = category
        self.storage = storage
    }
    
    func onAppear() {
        updateWords()
    }
    
    func createWord(original: String, translation: String) {
        storage.createWord(original: original, translation: translation, category: category)
        updateWords()
    }
    
    func deleteWord(index: Int) {
        let word = words[index]
        storage.deleteWord(word)
        updateWords()
    }
    
    private func updateWords() {
        words = storage.fetchWords(category: category)
    }
}
