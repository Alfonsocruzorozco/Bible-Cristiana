//
//  DevotionalsView.swift
//  Bible-Cristiana
//
//  Created by Alfonso Cruz Orozco on 20/04/26.
//

import SwiftUI

struct DevotionalsView: View {
    var body: some View {
        VStack {
            Image(systemName: "heart.text.square")
                .font(.system(size: 100))
                .foregroundColor(.red)
            Text("Sección de Devocionales")
                .font(.title)
            Text("Contenido próximamente...")
                .foregroundColor(.gray)
        }
        .navigationTitle("Devocionales")
    }
}
