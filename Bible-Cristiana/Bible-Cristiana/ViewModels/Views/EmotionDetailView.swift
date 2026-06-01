//
//  EmotionDetailView.swift
//  Bible-Cristiana
//
//  Created by Alfonso Cruz Orozco on 28/04/26.
//

import SwiftUI

struct EmotionDetailView: View {
    @EnvironmentObject var viewModel: DevotionalViewModel
    let emocion: String
    let icono: String
    let color: Color
    
    // --- NUEVO ---
    // Leemos el estado global del tema desde la app
    @AppStorage("isDarkMode") private var isDarkMode = false
    
    // --- NUEVO ---
    // Propiedad calculada dinámica para cambiar el fondo según el modo
    var fondoGradiente: LinearGradient {
        if isDarkMode {
            return LinearGradient(
                gradient: Gradient(colors: [
                    Color(red: 25/255, green: 25/255, blue: 35/255), // Azul muy oscuro
                    color.opacity(0.2)                               // Toque sutil del color emocional
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        } else {
            return LinearGradient(
                gradient: Gradient(colors: [
                    Color(red: 255/255, green: 253/255, blue: 216/255),
                    color.opacity(0.15)
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
                VStack(spacing: 0) {
                    VStack(alignment: .leading, spacing: 25) {
                        HStack(alignment: .top) {
                            VStack(alignment: .leading, spacing: 5) {
                                Label(emocion.uppercased(), systemImage: icono)
                                    .font(.caption.bold())
                                    .foregroundColor(color)
                                    .tracking(1)
                                
                                Text(viewModel.devocionalActualEmocion.titulo)
                                    .font(.system(size: 32, weight: .bold, design: .serif))
                                    .foregroundColor(.primary) // --- MODIFICADO ---
                            }
                            Spacer()
                            
                            // BOTÓN DE FAVORITOS
                            Button(action: { withAnimation(.spring()) { viewModel.toggleFavorito(para: viewModel.devocionalActualEmocion) } }) {
                                Image(systemName: viewModel.esFavorito(devocional: viewModel.devocionalActualEmocion) ? "heart.fill" : "heart")
                                    .font(.system(size: 26))
                                    .foregroundColor(viewModel.esFavorito(devocional: viewModel.devocionalActualEmocion) ? .red : .gray.opacity(0.6))
                                    .padding(12)
                                    // --- MODIFICADO ---
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
                                    .foregroundColor(color.opacity(isDarkMode ? 0.6 : 0.4))
                                
                                Text(viewModel.devocionalActualEmocion.cita_texto)
                                    .font(.system(size: 19, design: .serif))
                                    .italic()
                                    .foregroundColor(.primary) // --- MODIFICADO ---
                            }
                            Text(viewModel.devocionalActualEmocion.versiculo)
                                .font(.footnote.bold())
                                .foregroundColor(isDarkMode ? color.opacity(0.9) : color) // --- MODIFICADO ---
                                .padding(.leading, 32)
                        }
                        .padding()
                        .background(color.opacity(isDarkMode ? 0.15 : 0.05))
                        .cornerRadius(20)

                        // TEXTO DEL CUERPO
                        Text(viewModel.devocionalActualEmocion.contenido)
                            .font(.system(size: 21, design: .serif))
                            .lineSpacing(8)
                            .foregroundColor(.primary) // --- MODIFICADO ---
                        
                        // BOTÓN RECARGAR
                        Button(action: { viewModel.generarNuevoDevocionalParaEmocion(emocion: emocion) }) {
                            HStack {
                                Image(systemName: "sparkles")
                                Text("Dame otra palabra de \(emocion.lowercased())")
                            }
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(color)
                            .cornerRadius(15)
                            .shadow(color: color.opacity(isDarkMode ? 0.1 : 0.3), radius: 10, x: 0, y: 5)
                        }
                    }
                    .padding(25)
                    // --- MODIFICADO ---
                    // HOJA DE LECTURA PRINCIPAL ADAPTABLE
                    .background(
                        RoundedRectangle(cornerRadius: 35)
                            .fill(
                                isDarkMode
                                    ? Color(white: 0.15).opacity(0.85) // Gris carbón estético
                                    : Color.white.opacity(0.85)        // Blanco translúcido
                            )
                            .shadow(color: isDarkMode ? .white.opacity(0.02) : .black.opacity(0.1), radius: 10)
                    )
                    .padding()
                }
            }
        }
    }
}
