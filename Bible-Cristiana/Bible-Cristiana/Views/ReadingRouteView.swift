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
                VStack(alignment: .leading, spacing: 0) {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Plan de Inicio")
                            .font(.system(size: 32, weight: .bold, design: .rounded))
                        Text("Si es tu primera vez leyendo la Biblia, te sugerimos este orden para entender la historia de la salvación.")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    .padding()

                    VStack(alignment: .leading, spacing: 0) {
                        // Pasos del Timeline
                        StepRow(number: "1", title: "Evangelio de Juan", desc: "Conoce la vida, milagros y el propósito de Jesús.", isLast: false)
                        StepRow(number: "2", title: "Génesis", desc: "Entiende el origen de la creación y la promesa de Dios.", isLast: false)
                        StepRow(number: "3", title: "Hechos", desc: "La historia de cómo nació la iglesia y los primeros cristianos.", isLast: false)
                        StepRow(number: "4", title: "Romanos", desc: "Una explicación clara de la fe y la gracia.", isLast: true)
                    }
                    .padding()
                }
            }
        }
        .navigationTitle("Ruta")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct StepRow: View {
    let number: String
    let title: String
    let desc: String
    let isLast: Bool
    
    var body: some View {
        HStack(alignment: .top, spacing: 20) {
            VStack(spacing: 0) {
                Text(number)
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(.white)
                    .frame(width: 40, height: 40)
                    .background(Color.indigo)
                    .clipShape(Circle())
                    .shadow(color: .indigo.opacity(0.3), radius: 5)
                
                if !isLast {
                    Rectangle()
                        .fill(Color.indigo.opacity(0.3))
                        .frame(width: 4, height: 80)
                }
            }
            
            VStack(alignment: .leading, spacing: 8) {
                Text(title)
                    .font(.headline)
                
                Text(desc)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .lineLimit(3)
                
                // BOTÓN CONECTADO A LA BIBLIA
                // Aquí usamos NavigationLink para ir a BibleReadView
                NavigationLink(destination: BibleReadView()) {
                    RoundedRectangle(cornerRadius: 15)
                        .fill(Color.white.opacity(0.5))
                        .frame(height: 60)
                        .overlay(
                            HStack {
                                Image(systemName: "book.fill")
                                    .foregroundColor(.indigo)
                                Text("Comenzar a leer")
                                    .font(.caption.bold())
                                    .foregroundColor(.indigo)
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                            .padding(.horizontal)
                        )
                }
                .padding(.top, 5)
            }
            .padding(.bottom, isLast ? 0 : 30)
        }
    }
}
