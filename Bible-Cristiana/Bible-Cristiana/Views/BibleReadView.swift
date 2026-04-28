//
//  BibleReadView.swift
//  Bible-Cristiana
//
//  Created by Alfonso Cruz Orozco on 20/04/26.
//

import SwiftUI

struct BibleReadView: View {
    // Definimos el mismo gradiente para mantener la coherencia visual
    let fondoGradiente = LinearGradient(
        gradient: Gradient(colors: [
            Color(red: 255/255, green: 253/255, blue: 216/255), // Amarillo pastel
            Color(red: 255/255, green: 218/255, blue: 238/255), // Rosa pastel
            Color(red: 228/255, green: 196/255, blue: 255/255)  // Lila pastel
        ]),
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )

    var body: some View {
        ZStack {
            // 1. Capa de fondo
            fondoGradiente
                .ignoresSafeArea()

            // 2. Capa de contenido (Tu lista combinada)
            List {
                // SECCIÓN ANTIGUO TESTAMENTO
                Section(header: Text("Antiguo Testamento")
                    .foregroundColor(.gray)
                    .fontWeight(.bold)) {
                    
                    ForEach(BibleStructure.antiguoTestamento, id: \.self) { libro in
                        NavigationLink(destination: BookDetailView(bookName: libro)) {
                            Label(libro, systemImage: "book.closed")
                                .foregroundColor(.primary)
                        }
                    }
                }
                
                // SECCIÓN NUEVO TESTAMENTO
                Section(header: Text("Nuevo Testamento")
                    .foregroundColor(.gray)
                    .fontWeight(.bold)) {
                    
                    ForEach(BibleStructure.nuevoTestamento, id: \.self) { libro in
                        NavigationLink(destination: BookDetailView(bookName: libro)) {
                            Label(libro, systemImage: "book.fill")
                                .foregroundColor(.blue)
                        }
                    }
                }
            }
            // 3. Hacemos la lista transparente para que se vea el gradiente
            .scrollContentBackground(.hidden)
        }
        .navigationTitle("Libros de la Biblia")
        // Opcional: para que el título se vea mejor con el fondo
        .navigationBarTitleDisplayMode(.inline)
    }
}
