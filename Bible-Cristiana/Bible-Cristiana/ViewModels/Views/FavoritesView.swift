//
//  FavoritesView.swift
//  Bible-Cristiana
//
//  Created by Alfonso Cruz Orozco on 28/04/26.
//

import SwiftUI

struct FavoritesView: View {
    @EnvironmentObject var viewModel: DevotionalViewModel
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color(red: 255/255, green: 253/255, blue: 216/255), Color(red: 228/255, green: 196/255, blue: 255/255)]), startPoint: .topLeading, endPoint: .bottomTrailing).ignoresSafeArea()
            
            VStack {
                if viewModel.listaFavoritos.isEmpty {
                    Text("No hay favoritos guardados")
                        .font(.system(.body, design: .serif))
                        .foregroundColor(.secondary)
                        .padding(.top, 100)
                    Spacer()
                } else {
                    List {
                        ForEach(viewModel.listaFavoritos) { dev in
                            VStack(alignment: .leading, spacing: 15) {
                                Text(dev.titulo).font(.system(.headline, design: .serif)).bold()
                                Text(dev.versiculo).font(.caption.bold()).foregroundColor(.blue)
                                Text(dev.contenido).font(.system(size: 17, design: .serif)).lineSpacing(6)
                                    .fixedSize(horizontal: false, vertical: true)
                            }
                            .padding().background(Color.white.opacity(0.6)).cornerRadius(20)
                            .listRowBackground(Color.clear)
                            .listRowSeparator(.hidden)
                        }
                        .onDelete(perform: viewModel.eliminarDeFavoritos) // <--- ELIMINAR RECUPERADO
                    }
                    .listStyle(PlainListStyle())
                    .scrollContentBackground(.hidden)
                }
            }
        }
        .navigationTitle("Mis Favoritos")
        .toolbar { EditButton() }
    }
}
