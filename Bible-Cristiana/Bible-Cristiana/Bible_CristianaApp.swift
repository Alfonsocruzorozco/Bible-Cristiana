//
//  Bible_CristianaApp.swift
//  Bible-Cristiana
//
//  Created by Alfonso Cruz Orozco on 20/04/26.
//

import SwiftUI

@main
struct Bible_CristianaApp: App {
    @StateObject var viewModel = DevotionalViewModel()
    
    // --- NUEVO ---
    // Guardamos la preferencia del tema en el dispositivo.
    // "false" es Modo Claro (por defecto), "true" es Modo Oscuro.
    @AppStorage("isDarkMode") private var isDarkMode = false
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
                // --- NUEVO ---
                // Aplicamos el esquema de color preferido a toda la app
                .preferredColorScheme(isDarkMode ? .dark : .light)
        }
    }
}
