//
//  CategoriesView.swift
//  ImprovedWordsApp
//
//  Created by Svetlana Gladysheva on 11.06.2023.
//

import SwiftUI
import SwiftData

struct CategoriesView: View {
    @ObservedObject var viewModel: CategoriesViewModel
    
    @State private var categoryName = ""
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(viewModel.categories, id: \.id) { category in
                        NavigationLink(
                            category.name,
                            destination: {
                                WordsView(viewModel: WordsViewModel(category: category, storage: Storage.shared))
                            }
                        )
                    }.onDelete(perform: { indexSet in
                        for index in indexSet {
                            viewModel.deleteCategory(index: index)
                        }
                    })
                }
                TextField("Enter category name", text: $categoryName)
                Button(action: {
                    viewModel.createCategory(name: categoryName)
                }, label: {
                    Text("Add category")
                })
            }
            .onAppear {
                viewModel.onAppear()
            }
        }
    }
}
