//
//  Category.swift
//  ImprovedWordsApp
//
//  Created by Svetlana Gladysheva on 11.06.2023.
//

import SwiftData

@Model
final class Category {
    @Attribute(.unique) var name: String
    @Relationship(.cascade, inverse: \Word.category) var words: [Word] = []
    
    init(name: String) {
        self.name = name
    }
}
