//
//  BookDetailView.swift
//  Bible-Cristiana
//
//  Created by Alfonso Cruz Orozco on 20/04/26.
//

import SwiftUI

struct BookDetailView: View {
    let bookName: String
    @StateObject private var viewModel = BibleViewModel()
    
    var body: some View {
        ScrollView {
            if viewModel.isLoading {
                ProgressView()
            } else if let verse = viewModel.verse {
                VStack(alignment: .leading, spacing: 15) {
                    Text(verse.text)
                        .font(.system(.body, design: .serif))
                        .lineSpacing(10)
                }
                .padding()
            }
        }
        .navigationTitle(bookName)
        .onAppear {
            // Por defecto, al entrar cargamos el capítulo 1 de ese libro
            Task {
                await viewModel.getVerse(for: "\(bookName) 1")
            }
        }
    }
}
