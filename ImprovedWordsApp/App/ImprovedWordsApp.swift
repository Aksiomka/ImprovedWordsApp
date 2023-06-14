//
//  ImprovedWordsApp.swift
//  ImprovedWordsApp
//
//  Created by Svetlana Gladysheva on 11.06.2023.
//

import SwiftUI

@main
struct ImprovedWordsApp: App {
    var body: some Scene {
        WindowGroup {
            CategoriesView(viewModel: CategoriesViewModel(storage: Storage.shared))
        }
    }
}
