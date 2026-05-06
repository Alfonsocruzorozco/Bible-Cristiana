//
//  SearchGuideView.swift
//  Bible-Cristiana
//
//  Created by Alfonso Cruz Orozco on 28/04/26.
//

import SwiftUI

struct SearchGuideView: View {
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
                VStack(spacing: 30) {
                    VStack(spacing: 15) {
                        Image(systemName: "magnifyingglass.circle.fill")
                            .font(.system(size: 70))
                            .foregroundColor(.orange)
                            .shadow(color: .orange.opacity(0.3), radius: 10)
                        
                        Text("¿Cómo buscar una cita?")
                            .font(.system(size: 28, weight: .bold, design: .rounded))
                            .multilineTextAlignment(.center)
                    }
                    .padding(.top, 20)

                    VStack(spacing: 20) {
                        Text("Ejemplo:")
                            .font(.caption.smallCaps()) // Corrección aquí
                            .foregroundColor(.secondary)

                        HStack(spacing: 10) {
                            SearchPartTag(text: "Juan", label: "Libro", color: .blue)
                            SearchPartTag(text: "3", label: "Capítulo", color: .orange)
                            Text(":")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                            SearchPartTag(text: "16", label: "Versículo", color: .green)
                        }
                        .padding()
                        .background(Color.white.opacity(0.6))
                        .cornerRadius(25)
                    }

                    VStack(alignment: .leading, spacing: 20) {
                        InfoRow(icon: "book.closed.fill", color: .blue, title: "El Libro", desc: "Es el nombre de la sección (ej. Juan, Salmos, Génesis).")
                        InfoRow(icon: "number.circle.fill", color: .orange, title: "El Capítulo", desc: "Es el número grande que aparece al inicio de las páginas.")
                        InfoRow(icon: "tag.fill", color: .green, title: "El Versículo", desc: "Son los números pequeños dentro de cada párrafo.")
                    }
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 30).fill(.white.opacity(0.5)))
                    .padding(.horizontal)

                    HStack {
                        Image(systemName: "lightbulb.fill")
                            .foregroundColor(.yellow)
                        Text("**Tip:** Si ves un guion (3:16-18), significa que debes leer desde el verso 16 hasta el 18.")
                            .font(.footnote)
                            .foregroundColor(.secondary)
                    }
                    .padding()
                }
            }
        }
        .navigationTitle("Guía")
        .navigationBarTitleDisplayMode(.inline)
    }
}

// COMPONENTE PARA LAS ETIQUETAS DEL EJEMPLO
struct SearchPartTag: View {
    let text: String
    let label: String
    let color: Color
    
    var body: some View {
        VStack {
            Text(text)
                .font(.system(size: 24, weight: .bold, design: .serif))
                .foregroundColor(.white)
                .padding(.horizontal, 15)
                .padding(.vertical, 10)
                .background(color)
                .cornerRadius(12)
            
            Text(label)
                .font(.caption2.smallCaps()) // Corrección definitiva aquí
                .fontWeight(.bold)
                .foregroundColor(color)
        }
    }
}

// FILA DE INFORMACIÓN REUTILIZABLE
struct InfoRow: View {
    let icon: String
    let color: Color
    let title: String
    let desc: String
    
    var body: some View {
        HStack(alignment: .top, spacing: 15) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(color)
                .frame(width: 40)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.headline)
                Text(desc)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
    }
}
