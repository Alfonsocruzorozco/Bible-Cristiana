//
//  BibleViewModel.swift
//  Bible-Cristiana
//
//  Created by Alfonso Cruz Orozco on 20/04/26.
//

import Foundation
import SwiftUI

@MainActor
class BibleViewModel: ObservableObject {
    @Published var verse: BibleResponse?
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    func getVerse(for bookName: String) async {
        self.isLoading = true
        self.errorMessage = nil
        
        // 1. Buscamos el archivo que descargaste (asegúrate que se llame biblia.json en Xcode)
        guard let url = Bundle.main.url(forResource: "biblia", withExtension: "json") else {
            self.errorMessage = "Error: No se encontró biblia.json"
            self.isLoading = false
            return
        }
        
        do {
            let data = try Data(contentsOf: url)
            let contenidoCompleto = try JSONDecoder().decode(BibliaArchivo.self, from: data)
            
            // 2. Filtramos todos los versículos que pertenezcan a ese libro
            let versiculosDelLibro = contenidoCompleto.verses.filter {
                $0.book_name.localizedCaseInsensitiveCompare(bookName) == .orderedSame
            }
            
            if !versiculosDelLibro.isEmpty {
                // Tomamos solo el capítulo 1 para mostrar por ahora
                let capitulo1 = versiculosDelLibro.filter { $0.chapter == 1 }
                let textoUnido = capitulo1.map { $0.text }.joined(separator: " ")
                
                self.verse = BibleResponse(reference: "\(bookName) 1", text: textoUnido)
            } else {
                self.errorMessage = "Libro no encontrado."
            }
        } catch {
            print("Error: \(error)")
            self.errorMessage = "Error al leer la base de datos local."
        }
        self.isLoading = false
    }
}
