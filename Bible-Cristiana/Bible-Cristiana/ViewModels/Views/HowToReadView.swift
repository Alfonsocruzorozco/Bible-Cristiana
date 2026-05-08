//
//  HowToReadView.swift
//  Bible-Cristiana
//
//  Created by Alfonso Cruz Orozco on 28/04/26.
//

import SwiftUI

struct HowToReadView: View {
    // Configuración de la cuadrícula: 2 columnas con espacio de 20 puntos
    let columns = [
        GridItem(.flexible(), spacing: 20),
        GridItem(.flexible(), spacing: 20)
    ]
    
    // Fondo constante para mantener la identidad visual de Santuario Digital
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
                VStack(alignment: .leading, spacing: 30) {
                    
                    // Cabecera de la sección
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Cómo leer la Biblia")
                            .font(.system(size: 34, weight: .bold, design: .serif))
                        Text("Sigue estos pasos para profundizar en la Palabra de Dios.")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    .padding(.horizontal)
                    .padding(.top, 20)
                    
                    // Tablero de navegación modular
                    LazyVGrid(columns: columns, spacing: 20) {
                        
                        // 1. Ruta de Lectura
                        NavigationLink(destination: ReadingRouteView()) {
                            GuideCard(title: "Ruta de Lectura",
                                      subtitle: "Plan paso a paso",
                                      icon: "map.fill",
                                      color: .indigo)
                        }
                        
                        // 2. Historia Completa (Estructura)
                        NavigationLink(destination: BibleStructureView()) {
                            GuideCard(title: "Historia Completa",
                                      subtitle: "Antiguo y Nuevo",
                                      icon: "books.vertical.fill",
                                      color: .cyan)
                        }
                        
                        // 3. Guía de Búsqueda
                        NavigationLink(destination: SearchGuideView()) {
                            GuideCard(title: "Guía de Búsqueda",
                                      subtitle: "Cómo encontrar citas",
                                      icon: "magnifyingglass",
                                      color: .orange)
                        }
                        
                        // 4. ¿Qué necesitas hoy? (Conexión al menú emocional profesional)
                        NavigationLink(destination: DailyNeedsView()) {
                            GuideCard(title: "¿Qué necesitas?",
                                      subtitle: "Promesas hoy",
                                      icon: "heart.circle.fill",
                                      color: .pink)
                        }
                    }
                    .padding(.horizontal)
                    
                    // Decoración o pensamiento final
                    VStack(spacing: 10) {
                        Image(systemName: "sparkles")
                            .foregroundColor(.orange.opacity(0.6))
                        Text("Lámpara es a mis pies tu palabra, y lumbrera a mi camino.")
                            .font(.system(.caption, design: .serif))
                            .italic()
                            .multilineTextAlignment(.center)
                            .foregroundColor(.secondary)
                            .padding(.horizontal, 40)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.top, 30)
                }
                .padding(.bottom, 40)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

// COMPONENTE DE TARJETA MODULAR (GuideCard)
struct GuideCard: View {
    let title: String
    let subtitle: String
    let icon: String
    let color: Color
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            // Icono con SF Symbol
            Image(systemName: icon)
                .font(.system(size: 28, weight: .semibold))
                .foregroundColor(color)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.system(.headline, design: .rounded))
                    .foregroundColor(.black)
                    .multilineTextAlignment(.leading)
                
                Text(subtitle)
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.leading)
            }
            
            Spacer()
            
            // Indicador de acción
            HStack {
                Spacer()
                Image(systemName: "chevron.right.circle.fill")
                    .font(.title3)
                    .foregroundColor(color.opacity(0.4))
            }
        }
        .padding(20)
        .frame(height: 175)
        // Fondo con efecto ultraThinMaterial para el look Glassmorphism
        .background(.ultraThinMaterial)
        .background(Color.white.opacity(0.4))
        .cornerRadius(25)
        .overlay(
            RoundedRectangle(cornerRadius: 25)
                .stroke(Color.white.opacity(0.5), lineWidth: 1)
        )
        .shadow(color: .black.opacity(0.05), radius: 10, x: 0, y: 5)
    }
}
