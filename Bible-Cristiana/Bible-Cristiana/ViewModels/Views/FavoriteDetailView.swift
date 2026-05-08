//
//  FavoriteDetailView.swift
//  Bible-Cristiana
//
//  Created by Alfonso Cruz Orozco on 29/04/26.
//

import SwiftUI

struct FavoriteDetailView: View {
    let devocional: Devocional
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text(devocional.titulo)
                    .font(.largeTitle.bold())
                
                Text(devocional.versiculo)
                    .font(.title2)
                    .foregroundColor(.blue)
                
                Divider()
                
                Text(devocional.contenido)
                    .font(.body)
                    .lineSpacing(8)
            }
            .padding()
        }
        .navigationTitle("Detalle")
        .navigationBarTitleDisplayMode(.inline)
    }
}
