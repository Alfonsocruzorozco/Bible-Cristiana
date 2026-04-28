//
//  DevotionalsView.swift
//  Bible-Cristiana
//
//  Created by Alfonso Cruz Orozco on 20/04/26.
//

import SwiftUI

struct DevotionalsView: View {
    @StateObject private var viewModel = DevotionalViewModel()
    
    let fondoGradiente = LinearGradient(
        gradient: Gradient(colors: [
            Color(red: 255/255, green: 253/255, blue: 216/255),
            Color(red: 255/255, green: 218/255, blue: 238/255),
            Color(red: 228/255, green: 196/255, blue: 255/255)
        ]),
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )

    var body: some View {
        ZStack {
            fondoGradiente.ignoresSafeArea()

            ScrollView {
                if let devocional = viewModel.devocionalDelDia {
                    VStack(spacing: 25) {
                        
                        // TARJETA PRINCIPAL CON BOTÓN DE FAVORITO
                        ZStack(alignment: .topTrailing) {
                            
                            VStack(alignment: .leading, spacing: 22) {
                                Text(formatearFecha(devocional.fecha))
                                    .font(.caption).fontWeight(.bold).foregroundColor(.secondary)

                                Text(devocional.titulo)
                                    .font(.system(size: 32, weight: .bold, design: .serif))

                                VStack(alignment: .leading, spacing: 10) {
                                    Text(devocional.cita_texto)
                                        .font(.system(size: 19, weight: .medium, design: .serif)).italic()
                                    Text(devocional.versiculo)
                                        .font(.caption).fontWeight(.bold).foregroundColor(.blue)
                                }
                                .padding()
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .background(Color.blue.opacity(0.06))
                                .cornerRadius(15)

                                Text(devocional.contenido)
                                    .font(.system(size: 20, design: .serif))
                                    .lineSpacing(8)
                                
                                Divider()

                                VStack(alignment: .leading, spacing: 12) {
                                    Text("ORACIÓN")
                                        .font(.caption2).fontWeight(.black).foregroundColor(.secondary)
                                    Text(devocional.oracion)
                                        .font(.system(size: 18, design: .serif)).italic().foregroundColor(.secondary)
                                }
                            }
                            .padding(30)
                            
                            // BOTÓN DE CORAZÓN (Favoritos)
                            Button(action: {
                                withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                                    viewModel.toggleFavorito(id: devocional.id)
                                }
                            }) {
                                Image(systemName: viewModel.favoritosIds.contains(devocional.id) ? "heart.fill" : "heart")
                                    .font(.system(size: 26))
                                    .foregroundColor(viewModel.favoritosIds.contains(devocional.id) ? .red : .gray)
                                    .padding(25)
                            }
                        }
                        .background(
                            RoundedRectangle(cornerRadius: 35)
                                .fill(Color.white.opacity(0.85))
                                .shadow(color: .black.opacity(0.05), radius: 20)
                        )
                        .padding(.horizontal, 20)

                        // BOTÓN COMPARTIR
                        ShareLink(item: "\(devocional.titulo)\n\n\(devocional.cita_texto) (\(devocional.versiculo))") {
                            Label("Compartir Reflexión", systemImage: "square.and.arrow.up")
                                .font(.headline).foregroundColor(.white).padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.blue).cornerRadius(18)
                        }
                        .padding(.horizontal, 45).padding(.bottom, 30)
                    }
                    .padding(.vertical, 20)
                } else {
                    ProgressView().padding(.top, 100)
                }
            }
        }
        .navigationTitle("Devocional")
    }

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
