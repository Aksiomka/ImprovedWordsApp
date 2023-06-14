//
//  CategoriesViewModel.swift
//  ImprovedWordsApp
//
//  Created by Svetlana Gladysheva on 11.06.2023.
//

import Foundation

@MainActor
final class CategoriesViewModel: ObservableObject {
    @Published var categories: [Category] = []
    
    private let storage: Storage
    
    init(storage: Storage) {
        self.storage = storage
    }
    
    func onAppear() {
        updateCategories()
    }
    
    func createCategory(name: String) {
        storage.createCategory(name: name)
        updateCategories()
    }
    
    func deleteCategory(index: Int) {
        let category = categories[index]
        storage.deleteCategory(category)
        updateCategories()
    }
    
    private func updateCategories() {
        categories = storage.fetchCategories()
    }
}
