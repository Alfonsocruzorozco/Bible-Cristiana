//
//  DailyNeedsView.swift
//  Bible-Cristiana
//
//  Created by Alfonso Cruz Orozco on 28/04/26.
//

import SwiftUI

struct DailyNeedsView: View {
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
            // Fondo adaptado dinámicamente
            fondoGradiente.ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 20) {
                Text("¿Cómo te sientes hoy?")
                    .font(.system(size: 28, weight: .bold, design: .rounded))
                    // --- MODIFICADO ---
                    // .primary asegura que cambie entre negro y blanco puro
                    .foregroundColor(.primary)
                    .padding(.horizontal)
                    .padding(.top)

                List {
                    // 1. SABIDURÍA
                    NavigationLink(destination: EmotionDetailView(emocion: "Sabiduría", icono: "lightbulb.fill", color: .orange)) {
                        Label {
                            Text("Sabiduría").foregroundColor(.primary) // --- MODIFICADO ---
                        } icon: {
                            Image(systemName: "lightbulb.fill").foregroundColor(.orange)
                        }
                    }
                    .listRowBackground(isDarkMode ? Color(white: 0.15).opacity(0.6) : Color.white.opacity(0.6)) // --- NUEVO ---
                    
                    // 2. CONSUELO
                    NavigationLink(destination: EmotionDetailView(emocion: "Consuelo", icono: "heart.fill", color: .red)) {
                        Label {
                            Text("Consuelo").foregroundColor(.primary) // --- MODIFICADO ---
                        } icon: {
                            Image(systemName: "heart.fill").foregroundColor(.red)
                        }
                    }
                    .listRowBackground(isDarkMode ? Color(white: 0.15).opacity(0.6) : Color.white.opacity(0.6)) // --- NUEVO ---
                    
                    // 3. PAZ
                    NavigationLink(destination: EmotionDetailView(emocion: "Paz", icono: "leaf.fill", color: .green)) {
                        Label {
                            Text("Paz").foregroundColor(.primary) // --- MODIFICADO ---
                        } icon: {
                            Image(systemName: "leaf.fill").foregroundColor(.green)
                        }
                    }
                    .listRowBackground(isDarkMode ? Color(white: 0.15).opacity(0.6) : Color.white.opacity(0.6)) // --- NUEVO ---
                    
                    // 4. FORTALEZA
                    NavigationLink(destination: EmotionDetailView(emocion: "Fortaleza", icono: "bolt.fill", color: .blue)) {
                        Label {
                            Text("Fortaleza").foregroundColor(.primary) // --- MODIFICADO ---
                        } icon: {
                            Image(systemName: "bolt.fill").foregroundColor(.blue)
                        }
                    }
                    .listRowBackground(isDarkMode ? Color(white: 0.15).opacity(0.6) : Color.white.opacity(0.6)) // --- NUEVO ---
                }
                .scrollContentBackground(.hidden)
            }
        }
        .navigationTitle("Necesidades")
        .navigationBarTitleDisplayMode(.inline)
    }
}
