//
//  BibleViewModel.swift
//  Bible-Cristiana
//
//  Created by Alfonso Cruz Orozco on 20/04/26.
//

import Foundation

import Foundation

// 'MainActor' asegura que los cambios de datos ocurran en el hilo principal (donde se dibuja la pantalla)
@MainActor
class BibleViewModel: ObservableObject {
    
    // @Published le avisa a la pantalla que debe redibujarse cuando estos datos cambien
    @Published var verse: BibleResponse?
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    // Instancia de nuestro servicio
    private let service = BibleService()
    
    // Función que llamaremos desde la vista
    func getVerse(for passage: String) async {
        isLoading = true
        errorMessage = nil
        
        do {
            // Intentamos traer el versículo
            let fetchedVerse = try await service.fetchVerse(passage: passage)
            self.verse = fetchedVerse
        } catch {
            // Si algo falla (ej. no hay internet), guardamos el error
            self.errorMessage = "No se pudo cargar el versículo. Revisa tu conexión."
        }
        
        isLoading = false
    }
}
