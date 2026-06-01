//
//  BibleReadView.swift
//  Bible-Cristiana
//
//  Created by Alfonso Cruz Orozco on 20/04/26.
//

import SwiftUI

struct BibleReadView: View {
    // --- NUEVO ---
    // Leemos el estado global del tema para adaptar el fondo y los textos
    @AppStorage("isDarkMode") private var isDarkMode = false

    // --- MODIFICADO ---
    // Propiedad calculada dinámica para cambiar el fondo según el modo
    var fondoGradiente: LinearGradient {
        if isDarkMode {
            return LinearGradient(
                gradient: Gradient(colors: [
                    Color(red: 25/255, green: 25/255, blue: 35/255), // Azul muy oscuro
                    Color(red: 35/255, green: 25/255, blue: 45/255)  // Morado muy oscuro
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        } else {
            return LinearGradient(
                gradient: Gradient(colors: [
                    Color(red: 255/255, green: 253/255, blue: 216/255), // Amarillo pastel
                    Color(red: 255/255, green: 218/255, blue: 238/255), // Rosa pastel
                    Color(red: 228/255, green: 196/255, blue: 255/255)  // Lila pastel
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        }
    }

    var body: some View {
        ZStack {
            // 1. Capa de fondo dinámica
            fondoGradiente
                .ignoresSafeArea()

            // 2. Capa de contenido (Tu lista combinada)
            List {
                // SECCIÓN ANTIGUO TESTAMENTO
                Section(header: Text("Antiguo Testamento")
                    // --- MODIFICADO ---
                    // .secondary se adapta mejor de manera nativa en ambos modos
                    .foregroundColor(.secondary)
                    .fontWeight(.bold)) {
                    
                    ForEach(BibleStructure.antiguoTestamento, id: \.self) { libro in
                        NavigationLink(destination: BookDetailView(bookName: libro)) {
                            Label(libro, systemImage: "book.closed")
                                // --- MODIFICADO ---
                                // .primary asegura legibilidad perfecta (Negro en claro / Blanco en oscuro)
                                .foregroundColor(.primary)
                        }
                        // --- NUEVO ---
                        // Asegura que el fondo de la celda individual sea translúcido y estético
                        .listRowBackground(
                            isDarkMode
                                ? Color(white: 0.15).opacity(0.6)
                                : Color.white.opacity(0.6)
                        )
                    }
                }
                
                // SECCIÓN NUEVO TESTAMENTO
                Section(header: Text("Nuevo Testamento")
                    // --- MODIFICADO ---
                    .foregroundColor(.secondary)
                    .fontWeight(.bold)) {
                    
                    ForEach(BibleStructure.nuevoTestamento, id: \.self) { libro in
                        NavigationLink(destination: BookDetailView(bookName: libro)) {
                            Label(libro, systemImage: "book.fill")
                                // --- MODIFICADO ---
                                // Azul nativo adaptado para que resalte correctamente en ambos fondos
                                .foregroundColor(.blue)
                        }
                        // --- NUEVO ---
                        // Asegura que el fondo de la celda individual sea translúcido y estético
                        .listRowBackground(
                            isDarkMode
                                ? Color(white: 0.15).opacity(0.6)
                                : Color.white.opacity(0.6)
                        )
                    }
                }
            }
            // 3. Hacemos la lista transparente para que se vea el gradiente
            .scrollContentBackground(.hidden)
        }
        .navigationTitle("Libros de la Biblia")
        .navigationBarTitleDisplayMode(.inline)
    }
}
