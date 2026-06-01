//
//  BibleStructureView.swift
//  Bible-Cristiana
//
//  Created by Alfonso Cruz Orozco on 28/04/26.
//

import SwiftUI

struct BibleStructureView: View {
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
                    Color(red: 255/255, green: 218/255, blue: 238/255),
                    Color(red: 228/255, green: 196/255, blue: 255/255)
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        }
    }

    var body: some View {
        ZStack {
            // Fondo adaptado
            fondoGradiente.ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 25) {
                    
                    // --- SECCIÓN: ANTIGUO TESTAMENTO ---
                    ExplanationCard(
                        title: "Antiguo Testamento",
                        subtitle: "La Preparación",
                        description: "Compuesto por 39 libros, narra la creación del mundo, la historia de Israel y las promesas de Dios antes de Jesús. Se enfoca en la Ley.",
                        icon: "book.closed.fill",
                        color: .brown
                    )
                    
                    // --- SECCIÓN: NUEVO TESTAMENTO ---
                    ExplanationCard(
                        title: "Nuevo Testamento",
                        subtitle: "El Cumplimiento",
                        description: "Contiene 27 libros que comienzan con Jesús. Se centra en su vida, enseñanzas y el nuevo pacto de gracia y perdón.",
                        icon: "cross.fill",
                        color: .indigo
                    )
                    
                    // --- SECCIÓN: DIFERENCIAS CLAVE ---
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Diferencias Principales")
                            .font(.headline)
                            // --- MODIFICADO ---
                            // Asegura contraste correcto en el título de la sección
                            .foregroundColor(.primary)
                            .padding(.horizontal)
                        
                        HStack(spacing: 12) {
                            DifferenceBox(title: "Antiguo", text: "La Ley", subtext: "Señalaba el pecado", color: .brown)
                            Image(systemName: "arrow.right")
                                .foregroundColor(.secondary)
                            DifferenceBox(title: "Nuevo", text: "La Gracia", subtext: "Ofrece perdón", color: .indigo)
                        }
                        .padding(.horizontal)
                    }
                    
                    // --- RESUMEN DE CATEGORÍAS ---
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Distribución")
                            .font(.caption.bold())
                            .foregroundColor(.secondary)
                            .padding(.horizontal)
                        
                        HStack {
                            VStack {
                                Text("39")
                                    .font(.title.bold())
                                    .foregroundColor(.primary) // --- MODIFICADO ---
                                Text("Libros AT")
                                    .font(.caption)
                                    .foregroundColor(.secondary) // --- MODIFICADO ---
                            }
                            .frame(maxWidth: .infinity)
                            
                            Divider().frame(height: 40)
                            
                            VStack {
                                Text("27")
                                    .font(.title.bold())
                                    .foregroundColor(.primary) // --- MODIFICADO ---
                                Text("Libros NT")
                                    .font(.caption)
                                    .foregroundColor(.secondary) // --- MODIFICADO ---
                            }
                            .frame(maxWidth: .infinity)
                        }
                        .padding()
                        // --- MODIFICADO ---
                        // Fondo dinámico translúcido para la caja de distribución
                        .background(
                            isDarkMode
                                ? Color(white: 0.2).opacity(0.6)
                                : Color.white.opacity(0.5)
                        )
                        .cornerRadius(20)
                        .padding(.horizontal)
                    }
                }
                .padding(.vertical)
            }
        }
        .navigationTitle("Estructura")
        .navigationBarTitleDisplayMode(.inline)
    }
}

// --- SUBVISTAS MODULARES CORREGIDAS ---

struct ExplanationCard: View {
    let title: String
    let subtitle: String
    let description: String
    let icon: String
    let color: Color
    
    // --- NUEVO ---
    @AppStorage("isDarkMode") private var isDarkMode = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Image(systemName: icon)
                    .font(.title)
                    .foregroundColor(color)
                    .padding(10)
                    // Opacidad adaptada para que no se pierda en fondos oscuros
                    .background(color.opacity(isDarkMode ? 0.25 : 0.1))
                    .cornerRadius(10)
                
                VStack(alignment: .leading) {
                    Text(title)
                        .font(.title3.bold())
                        .foregroundColor(.primary) // --- MODIFICADO ---
                    Text(subtitle)
                        .font(.caption)
                        .foregroundColor(color)
                        .fontWeight(.bold)
                }
            }
            
            Text(description)
                .font(.subheadline)
                .foregroundColor(.secondary) // Cambia nativamente
                .lineSpacing(4)
        }
        .padding(20)
        // --- MODIFICADO ---
        // Fondo adaptable para las tarjetas principales de explicación
        .background(
            isDarkMode
                ? Color(white: 0.15).opacity(0.8)
                : Color.white.opacity(0.8)
        )
        .cornerRadius(25)
        .padding(.horizontal)
    }
}

struct DifferenceBox: View {
    let title: String
    let text: String
    let subtext: String
    let color: Color
    
    // --- NUEVO ---
    @AppStorage("isDarkMode") private var isDarkMode = false
    
    var body: some View {
        VStack {
            Text(title)
                .font(.caption2.bold())
                .foregroundColor(color)
            Text(text)
                .font(.headline)
                .foregroundColor(.primary) // --- MODIFICADO ---
            Text(subtext)
                .font(.system(size: 10))
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
        .padding()
        // --- MODIFICADO ---
        // Ajuste de fondo para los pequeños bloques comparativos
        .background(color.opacity(isDarkMode ? 0.15 : 0.05))
        .cornerRadius(15)
        .overlay(
            RoundedRectangle(cornerRadius: 15)
                .stroke(color.opacity(isDarkMode ? 0.4 : 0.2), lineWidth: 1)
        )
    }
}
