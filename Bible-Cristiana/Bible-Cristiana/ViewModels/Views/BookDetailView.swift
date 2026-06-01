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
    
    // --- NUEVO ---
    // Leemos el estado global del tema
    @AppStorage("isDarkMode") private var isDarkMode = false
    
    // --- MODIFICADO ---
    // Propiedad calculada dinámica para cambiar el fondo según el modo
    var fondoGradiente: LinearGradient {
        if isDarkMode {
            return LinearGradient(
                gradient: Gradient(colors: [
                    Color(red: 25/255, green: 25/255, blue: 35/255), // Azul muy oscuro
                    Color(red: 35/255, green: 25/255, blue: 45/255)  // Morado muy oscuro
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        } else {
            return LinearGradient(
                gradient: Gradient(colors: [
                    Color(red: 255/255, green: 253/255, blue: 216/255), // Amarillo
                    Color(red: 255/255, green: 218/255, blue: 238/255), // Rosa
                    Color(red: 228/255, green: 196/255, blue: 255/255)  // Lila
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        }
    }
    
    var body: some View {
        ZStack {
            // 1. CAPA DE FONDO: Ocupa toda la pantalla de manera dinámica
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
                .background(.ultraThinMaterial) // Apple lo oscurece o aclara de forma nativa impecable
                .cornerRadius(20)
                .padding(.top, 10)
                .padding(.bottom, 15)

                // 3. ÁREA DE LECTURA (Scroll con fondo dinámico translúcido)
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
                                        // Rojo ligeramente más brillante en modo oscuro para legibilidad
                                        .foregroundColor(isDarkMode ? Color(red: 255/255, green: 100/255, blue: 100/255) : .red) +
                                     Text(v.contenido))
                                        .font(.system(size: 20, design: .serif))
                                        // --- MODIFICADO ---
                                        // .primary para cambiar dinámicamente entre negro y blanco puro
                                        .foregroundColor(.primary)
                                        .id(v.id)
                                }
                            }
                            .padding(25)
                            .lineSpacing(10)
                        }
                    }
                    // --- MODIFICADO ---
                    // ESTA ES LA "HOJA" DE CRISTAL ADAPTABLE
                    .background(
                        RoundedRectangle(cornerRadius: 25)
                            .fill(
                                isDarkMode
                                    ? Color(white: 0.15).opacity(0.85) // Fondo gris oscuro suave
                                    : Color.white.opacity(0.85)        // Fondo blanco original
                            )
                            .shadow(color: isDarkMode ? .white.opacity(0.02) : .black.opacity(0.05), radius: 10)
                    )
                    .padding(.horizontal, 15)
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
