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
    @Published var availableChapters: [Int] = []
    
    // Mapeo corregido basado estrictamente en tu archivo biblia.json
    private let mapeoLibros: [String: String] = [
        "Génesis": "gn", "Éxodo": "ex", "Levítico": "lv", "Números": "nm", "Deuteronomio": "dt",
        "Josué": "js", "Jueces": "jg", "Rut": "rt", "1 Samuel": "1sa", "2 Samuel": "2sa",
        "1 Reyes": "1ki", "2 Reyes": "2ki", "1 Crónicas": "1ch", "2 Crónicas": "2ch",
        "Esdras": "ezr", "Nehemías": "ne", "Ester": "et", "Job": "jb", "Salmos": "ps",
        "Proverbios": "pr", "Eclesiastés": "ec", "Cantares": "ca", "Isaías": "is",
        "Jeremías": "jr", "Lamentaciones": "la", "Ezequiel": "ez", "Daniel": "da",
        "Oseas": "ho", "Joel": "jl", "Amós": "am", "Abdías": "ob", "Jonás": "jn",
        "Miqueas": "mi", "Nahúm": "na", "Habacuc": "hb", "Sofonías": "ze", "Hageo": "hg",
        "Zacarías": "zc", "Malaquías": "ml", "Mateo": "mt", "Marcos": "mk", "Lucas": "lk",
        "Juan": "jn", "Hechos": "ac", "Romanos": "ro", "1 Corintios": "1co", "2 Corintios": "2co",
        "Gálatas": "ga", "Efesios": "ep", "Filipenses": "ph", "Colosenses": "col",
        "1 Tesalonicenses": "1th", "2 Tesalonicenses": "2th", "1 Timoteo": "1ti",
        "2 Timoteo": "2ti", "Tito": "tit", "Filemón": "phm", "Hebreos": "he", "Santiago": "ja",
        "1 Pedro": "1pe", "2 Pedro": "2pe", "1 Juan": "1jo", "2 Juan": "2jo", "3 Juan": "3jo",
        "Judas": "jude", "Apocalipsis": "re"
    ]

    func getVerse(for bookName: String, chapter: Int = 1) async {
        self.isLoading = true
        self.errorMessage = nil
        
        guard let url = Bundle.main.url(forResource: "biblia", withExtension: "json") else {
            self.errorMessage = "Error: biblia.json no encontrado"
            self.isLoading = false
            return
        }
        
        do {
            let data = try Data(contentsOf: url)
            let libros = try JSONDecoder().decode([BibliaArchivo].self, from: data)
            
            // 1. Intentamos obtener la abreviatura del diccionario
            let abrevTarget = mapeoLibros[bookName]?.lowercased()
            
            // 2. Buscamos el libro en el JSON
            if let libro = libros.first(where: { $0.abbrev.lowercased() == abrevTarget }) {
                mostrarLibro(libro, bookName: bookName, chapter: chapter)
            } else {
                // 3. BUSQUEDA DE EMERGENCIA: Si no coincide el mapa, busca por texto contenido
                let normalizado = bookName.folding(options: .diacriticInsensitive, locale: .current).lowercased()
                if let libroEmergencia = libros.first(where: { normalizado.contains($0.abbrev.lowercased()) }) {
                    mostrarLibro(libroEmergencia, bookName: bookName, chapter: chapter)
                } else {
                    self.errorMessage = "No se encontró el libro: \(bookName)"
                }
            }
        } catch {
            self.errorMessage = "Error al leer datos"
        }
        self.isLoading = false
    }

    private func mostrarLibro(_ libro: BibliaArchivo, bookName: String, chapter: Int) {
        self.availableChapters = Array(1...libro.chapters.count)
        let index = chapter - 1
        if index >= 0 && index < libro.chapters.count {
            let versiculos = libro.chapters[index]
            let texto = versiculos.enumerated().map { "\($0 + 1) \($1)" }.joined(separator: " ")
            
            // Corrección de ortografía en tiempo real
            let textoCorregido = texto
                .replacingOccurrences(of: "crió", with: "creó")
                .replacingOccurrences(of: "Crió", with: "Creó")
            
            self.verse = BibleResponse(reference: "\(bookName) \(chapter)", text: textoCorregido)
        }
    }
}
