//
//  ContentView.swift
//  Bible-Cristiana
//
//  Created by Alfonso Cruz Orozco on 20/04/26.
//

import SwiftUI

struct ContentView: View {
    // Colores del gradiente exactos de tu captura
    let fondoGradiente = LinearGradient(
        gradient: Gradient(colors: [
            Color(red: 255/255, green: 253/255, blue: 216/255), // Amarillo pastel
            Color(red: 255/255, green: 218/255, blue: 238/255), // Rosa pastel
            Color(red: 228/255, green: 196/255, blue: 255/255)  // Lila pastel
        ]),
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )

    var body: some View {
        NavigationStack {
            ZStack {
                // 1. FONDO
                fondoGradiente
                    .ignoresSafeArea()

                // 2. CONTENIDO
                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        
                        Text("Mi Biblia")
                            .font(.system(size: 36, weight: .bold))
                            .foregroundColor(.black)
                            .padding(.horizontal)
                            .padding(.top, 20)

                        // TARJETA CONTENEDORA BLANCA (Fusión de tus 5 secciones)
                        VStack(spacing: 0) {
                            
                            // 1. BIBLIA (Tu conexión original)
                            NavigationLink(destination: BibleReadView()) {
                                MenuRowView(icon: "book.fill", title: "Biblia Reina Valera", iconColor: .blue)
                            }
                            Divider().padding(.leading, 55)

                            // 2. DEVOCIONALES (Tu conexión original)
                            NavigationLink(destination: DevotionalsView()) {
                                MenuRowView(icon: "heart.text.square.fill", title: "Devocionales Diarios", iconColor: .red)
                            }
                            Divider().padding(.leading, 55)

                            // 3. CÓMO LEER (Nuevo - Sin destino aún)
                            MenuRowView(icon: "lightbulb.fill", title: "Como leer la Biblia", iconColor: .yellow)
                            Divider().padding(.leading, 55)

                            // 4. NOTAS (Nuevo)
                            MenuRowView(icon: "square.and.pencil", title: "Notas", iconColor: .orange)
                            Divider().padding(.leading, 55)

                            // 5. FAVORITOS (Nuevo)
                            MenuRowView(icon: "heart.fill", title: "Favoritos", iconColor: .pink)
                            
                        }
                        .background(Color.white)
                        .cornerRadius(15)
                        .padding(.horizontal)
                        .shadow(color: Color.black.opacity(0.05), radius: 10, x: 0, y: 5)

                    }
                }
            }
        }
    }
}

// COMPONENTE DE FILA (Para mantener el código limpio y profesional)
struct MenuRowView: View {
    let icon: String
    let title: String
    let iconColor: Color

    var body: some View {
        HStack {
            Image(systemName: icon)
                .font(.system(size: 20))
                .foregroundColor(iconColor)
                .frame(width: 35, height: 35)
                .background(iconColor.opacity(0.1))
                .cornerRadius(8)
            
            Text(title)
                .font(.system(size: 18, weight: .medium))
                .foregroundColor(.black)
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .foregroundColor(Color.gray.opacity(0.4))
                .font(.system(size: 14, weight: .semibold))
        }
        .padding(.vertical, 15)
        .padding(.horizontal, 15)
    }
}
