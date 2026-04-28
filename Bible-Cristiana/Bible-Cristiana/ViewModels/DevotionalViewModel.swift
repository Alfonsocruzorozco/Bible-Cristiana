//
//  DevotionalViewModel.swift
//  Bible-Cristiana
//
//  Created by Alfonso Cruz Orozco on 28/04/26.
//

import Foundation

// ESTO ES LO QUE FALTA: La definición del modelo debe estar aquí
struct DevocionalModel: Codable, Identifiable {
    let id: Int
    let fecha: String
    let titulo: String
    let versiculo: String
    let cita_texto: String
    let contenido: String
    let oracion: String
}

class DevotionalViewModel: ObservableObject {
    @Published var devocionalDelDia: DevocionalModel?
    @Published var todosLosDevocionales: [DevocionalModel] = []
    @Published var favoritosIds: [Int] {
        didSet {
            UserDefaults.standard.set(favoritosIds, forKey: "mis_favoritos_ids")
        }
    }
    
    init() {
        self.favoritosIds = UserDefaults.standard.array(forKey: "mis_favoritos_ids") as? [Int] ?? []
        cargarDatos()
    }
    
    func cargarDatos() {
        guard let url = Bundle.main.url(forResource: "devocionales", withExtension: "json"),
              let data = try? Data(contentsOf: url) else { return }
        
        do {
            let decodificados = try JSONDecoder().decode([DevocionalModel].self, from: data)
            DispatchQueue.main.async {
                self.todosLosDevocionales = decodificados
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-MM-dd"
                let hoyString = formatter.string(from: Date())
                self.devocionalDelDia = decodificados.first(where: { $0.fecha == hoyString }) ?? decodificados.first
            }
        } catch {
            print("Error: \(error)")
        }
    }
    
    func toggleFavorito(id: Int) {
        if favoritosIds.contains(id) {
            favoritosIds.removeAll { $0 == id }
        } else {
            favoritosIds.append(id)
        }
    }
    
    var listaFavoritos: [DevocionalModel] {
        return todosLosDevocionales.filter { favoritosIds.contains($0.id) }
    }
}
