//
//  DevotionalViewModel.swift
//  Bible-Cristiana
//
//  Created by Alfonso Cruz Orozco on 28/04/26.
//

import Foundation

// MODELO: Define la estructura exacta del JSON
struct DevocionalModel: Codable, Identifiable {
    let id: Int
    let fecha: String
    let titulo: String
    let versiculo: String
    let cita_texto: String // El texto bíblico
    let contenido: String  // La reflexión
    let oracion: String    // La oración final
}

class DevotionalViewModel: ObservableObject {
    @Published var devocionalDelDia: DevocionalModel?
    @Published var isLoading = false
    
    init() {
        cargarDevocional()
    }
    
    func cargarDevocional() {
        self.isLoading = true
        
        // Buscamos el archivo en el bundle principal
        guard let url = Bundle.main.url(forResource: "devocionales", withExtension: "json") else {
            print("Error: No se encontró el archivo devocionales.json")
            self.isLoading = false
            return
        }
        
        do {
            let data = try Data(contentsOf: url)
            let todosLosDevocionales = try JSONDecoder().decode([DevocionalModel].self, from: data)
            
            // Obtener fecha actual en formato YYYY-MM-DD
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            let hoyString = formatter.string(from: Date())
            
            DispatchQueue.main.async {
                // Busca por fecha, si no existe hoy, muestra el primero de la lista
                self.devocionalDelDia = todosLosDevocionales.first(where: { $0.fecha == hoyString }) ?? todosLosDevocionales.first
                self.isLoading = false
            }
            
        } catch {
            print("Error al procesar el JSON: \(error)")
            self.isLoading = false
        }
    }
}
