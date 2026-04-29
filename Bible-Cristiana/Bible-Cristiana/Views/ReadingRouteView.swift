//
//  ReadingRouteView.swift
//  Bible-Cristiana
//
//  Created by Alfonso Cruz Orozco on 28/04/26.
//

import SwiftUI

struct ReadingRouteView: View {
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
            
            ScrollView {
                VStack(alignment: .leading, spacing: 25) {
                    Text("Tu Hoja de Ruta")
                        .font(.largeTitle.bold())
                    
                    VStack(alignment: .leading, spacing: 20) {
                        RouteStep(number: "1", title: "Evangelio de Juan", desc: "El mejor lugar para conocer el corazón de Jesús.")
                        RouteStep(number: "2", title: "Hechos", desc: "La aventura de los primeros cristianos.")
                        RouteStep(number: "3", title: "Génesis", desc: "Para entender el origen de todo.")
                        RouteStep(number: "4", title: "Romanos", desc: "La base de lo que creemos.")
                    }
                }
                .padding()
            }
        }
        .navigationTitle("Ruta")
    }
}

// ESTO ES LO QUE TE FALTA (Asegúrate de que esté FUERA de los corchetes de arriba)
struct RouteStep: View {
    let number: String
    let title: String
    let desc: String
    
    var body: some View {
        HStack(alignment: .top, spacing: 15) {
            Text(number)
                .font(.headline)
                .foregroundColor(.white)
                .padding(10)
                .background(Color.indigo)
                .clipShape(Circle())
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.headline)
                Text(desc)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
    }
}
