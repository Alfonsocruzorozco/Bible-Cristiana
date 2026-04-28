//
//  ContentView.swift
//  Bible-Cristiana
//
//  Created by Alfonso Cruz Orozco on 20/04/26.
//

import SwiftUI

struct ContentView: View {
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
        NavigationStack {
            ZStack {
                fondoGradiente.ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 25) {
                        Text("Santuario Digital")
                            .font(.system(size: 38, weight: .bold, design: .serif))
                            .padding(.top, 40)
                        
                        VStack(spacing: 15) {
                            // 1. BOTÓN BIBLIA
                            // Nota: En tu panel veo 'BibleReadView'.
                            // Si ese es el inicio de tu biblia, úsalo aquí:
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
                            
                            // 4. PRÓXIMAMENTE
                            NavigationLink(destination: Text("Guía de lectura próximamente")) {
                                MenuCard(title: "Cómo leer la Biblia", icon: "info.circle.fill", color: .blue)
                            }
                        }
                        .padding(.horizontal, 20)
                    }
                }
            }
        }
    }
}

// COMPONENTE DE TARJETA (Asegúrate de copiarlo también)
struct MenuCard: View {
    let title: String
    let icon: String
    let color: Color
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .font(.title)
                .foregroundColor(color)
                .frame(width: 50)
            
            Text(title)
                .font(.headline)
                .foregroundColor(.black)
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
        }
        .padding()
        .background(Color.white.opacity(0.8))
        .cornerRadius(20)
        .shadow(color: .black.opacity(0.05), radius: 10)
    }
}
