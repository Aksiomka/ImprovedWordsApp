//
//  WordsMigrationPlan.swift
//  ImprovedWordsApp
//
//  Created by Svetlana Gladysheva on 12.06.2023.
//

import Foundation
import SwiftData

enum WordsSchemaV1: VersionedSchema {
    static var versionIdentifier: String? = "1"
    
    static var models: [any PersistentModel.Type] {
        [Category.self, Word.self]
    }
    
    @Model
    final class Category {
        var name: String
        @Relationship(.cascade, inverse: \Word.category) var words: [Word] = []
        
        init(name: String) {
            self.name = name
        }
    }

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
}

enum WordsSchemaV2: VersionedSchema {
    static var versionIdentifier: String? = "2"
    
    static var models: [any PersistentModel.Type] {
        [Category.self, Word.self]
    }
    
    @Model
    final class Category {
        @Attribute(.unique) var name: String
        @Relationship(.cascade, inverse: \Word.category) var words: [Word] = []
        
        init(name: String) {
            self.name = name
        }
    }

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
}

enum WordsMigrationPlan: SchemaMigrationPlan {
    static var schemas: [any VersionedSchema.Type] {
        [WordsSchemaV1.self, WordsSchemaV2.self]
    }
    
    static var stages: [MigrationStage] {
        []
    }
    
    static let migrateV1toV2 = MigrationStage.custom(
        fromVersion: WordsSchemaV1.self,
        toVersion: WordsSchemaV2.self,
        willMigrate: { context in
            let categories = try? context.fetch(FetchDescriptor<WordsSchemaV1.Category>())
            // De-duplicate
            try? context.save()
        },
        didMigrate: nil
    )
}
