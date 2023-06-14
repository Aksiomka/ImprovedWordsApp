//
//  WordsView.swift
//  ImprovedWordsApp
//
//  Created by Svetlana Gladysheva on 11.06.2023.
//

import SwiftUI
import SwiftData

struct WordsView: View {
    @ObservedObject var viewModel: WordsViewModel
    
    @State private var original = ""
    @State private var translation = ""
    
    var body: some View {
        VStack {
            List {
                ForEach(viewModel.words, id: \.id) { word in
                    VStack {
                        Text("\(word.original)")
                        Text("\(word.translation)")
                    }
                }.onDelete(perform: { indexSet in
                    for index in indexSet {
                        viewModel.deleteWord(index: index)
                    }
                })
            }
            TextField("Enter original", text: $original)
            TextField("Enter translation", text: $translation)
            Button(action: {
                viewModel.createWord(original: original, translation: translation)
            }, label: {
                Text("Add word")
            })
        }
        .navigationBarTitle(Text("Words"), displayMode: .inline)
    }
}
