//
//  BibleModel.swift
//  Bible-Cristiana
//
//  Created by Alfonso Cruz Orozco on 20/04/26.
//

import Foundation

// Este modelo coincide exactamente con tu captura de pantalla
struct BibliaArchivo: Codable {
    let verses: [VersiculoCompleto]
}

struct VersiculoCompleto: Codable {
    let book_name: String
    let chapter: Int
    let verse: Int
    let text: String
}

// Lo que la vista sigue usando para no romperse
struct BibleResponse: Codable {
    let reference: String
    let text: String
}
