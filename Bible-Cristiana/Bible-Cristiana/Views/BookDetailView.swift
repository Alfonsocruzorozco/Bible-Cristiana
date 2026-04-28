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
            VStack(spacing: 20) {
                if viewModel.isLoading {
                    ProgressView("Cargando...")
                        .padding(.top, 50)
                } else if let verse = viewModel.verse {
                    Text(verse.text)
                        .font(.system(size: 18, weight: .regular, design: .serif))
                        .lineSpacing(6)
                        .padding()
                } else if let error = viewModel.errorMessage {
                    // Diseño de error elegante para que Apple no te rechace
                    VStack(spacing: 15) {
                        Image(systemName: "wifi.exclamationmark")
                            .font(.largeTitle)
                        Text(error)
                            .multilineTextAlignment(.center)
                    }
                    .foregroundColor(.gray)
                    .padding(.top, 50)
                }
            }
        }
        .navigationTitle(bookName)
        .onAppear {
            Task {
                await viewModel.getVerse(for: bookName)
            }
        }
    }
}
