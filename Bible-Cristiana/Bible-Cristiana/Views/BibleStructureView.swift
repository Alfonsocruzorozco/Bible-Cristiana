//
//  BibleStructureView.swift
//  Bible-Cristiana
//
//  Created by Alfonso Cruz Orozco on 28/04/26.
//

import SwiftUI

struct BibleStructureView: View {
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
            
            List {
                Section(header: Text("Antiguo Testamento").font(.headline).foregroundColor(.black)) {
                    Text("39 Libros").font(.subheadline).bold()
                    Text("Desde la creación hasta la preparación para el Mesías.")
                }
                .listRowBackground(Color.white.opacity(0.5)) // Color de la celda traslúcido
                
                Section(header: Text("Nuevo Testamento").font(.headline).foregroundColor(.black)) {
                    Text("27 Libros").font(.subheadline).bold()
                    Text("La vida de Jesús, el nacimiento de la iglesia y la promesa de su regreso.")
                }
                .listRowBackground(Color.white.opacity(0.5))
            }
            .scrollContentBackground(.hidden) // ESTO quita el fondo gris de la lista
        }
        .navigationTitle("Estructura")
    }
}
