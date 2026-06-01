//
//  FavoritesView.swift
//  Bible-Cristiana
//
//  Created by Alfonso Cruz Orozco on 28/04/26.
//

import SwiftUI

struct FavoritesView: View {
    @EnvironmentObject var viewModel: DevotionalViewModel
    
    // --- NUEVO ---
    // Leemos el estado global del tema
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
                    Color(red: 255/255, green: 253/255, blue: 216/255),
                    Color(red: 228/255, green: 196/255, blue: 255/255)
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        }
    }
    
    var body: some View {
        ZStack {
            // Fondo dinámico adaptado
            fondoGradiente.ignoresSafeArea()
            
            VStack {
                if viewModel.listaFavoritos.isEmpty {
                    Text("No hay favoritos guardados")
                        .font(.system(.body, design: .serif))
                        .foregroundColor(.secondary)
                        .padding(.top, 100)
                    Spacer()
                } else {
                    List {
                        ForEach(viewModel.listaFavoritos) { dev in
                            VStack(alignment: .leading, spacing: 15) {
                                Text(dev.titulo)
                                    .font(.system(.headline, design: .serif))
                                    .bold()
                                    .foregroundColor(.primary) // --- MODIFICADO ---
                                
                                Text(dev.versiculo)
                                    .font(.caption.bold())
                                    // Azul más legible en fondos oscuros
                                    .foregroundColor(isDarkMode ? Color(red: 100/255, green: 170/255, blue: 255/255) : .blue)
                                
                                Text(dev.contenido)
                                    .font(.system(size: 17, design: .serif))
                                    .lineSpacing(6)
                                    .foregroundColor(.primary) // --- MODIFICADO ---
                                    .fixedSize(horizontal: false, vertical: true)
                            }
                            .padding()
                            // --- MODIFICADO ---
                            // Fondo translúcido adaptable para cada celda de favorito
                            .background(
                                isDarkMode
                                    ? Color(white: 0.15).opacity(0.7)
                                    : Color.white.opacity(0.6)
                            )
                            .cornerRadius(20)
                            .listRowBackground(Color.clear)
                            .listRowSeparator(.hidden)
                        }
                        .onDelete(perform: viewModel.eliminarDeFavoritos)
                    }
                    .listStyle(PlainListStyle())
                    .scrollContentBackground(.hidden)
                }
            }
        }
        .navigationTitle("Mis Favoritos")
        .toolbar { EditButton() }
    }
}
