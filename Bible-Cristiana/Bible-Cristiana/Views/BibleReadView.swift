//
//  BibleReadView.swift
//  Bible-Cristiana
//
//  Created by Alfonso Cruz Orozco on 20/04/26.
//

import SwiftUI

struct BibleReadView: View {
    @StateObject private var viewModel = BibleViewModel()
    @State private var passageToSearch: String = ""

    var body: some View {
        VStack {
            TextField("Buscar pasaje (ej: John 3:16)", text: $passageToSearch)
                .textFieldStyle(.roundedBorder)
                .padding()

            Button("Buscar en Reina Valera") {
                Task {
                    await viewModel.getVerse(for: passageToSearch)
                }
            }
            .buttonStyle(.borderedProminent)

            if let verse = viewModel.verse {
                ScrollView {
                    Text(verse.text)
                        .padding()
                }
            }
            Spacer()
        }
        .navigationTitle("Lectura")
    }
}
