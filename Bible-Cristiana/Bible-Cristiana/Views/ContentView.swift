//
//  ContentView.swift
//  Bible-Cristiana
//
//  Created by Alfonso Cruz Orozco on 20/04/26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack { // Usamos NavigationStack que es lo más moderno
            List {
                // SECCIÓN DE BIBLIA
                NavigationLink(destination: BibleReadView()) {
                    HStack {
                        Image(systemName: "book.fill")
                            .foregroundColor(.blue)
                        Text("Biblia Reina Valera")
                            .font(.headline)
                    }
                    .padding(.vertical, 10)
                }
                
                // SECCIÓN DE DEVOCIONALES
                NavigationLink(destination: DevotionalsView()) {
                    HStack {
                        Image(systemName: "heart.text.square.fill")
                            .foregroundColor(.red)
                        Text("Devocionales Diarios")
                            .font(.headline)
                    }
                    .padding(.vertical, 10)
                }
            }
            .navigationTitle("Mi Biblia")
        }
    }
}
