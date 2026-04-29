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
            
            VStack(spacing: 40) {
                Image(systemName: "magnifyingglass")
                    .font(.system(size: 80))
                    .foregroundColor(.orange)
                    .padding(.top, 50)
                
                VStack(spacing: 15) {
                    Text("Juan 3:16")
                        .font(.system(size: 45, weight: .bold, design: .serif))
                    
                    VStack(alignment: .leading, spacing: 12) {
                        HStack {
                            Text("Juan:").bold()
                            Text("Nombre del Libro")
                        }
                        HStack {
                            Text("3:").bold()
                            Text("Capítulo (Número grande)")
                        }
                        HStack {
                            Text("16:").bold()
                            Text("Versículo (Número pequeño)")
                        }
                    }
                    .padding()
                    .background(.ultraThinMaterial) // Efecto cristal sobre el degradado
                    .cornerRadius(20)
                }
                Spacer()
            }
            .padding()
        }
        .navigationTitle("¿Cómo buscar?")
    }
}
