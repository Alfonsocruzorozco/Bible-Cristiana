//
//  ContentView.swift
//  Bible-Cristiana
//
//  Created by Alfonso Cruz Orozco on 20/04/26.
//

import SwiftUI

struct ContentView: View {
    // --- MODIFICADO ---
    // Leemos el estado global del tema desde ContentView
    @AppStorage("isDarkMode") private var isDarkMode = false

    // Definimos el degradado de fondo constante para la app
    // --- MODIFICADO ---
    // Ahora es una computed property que cambia según el tema.
    var fondoGradiente: LinearGradient {
        if isDarkMode {
            // Fondo oscuro para el modo noche
            return LinearGradient(
                gradient: Gradient(colors: [
                    Color(red: 25/255, green: 25/255, blue: 35/255), // Azul muy oscuro
                    Color(red: 35/255, green: 25/255, blue: 45/255)  // Morado muy oscuro
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        } else {
            // Tu degradado original para el modo claro
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
        NavigationStack {
            ZStack {
                // Fondo que ignora los bordes de la pantalla
                fondoGradiente.ignoresSafeArea()

                ScrollView {
                    VStack(spacing: 25) {
                        // --- MODIFICADO ---
                        // Ajustamos el espaciado superior para la barra de navegación
                        VStack { Spacer().frame(height: 10) }
                        
                        // Título Principal Estilizado
                        Text("Santuario Digital")
                            .font(.system(size: 38, weight: .bold, design: .serif))
                            // --- MODIFICADO ---
                            // .primary cambia automáticamente entre negro (Claro) y blanco (Oscuro)
                            .foregroundColor(.primary)
                            .padding(.top, 10) // Ajustado

                        VStack(spacing: 15) {
                            // 1. BOTÓN BIBLIA
                            NavigationLink(destination: BibleReadView()) {
                                MenuCard(title: "Biblia Reina Valera", icon: "book.fill", color: .brown)
                            }

                            // 2. BOTÓN DEVOCIONALES
                            NavigationLink(destination: DevotionalsView()) {
                                MenuCard(title: "Devocionales Diarios", icon: "sun.max.fill", color: .orange)
                            }

                            // 3. BOTÓN FAVORITOS
                            NavigationLink(destination: FavoritesView()) {
                                MenuCard(title: "Mis Favoritos", icon: "heart.fill", color: .red)
                            }

                            // 4. GUÍA DE LECTURA
                            NavigationLink(destination: HowToReadView()) {
                                MenuCard(title: "Cómo leer la Biblia", icon: "info.circle.fill", color: .blue)
                            }
                        }
                        .padding(.horizontal, 20)
                        
                        // Espaciado extra al final
                        Spacer().frame(height: 50)
                    }
                }
            }
            // --- NUEVO ---
            // Barra de navegación con el botón del sol/luna en la esquina superior derecha
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        withAnimation(.easeInOut) {
                            isDarkMode.toggle()
                        }
                    }) {
                        // Ícono que cambia según el estado actual
                        Image(systemName: isDarkMode ? "moon.stars.fill" : "sun.max.fill")
                            .font(.title3)
                            .foregroundColor(isDarkMode ? .yellow : .orange)
                            .padding(8)
                            .background(Circle().fill(isDarkMode ? Color.white.opacity(0.15) : Color.black.opacity(0.05)))
                    }
                }
            }
        }
    }
}

// COMPONENTE DE TARJETA PARA EL MENÚ PRINCIPAL
struct MenuCard: View {
    let title: String
    let icon: String
    let color: Color

    // --- MODIFICADO ---
    // También necesitamos leer el estado del tema en MenuCard para el fondo.
    @AppStorage("isDarkMode") private var isDarkMode = false

    var body: some View {
        HStack {
            Image(systemName: icon)
                .font(.title)
                .foregroundColor(color)
                .frame(width: 50)

            Text(title)
                .font(.headline)
                // --- MODIFICADO ---
                // .primary para que sea blanco en modo oscuro
                .foregroundColor(.primary)

            Spacer()

            Image(systemName: "chevron.right")
                // --- MODIFICADO ---
                // .secondary para un tono de gris automático
                .foregroundColor(.secondary)
        }
        .padding()
        // --- MODIFICADO ---
        // El fondo de la tarjeta ahora es dinámico
        .background(
            isDarkMode
                // Gris oscuro con transparencia en Modo Oscuro
                ? Color(white: 0.15).opacity(0.8)
                // Tu blanco original con transparencia en Modo Claro
                : Color.white.opacity(0.8)
        )
        .cornerRadius(20)
        // Sombras también dinámicas
        .shadow(color: isDarkMode ? .white.opacity(0.05) : .black.opacity(0.05), radius: 10)
    }
}
