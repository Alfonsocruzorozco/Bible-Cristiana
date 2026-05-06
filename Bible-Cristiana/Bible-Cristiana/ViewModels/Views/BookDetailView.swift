//
//  BookDetailView.swift
//  Bible-Cristiana
//
//  Created by Alfonso Cruz Orozco on 20/04/26.
//
import SwiftUI

struct BookDetailView: View {
    let bookName: String
    @StateObject private var viewModel = BibleViewModel()
    @State private var selectedChapter = 1
    @State private var selectedVerse = 1
    
    // El gradiente exacto de tu interfaz principal
    let fondoGradiente = LinearGradient(
        gradient: Gradient(colors: [
            Color(red: 255/255, green: 253/255, blue: 216/255), // Amarillo
            Color(red: 255/255, green: 218/255, blue: 238/255), // Rosa
            Color(red: 228/255, green: 196/255, blue: 255/255)  // Lila
        ]),
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
    
    var body: some View {
        ZStack {
            // 1. CAPA DE FONDO: Ocupa toda la pantalla
            fondoGradiente
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                // 2. SELECTORES MINIMALISTAS (Con efecto cristal)
                HStack(spacing: 15) {
                    Picker("Capítulo", selection: $selectedChapter) {
                        ForEach(viewModel.availableChapters, id: \.self) { Text("Capítulo \($0)").tag($0) }
                    }
                    .pickerStyle(.menu)
                    
                    if !viewModel.availableVerses.isEmpty {
                        Divider().frame(height: 20)
                        Picker("Versículo", selection: $selectedVerse) {
                            ForEach(viewModel.availableVerses, id: \.self) { Text("Vers. \($0)").tag($0) }
                        }
                        .pickerStyle(.menu)
                    }
                }
                .padding(.vertical, 8)
                .padding(.horizontal, 20)
                .background(.ultraThinMaterial) // Efecto difuminado elegante
                .cornerRadius(20)
                .padding(.top, 10)
                .padding(.bottom, 15)

                // 3. ÁREA DE LECTURA (Scroll con fondo blanco translúcido)
                ScrollViewReader { proxy in
                    ScrollView {
                        if viewModel.isLoading {
                            ProgressView().padding(.top, 50)
                        } else if let error = viewModel.errorMessage {
                            Text(error).foregroundColor(.red).padding()
                        } else {
                            VStack(alignment: .leading, spacing: 12) {
                                ForEach(viewModel.listaVersiculosProcesada) { v in
                                    (Text("\(v.numero) ")
                                        .font(.system(size: 14, weight: .bold, design: .serif))
                                        .foregroundColor(.red) +
                                     Text(v.contenido))
                                        .font(.system(size: 20, design: .serif))
                                        .foregroundColor(.black) // Asegura legibilidad
                                        .id(v.id)
                                }
                            }
                            .padding(25)
                            .lineSpacing(10)
                        }
                    }
                    // ESTA ES LA "HOJA" DE CRISTAL
                    .background(
                        RoundedRectangle(cornerRadius: 25)
                            .fill(Color.white.opacity(0.85)) // Deja pasar el color del fondo
                            .shadow(color: .black.opacity(0.05), radius: 10)
                    )
                    .padding(.horizontal, 15) // Margen para que se vea el fondo a los lados
                    .padding(.bottom, 10)
                    .onChange(of: selectedVerse) { _, newValue in
                        withAnimation { proxy.scrollTo(newValue, anchor: .top) }
                    }
                }
            }
        }
        .navigationTitle(bookName)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear { Task { await viewModel.getVerse(for: bookName, chapter: 1) } }
        .onChange(of: selectedChapter) { _, newValue in
            selectedVerse = 1
            Task { await viewModel.getVerse(for: bookName, chapter: newValue) }
        }
    }
}
