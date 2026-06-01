//
//  DevotionalsView.swift
//  Bible-Cristiana
//
//  Created by Alfonso Cruz Orozco on 20/04/26.
//

import SwiftUI

struct DevotionalsView: View {
    @EnvironmentObject var viewModel: DevotionalViewModel
    
    // --- NUEVO ---
    // Leemos el estado global del tema desde la app
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
            
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 25) {
                    HStack(alignment: .top) {
                        VStack(alignment: .leading, spacing: 5) {
                            Text(formatearFecha(viewModel.devocionalDelDia.fecha).uppercased())
                                .font(.caption.bold())
                                .foregroundColor(.secondary)
                                .tracking(1)
                            
                            Text(viewModel.devocionalDelDia.titulo)
                                .font(.system(size: 34, weight: .bold, design: .serif))
                                .foregroundColor(.primary) // --- MODIFICADO ---
                        }
                        Spacer()
                        
                        // BOTÓN DE FAVORITOS
                        Button(action: { withAnimation(.spring()) { viewModel.toggleFavorito(para: viewModel.devocionalDelDia) } }) {
                            Image(systemName: viewModel.esFavorito(devocional: viewModel.devocionalDelDia) ? "heart.fill" : "heart")
                                .font(.system(size: 26))
                                .foregroundColor(viewModel.esFavorito(devocional: viewModel.devocionalDelDia) ? .red : .gray.opacity(0.6))
                                .padding(12)
                                // --- MODIFICADO ---
                                // Fondo del círculo del botón dinámico
                                .background(
                                    Circle()
                                        .fill(isDarkMode ? Color(white: 0.25) : Color.white)
                                        .shadow(color: isDarkMode ? .clear : .black.opacity(0.15), radius: 4)
                                )
                        }
                    }

                    // CAJA COMENTADA / CITA
                    VStack(alignment: .leading, spacing: 12) {
                        HStack(alignment: .top) {
                            Image(systemName: "quote.opening")
                                .font(.title2)
                                // Un tono azul más visible en modo oscuro
                                .foregroundColor(isDarkMode ? .blue.opacity(0.6) : .blue.opacity(0.4))
                            
                            Text(viewModel.devocionalDelDia.cita_texto)
                                .font(.system(size: 19, weight: .medium, design: .serif))
                                .italic()
                                .foregroundColor(.primary) // --- MODIFICADO ---
                        }
                        Text(viewModel.devocionalDelDia.versiculo)
                            .font(.footnote.bold())
                            .foregroundColor(isDarkMode ? Color(red: 100/255, green: 170/255, blue: 255/255) : .blue) // --- MODIFICADO ---
                            .padding(.leading, 32)
                    }
                    .padding()
                    // Fondo adaptable para el bloque de la cita bíblica
                    .background(isDarkMode ? Color.blue.opacity(0.15) : Color.blue.opacity(0.04))
                    .cornerRadius(20)

                    // TEXTO DEL CUERPO
                    Text(viewModel.devocionalDelDia.contenido)
                        .font(.system(size: 21, weight: .regular, design: .serif))
                        .lineSpacing(8)
                        .foregroundColor(.primary) // --- MODIFICADO ---
                }
                .padding(25)
                // --- MODIFICADO ---
                // HOJA DE LECTURA PRINCIPAL ADAPTABLE
                .background(
                    RoundedRectangle(cornerRadius: 35)
                        .fill(
                            isDarkMode
                                ? Color(white: 0.15).opacity(0.85) // Gris oscuro elegante
                                : Color.white.opacity(0.85)        // Blanco original translúcido
                        )
                        .shadow(color: isDarkMode ? .white.opacity(0.02) : .black.opacity(0.1), radius: 10)
                )
                .padding()
            }
        }
    }
    
    func formatearFecha(_ fecha: Date) -> String {
        let f = DateFormatter(); f.locale = Locale(identifier: "es_ES"); f.dateFormat = "EEEE, d 'de' MMMM"; return f.string(from: fecha)
    }
}
