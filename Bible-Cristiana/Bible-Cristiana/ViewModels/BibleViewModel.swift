//
//  BibleViewModel.swift
//  Bible-Cristiana
//
//  Created by Alfonso Cruz Orozco on 20/04/26.
//

import Foundation
import SwiftUI // Es vital para que funcione @Published y ObservableObject

@MainActor
class BibleViewModel: ObservableObject {
    // Variables que la vista estará observando
    @Published var verse: BibleResponse?
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private let service = BibleService()

    // Diccionario completo de traducción para la API
    private let dictEspIng: [String: String] = [
        "Génesis": "Genesis", "Éxodo": "Exodus", "Levítico": "Leviticus", "Números": "Numbers",
        "Deuteronomio": "Deuteronomy", "Josué": "Joshua", "Jueces": "Judges", "Rut": "Ruth",
        "1 Samuel": "1 Samuel", "2 Samuel": "2 Samuel", "1 Reyes": "1 Kings", "2 Reyes": "2 Kings",
        "1 Crónicas": "1 Chronicles", "2 Crónicas": "2 Chronicles", "Esdras": "Ezra",
        "Nehemías": "Nehemiah", "Ester": "Esther", "Job": "Job", "Salmos": "Psalms",
        "Proverbios": "Proverbs", "Eclesiastés": "Ecclesiastes", "Cantares": "Song of Solomon",
        "Isaías": "Isaiah", "Jeremías": "Jeremiah", "Lamentaciones": "Lamentations",
        "Ezequiel": "Ezekiel", "Daniel": "Daniel", "Oseas": "Hosea", "Joel": "Joel",
        "Amós": "Amos", "Abdías": "Obadiah", "Jonás": "Jonah", "Miqueas": "Micah",
        "Nahúm": "Nahum", "Habacuc": "Habakkuk", "Sofonías": "Zephaniah", "Hageo": "Haggai",
        "Zacarías": "Zechariah", "Malaquías": "Malachi",
        "Mateo": "Matthew", "Marcos": "Mark", "Lucas": "Luke", "Juan": "John",
        "Hechos": "Acts", "Romanos": "Romans", "1 Corintios": "1 Corinthians", "2 Corintios": "2 Corinthians",
        "Gálatas": "Galatians", "Efesios": "Ephesians", "Filipenses": "Philippians", "Colosenses": "Colossians",
        "1 Tesalonicenses": "1 Thessalonians", "2 Tesalonicenses": "2 Thessalonians",
        "1 Timoteo": "1 Timothy", "2 Timoteo": "2 Timothy", "Tito": "Titus", "Filemón": "Philemon",
        "Hebreos": "Hebrews", "Santiago": "James", "1 Pedro": "1 Peter", "2 Pedro": "2 Peter",
        "1 Juan": "1 John", "2 Juan": "2 John", "3 Juan": "3 John", "Judas": "Jude", "Apocalipsis": "Revelation"
    ]

    func getVerse(for passage: String) async {
        isLoading = true
        errorMessage = nil
        
        // 1. Limpieza de texto: Pasamos todo a minúsculas para comparar sin errores
        var translatedPassage = passage
        
        // 2. Buscamos si el nombre en español está en el diccionario y lo cambiamos al inglés
        for (espanol, ingles) in dictEspIng {
            if passage.lowercased().contains(espanol.lowercased()) {
                translatedPassage = passage.lowercased().replacingOccurrences(of: espanol.lowercased(), with: ingles.lowercased())
                break
            }
        }

        do {
            // 3. Llamamos al servicio con el nombre que la API entiende (en inglés)
            let fetchedVerse = try await service.fetchVerse(passage: translatedPassage)
            self.verse = fetchedVerse
        } catch {
            print("DEBUG: Error al obtener datos: \(error)")
            self.errorMessage = "No se pudo cargar el contenido."
        }
        
        isLoading = false
    }
}
