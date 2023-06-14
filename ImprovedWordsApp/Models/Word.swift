//
//  Word.swift
//  ImprovedWordsApp
//
//  Created by Svetlana Gladysheva on 11.06.2023.
//

import SwiftData

@Model
final class Word {
    var original: String
    var translation: String
    var category: Category?
    
    init(original: String, translation: String) {
        self.original = original
        self.translation = translation
    }
}
