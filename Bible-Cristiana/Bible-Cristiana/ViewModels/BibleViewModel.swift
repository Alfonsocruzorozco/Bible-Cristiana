//
//  BibleViewModel.swift
//  Bible-Cristiana
//
//  Created by Alfonso Cruz Orozco on 20/04/26.
//

import Foundation
import SwiftUI

struct VersiculoIndividual: Identifiable {
    let id: Int
    let numero: Int
    let contenido: String
}

@MainActor
class BibleViewModel: ObservableObject {
    @Published var verse: BibleResponse?
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var availableChapters: [Int] = []
    @Published var availableVerses: [Int] = []
    @Published var listaVersiculosProcesada: [VersiculoIndividual] = []

    // Diccionario de posiciones estándar para asegurar el tiro
    private let ordenLibros: [String: Int] = [
        "genesis": 0, "exodo": 1, "levitico": 2, "numeros": 3, "deuteronomio": 4,
        "josue": 5, "jueces": 6, "rut": 7, "1samuel": 8, "2samuel": 9,
        "1reyes": 10, "2reyes": 11, "1cronicas": 12, "2cronicas": 13,
        "esdras": 14, "nehemias": 15, "ester": 16, "job": 17, "salmos": 18,
        "proverbios": 19, "eclesiastes": 20, "cantares": 21, "isaias": 22,
        "jeremias": 23, "lamentaciones": 24, "ezequiel": 25, "daniel": 26,
        "oseas": 27, "joel": 28, "amos": 29, "abdias": 30, "jonas": 31,
        "miqueas": 32, "nahum": 33, "habacuc": 34, "sofonias": 35, "hageo": 36,
        "zacarias": 37, "malaquias": 38, "mateo": 39, "marcos": 40, "lucas": 41,
        "juan": 42, "hechos": 43, "romanos": 44, "1corintios": 45, "2corintios": 46,
        "galatas": 47, "efesios": 48, "filipenses": 49, "colosenses": 50,
        "1tesalonicenses": 51, "2tesalonicenses": 52, "1timoteo": 53,
        "2timoteo": 54, "tito": 55, "filemon": 56, "hebreos": 57, "santiago": 58,
        "1pedro": 59, "2pedro": 60, "1juan": 61, "2juan": 62, "3juan": 63,
        "judas": 64, "apocalipsis": 65
    ]

    func getVerse(for bookName: String, chapter: Int = 1) async {
        self.isLoading = true
        self.errorMessage = nil
        
        guard let url = Bundle.main.url(forResource: "biblia", withExtension: "json") else {
            self.errorMessage = "Error: No se encontró el archivo JSON"
            self.isLoading = false
            return
        }
        
        do {
            let data = try Data(contentsOf: url)
            let libros = try JSONDecoder().decode([BibliaArchivo].self, from: data)
            
            let busqueda = bookName.lowercased()
                .folding(options: .diacriticInsensitive, locale: .current)
                .replacingOccurrences(of: " ", with: "")
            
            // 1. INTENTO POR POSICIÓN (EL MÁS SEGURO)
            var libro: BibliaArchivo?
            if let indice = ordenLibros[busqueda], indice < libros.count {
                libro = libros[indice]
            }
            
            // 2. RESPALDO POR ABREVIATURA (SI EL ORDEN FALLA)
            if libro == nil {
                libro = libros.first { $0.abbrev.lowercased() == String(busqueda.prefix(2)) || busqueda.contains($0.abbrev.lowercased()) }
            }
            
            if let libroFinal = libro {
                self.availableChapters = Array(1...libroFinal.chapters.count)
                let idx = chapter - 1
                if idx >= 0 && idx < libroFinal.chapters.count {
                    let versos = libroFinal.chapters[idx]
                    self.availableVerses = Array(1...versos.count)
                    self.listaVersiculosProcesada = versos.enumerated().map { (i, t) in
                        VersiculoIndividual(id: i + 1, numero: i + 1, contenido: t)
                    }
                    self.verse = BibleResponse(reference: bookName, text: "OK")
                }
            } else {
                self.errorMessage = "No se pudo encontrar el libro: \(bookName)"
            }
        } catch {
            self.errorMessage = "Error al procesar los datos"
        }
        self.isLoading = false
    }
}
