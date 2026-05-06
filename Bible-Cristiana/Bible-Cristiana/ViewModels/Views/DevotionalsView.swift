//
//  DevotionalsView.swift
//  Bible-Cristiana
//
//  Created by Alfonso Cruz Orozco on 20/04/26.
//

import SwiftUI

struct DevotionalsView: View {
    @EnvironmentObject var viewModel: DevotionalViewModel
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color(red: 255/255, green: 253/255, blue: 216/255), Color(red: 228/255, green: 196/255, blue: 255/255)]), startPoint: .topLeading, endPoint: .bottomTrailing).ignoresSafeArea()
            
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 25) {
                    HStack(alignment: .top) {
                        VStack(alignment: .leading, spacing: 5) {
                            Text(formatearFecha(viewModel.devocionalDelDia.fecha).uppercased())
                                .font(.caption.bold()).foregroundColor(.secondary).tracking(1)
                            Text(viewModel.devocionalDelDia.titulo)
                                .font(.system(size: 34, weight: .bold, design: .serif))
                        }
                        Spacer()
                        Button(action: { withAnimation(.spring()) { viewModel.toggleFavorito(para: viewModel.devocionalDelDia) } }) {
                            Image(systemName: viewModel.esFavorito(devocional: viewModel.devocionalDelDia) ? "heart.fill" : "heart")
                                .font(.system(size: 26)).foregroundColor(viewModel.esFavorito(devocional: viewModel.devocionalDelDia) ? .red : .gray.opacity(0.6))
                                .padding(12).background(Circle().fill(Color.white).shadow(radius: 4))
                        }
                    }

                    VStack(alignment: .leading, spacing: 12) {
                        HStack(alignment: .top) {
                            Image(systemName: "quote.opening").font(.title2).foregroundColor(.blue.opacity(0.4))
                            Text(viewModel.devocionalDelDia.cita_texto).font(.system(size: 19, weight: .medium, design: .serif)).italic()
                        }
                        Text(viewModel.devocionalDelDia.versiculo).font(.footnote.bold()).foregroundColor(.blue).padding(.leading, 32)
                    }
                    .padding().background(Color.blue.opacity(0.04)).cornerRadius(20)

                    Text(viewModel.devocionalDelDia.contenido).font(.system(size: 21, weight: .regular, design: .serif)).lineSpacing(8)
                }
                .padding(25).background(RoundedRectangle(cornerRadius: 35).fill(Color.white.opacity(0.85)).shadow(radius: 10)).padding()
            }
        }
    }
    
    func formatearFecha(_ fecha: Date) -> String {
        let f = DateFormatter(); f.locale = Locale(identifier: "es_ES"); f.dateFormat = "EEEE, d 'de' MMMM"; return f.string(from: fecha)
    }
}
