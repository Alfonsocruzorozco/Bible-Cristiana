//
//  DailyNeedsView.swift
//  Bible-Cristiana
//
//  Created by Alfonso Cruz Orozco on 28/04/26.
//

import SwiftUI

struct DailyNeedsView: View {
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
            
            VStack(alignment: .leading, spacing: 20) {
                Text("¿Cómo te sientes hoy?")
                    .font(.system(size: 28, weight: .bold, design: .rounded))
                    .padding(.horizontal)
                    .padding(.top)

                List {
                    NavigationLink(destination: EmotionDetailView(emocion: "Sabiduría", icono: "lightbulb.fill", color: .orange)) {
                        Label("Sabiduría", systemImage: "lightbulb.fill").foregroundColor(.orange)
                    }
                    
                    NavigationLink(destination: EmotionDetailView(emocion: "Consuelo", icono: "heart.fill", color: .red)) {
                        Label("Consuelo", systemImage: "heart.fill").foregroundColor(.red)
                    }
                    
                    NavigationLink(destination: EmotionDetailView(emocion: "Paz", icono: "leaf.fill", color: .green)) {
                        Label("Paz", systemImage: "leaf.fill").foregroundColor(.green)
                    }
                    
                    NavigationLink(destination: EmotionDetailView(emocion: "Fortaleza", icono: "bolt.fill", color: .blue)) {
                        Label("Fortaleza", systemImage: "bolt.fill").foregroundColor(.blue)
                    }
                }
                .scrollContentBackground(.hidden)
            }
        }
        .navigationTitle("Necesidades")
        .navigationBarTitleDisplayMode(.inline)
    }
}
