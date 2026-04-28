//
//  FavoritesView.swift
//  Bible-Cristiana
//
//  Created by Alfonso Cruz Orozco on 28/04/26.
//

import SwiftUI

struct FavoritesView: View {
    @StateObject private var viewModel = DevotionalViewModel()
    
    let fondoGradiente = LinearGradient(
        gradient: Gradient(colors: [
            Color(red: 255/255, green: 253/255, blue: 216/255),
            Color(red: 228/255, green: 196/255, blue: 255/255)
        ]),
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )

    var body: some View {
        ZStack {
            fondoGradiente.ignoresSafeArea()

            if viewModel.listaFavoritos.isEmpty {
                VStack(spacing: 20) {
                    Image(systemName: "heart.circle")
                        .font(.system(size: 80))
                        .foregroundColor(.gray.opacity(0.5))
                    Text("Tu lista de favoritos está vacía")
                        .font(.headline)
                        .foregroundColor(.secondary)
                }
            } else {
                ScrollView {
                    VStack(spacing: 15) {
                        ForEach(viewModel.listaFavoritos) { devocional in
                            // Cada favorito es una tarjeta que lleva al detalle
                            NavigationLink(destination: FavoriteDetailView(devocional: devocional)) {
                                HStack {
                                    VStack(alignment: .leading, spacing: 5) {
                                        Text(devocional.titulo)
                                            .font(.headline)
                                            .foregroundColor(.black)
                                        Text(devocional.versiculo)
                                            .font(.subheadline)
                                            .foregroundColor(.blue)
                                    }
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                        .foregroundColor(.gray)
                                }
                                .padding()
                                .background(RoundedRectangle(cornerRadius: 15).fill(Color.white.opacity(0.7)))
                            }
                        }
                    }
                    .padding()
                }
            }
        }
        .navigationTitle("Mis Favoritos")
    }
}

// Vista para leer el devocional favorito completo
struct FavoriteDetailView: View {
    let devocional: DevocionalModel
    var body: some View {
        ZStack {
            Color(red: 255/255, green: 253/255, blue: 216/255).ignoresSafeArea()
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    Text(devocional.titulo).font(.system(size: 30, weight: .bold, design: .serif))
                    Text(devocional.cita_texto).italic().font(.title3).foregroundColor(.blue)
                    Text(devocional.contenido).font(.system(size: 18, design: .serif)).lineSpacing(8)
                    Divider()
                    Text("ORACIÓN").font(.caption).bold()
                    Text(devocional.oracion).italic().foregroundColor(.secondary)
                }
                .padding(30)
                .background(RoundedRectangle(cornerRadius: 30).fill(Color.white.opacity(0.8)))
                .padding()
            }
        }
        .navigationTitle("Lectura")
    }
}
