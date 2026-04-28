//
//  DevotionalsView.swift
//  Bible-Cristiana
//
//  Created by Alfonso Cruz Orozco on 20/04/26.
//

import SwiftUI

struct DevotionalsView: View {
    @StateObject private var viewModel = DevotionalViewModel()
    
    // Gradiente insignia de la App
    let fondoGradiente = LinearGradient(
        gradient: Gradient(colors: [
            Color(red: 255/255, green: 253/255, blue: 216/255), // Amarillo
            Color(red: 255/255, green: 218/255, blue: 238/255), // Rosa
            Color(red: 228/255, green: 196/255, blue: 255/255)  // Lila
        ]),
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )

    var body: some View {
        ZStack {
            // Capa de fondo
            fondoGradiente
                .ignoresSafeArea()

            ScrollView {
                if let devocional = viewModel.devocionalDelDia {
                    VStack(spacing: 25) {
                        
                        // TARJETA DE CRISTAL (Glassmorphism)
                        VStack(alignment: .leading, spacing: 22) {
                            
                            // 1. Fecha
                            Text(formatearFecha(devocional.fecha))
                                .font(.caption)
                                .fontWeight(.bold)
                                .foregroundColor(.secondary)

                            // 2. Título
                            Text(devocional.titulo)
                                .font(.system(size: 32, weight: .bold, design: .serif))
                                .foregroundColor(.black)

                            // 3. Bloque de Versículo Estilizado
                            VStack(alignment: .leading, spacing: 10) {
                                Text(devocional.cita_texto)
                                    .font(.system(size: 19, weight: .medium, design: .serif))
                                    .italic()
                                    .foregroundColor(.black.opacity(0.8))
                                
                                Text(devocional.versiculo)
                                    .font(.caption)
                                    .fontWeight(.bold)
                                    .foregroundColor(.blue)
                            }
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(Color.blue.opacity(0.06))
                            .cornerRadius(15)

                            // 4. Reflexión principal
                            Text(devocional.contenido)
                                .font(.system(size: 20, design: .serif))
                                .lineSpacing(8)
                                .foregroundColor(.black)
                            
                            Divider()
                                .padding(.vertical, 10)

                            // 5. Sección de Oración
                            VStack(alignment: .leading, spacing: 12) {
                                Text("ORACIÓN")
                                    .font(.caption2)
                                    .fontWeight(.black)
                                    .foregroundColor(.secondary)
                                
                                Text(devocional.oracion)
                                    .font(.system(size: 18, design: .serif))
                                    .italic()
                                    .foregroundColor(.secondary)
                                    .lineSpacing(4)
                            }
                        }
                        .padding(30)
                        .background(
                            RoundedRectangle(cornerRadius: 35)
                                .fill(Color.white.opacity(0.85)) // Efecto traslúcido
                                .shadow(color: .black.opacity(0.05), radius: 20, x: 0, y: 10)
                        )
                        .padding(.horizontal, 20)

                        // BOTÓN PARA COMPARTIR
                        ShareLink(item: "\(devocional.titulo)\n\n\(devocional.cita_texto) (\(devocional.versiculo))\n\n\(devocional.contenido)") {
                            Label("Compartir Reflexión", systemImage: "square.and.arrow.up")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.blue)
                                .cornerRadius(18)
                        }
                        .padding(.horizontal, 45)
                        .padding(.bottom, 30)
                    }
                    .padding(.vertical, 20)
                    
                } else {
                    // Pantalla de espera
                    VStack(spacing: 20) {
                        ProgressView()
                            .scaleEffect(1.5)
                        Text("Preparando tu palabra de hoy...")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.top, 100)
                }
            }
        }
        .navigationTitle("Devocional")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    // Función para dar formato a la fecha en español
    func formatearFecha(_ fechaRaw: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        if let date = formatter.date(from: fechaRaw) {
            formatter.locale = Locale(identifier: "es_ES")
            formatter.dateFormat = "d 'de' MMMM"
            return formatter.string(from: date).uppercased()
        }
        return fechaRaw
    }
}
