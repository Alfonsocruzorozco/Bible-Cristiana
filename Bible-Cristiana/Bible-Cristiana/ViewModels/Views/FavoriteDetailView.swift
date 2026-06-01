//
//  FavoriteDetailView.swift
//  Bible-Cristiana
//
//  Created by Alfonso Cruz Orozco on 29/04/26.
//

import SwiftUI

struct FavoriteDetailView: View {
    let devocional: Devocional
    
    // --- NUEVO ---
    // Leemos el estado global del tema para sincronizar el fondo
    @AppStorage("isDarkMode") private var isDarkMode = false
    
    // --- NUEVO ---
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
            // --- NUEVO ---
            // 1. Capa de fondo que unifica el estilo
            fondoGradiente
                .ignoresSafeArea()
            
            // 2. Contenido con ScrollView
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 20) {
                    Text(devocional.titulo)
                        .font(.system(size: 32, weight: .bold, design: .serif)) // Estilo consistente
                        .foregroundColor(.primary) // --- MODIFICADO ---
                    
                    Text(devocional.versiculo)
                        .font(.headline.bold())
                        // Ajuste sutil de azul en modo noche
                        .foregroundColor(isDarkMode ? Color(red: 100/255, green: 170/255, blue: 255/255) : .blue)
                    
                    Divider()
                        .padding(.vertical, 5)
                    
                    Text(devocional.contenido)
                        .font(.system(size: 20, weight: .regular, design: .serif)) // Tamaño cómodo de lectura
                        .lineSpacing(8)
                        .foregroundColor(.primary) // --- MODIFICADO ---
                }
                .padding(25)
                // --- NUEVO ---
                // Agregamos la hoja contenedora traslúcida para que mantenga la consistencia visual de tarjetas
                .background(
                    RoundedRectangle(cornerRadius: 35)
                        .fill(
                            isDarkMode
                                ? Color(white: 0.15).opacity(0.85) // Gris oscuro estético
                                : Color.white.opacity(0.85)        // Blanco traslúcido
                        )
                        .shadow(color: isDarkMode ? .white.opacity(0.02) : .black.opacity(0.08), radius: 10)
                )
                .padding()
            }
        }
        .navigationTitle("Detalle")
        .navigationBarTitleDisplayMode(.inline)
    }
}
