//
//  Devocional.swift
//  Bible-Cristiana
//
//  Created by Alfonso Cruz Orozco on 29/04/26.
//

import Foundation

struct Devocional: Identifiable, Equatable, Codable {
    var id = UUID()
    let titulo: String
    let versiculo: String
    let contenido: String
    let fecha: Date
    let cita_texto: String
    var esFavorito: Bool
}
