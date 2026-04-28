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
    @State private var selectedChapter = 1

    var body: some View {
        VStack {
            if !viewModel.availableChapters.isEmpty {
                Picker("Capítulo", selection: $selectedChapter) {
                    ForEach(viewModel.availableChapters, id: \.self) { cap in
                        Text("Capítulo \(cap)").tag(cap)
                    }
                }
                .pickerStyle(.menu)
                .onChange(of: selectedChapter) { _, newValue in
                    Task { await viewModel.getVerse(for: bookName, chapter: newValue) }
                }
            }

            ScrollView {
                if viewModel.isLoading {
                    ProgressView().padding(.top, 40)
                } else if let verse = viewModel.verse {
                    Text(verse.text)
                        .padding()
                        .font(.serif(size: 18)) // Asegúrate de tener esta fuente o usa .body
                } else if let error = viewModel.errorMessage {
                    Text(error).foregroundColor(.red).padding()
                }
            }
        }
        .navigationTitle(bookName)
        .onAppear {
            Task { await viewModel.getVerse(for: bookName, chapter: 1) }
        }
    }
}

extension Font {
    static func serif(size: CGFloat) -> Font {
        return .custom("Georgia", size: size)
    }
}
