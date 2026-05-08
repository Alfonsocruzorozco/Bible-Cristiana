//
//  EmotionDetailView.swift
//  Bible-Cristiana
//
//  Created by Alfonso Cruz Orozco on 28/04/26.
//

import SwiftUI

struct EmotionDetailView: View {
    @EnvironmentObject var viewModel: DevotionalViewModel
    let emocion: String
    let icono: String
    let color: Color
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color(red: 255/255, green: 253/255, blue: 216/255), color.opacity(0.15)]), startPoint: .topLeading, endPoint: .bottomTrailing).ignoresSafeArea()
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 0) {
                    VStack(alignment: .leading, spacing: 25) {
                        HStack(alignment: .top) {
                            VStack(alignment: .leading, spacing: 5) {
                                Label(emocion.uppercased(), systemImage: icono).font(.caption.bold()).foregroundColor(color).tracking(1)
                                Text(viewModel.devocionalActualEmocion.titulo).font(.system(size: 32, weight: .bold, design: .serif))
                            }
                            Spacer()
                            Button(action: { withAnimation(.spring()) { viewModel.toggleFavorito(para: viewModel.devocionalActualEmocion) } }) {
                                Image(systemName: viewModel.esFavorito(devocional: viewModel.devocionalActualEmocion) ? "heart.fill" : "heart")
                                    .font(.system(size: 26)).foregroundColor(viewModel.esFavorito(devocional: viewModel.devocionalActualEmocion) ? .red : .gray.opacity(0.6))
                                    .padding(12).background(Circle().fill(Color.white).shadow(radius: 4))
                            }
                        }

                        VStack(alignment: .leading, spacing: 12) {
                            HStack(alignment: .top) {
                                Image(systemName: "quote.opening").font(.title2).foregroundColor(color.opacity(0.4))
                                Text(viewModel.devocionalActualEmocion.cita_texto).font(.system(size: 19, design: .serif)).italic()
                            }
                            Text(viewModel.devocionalActualEmocion.versiculo).font(.footnote.bold()).foregroundColor(color).padding(.leading, 32)
                        }
                        .padding().background(color.opacity(0.05)).cornerRadius(20)

                        Text(viewModel.devocionalActualEmocion.contenido).font(.system(size: 21, design: .serif)).lineSpacing(8)
                        
                        Button(action: { viewModel.generarNuevoDevocionalParaEmocion(emocion: emocion) }) {
                            HStack {
                                Image(systemName: "sparkles")
                                Text("Dame otra palabra de \(emocion.lowercased())")
                            }
                            .font(.headline).foregroundColor(.white).padding().frame(maxWidth: .infinity)
                            .background(color).cornerRadius(15).shadow(color: color.opacity(0.3), radius: 10, x: 0, y: 5)
                        }
                    }
                    .padding(25).background(RoundedRectangle(cornerRadius: 35).fill(Color.white.opacity(0.85)).shadow(radius: 10)).padding()
                }
            }
        }
    }
}
