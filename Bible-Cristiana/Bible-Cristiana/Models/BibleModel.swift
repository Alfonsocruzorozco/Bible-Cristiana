//
//  BibleModel.swift
//  Bible-Cristiana
//
//  Created by Alfonso Cruz Orozco on 20/04/26.
//

import Foundation

import Foundation

// 1. Definimos la estructura que recibirá los datos de internet.
// Usamos 'BibleResponse' porque es el nombre que pusimos en el Service.
struct BibleResponse: Codable {
    let reference: String       // El nombre del pasaje (ej: Juan 3:16)
    let text: String            // El contenido del versículo
    let translationName: String  // El nombre de la versión de la Biblia
    
    // 2. CodingKeys: Es el "traductor".
    // La API nos envía 'translation_name', pero en Swift preferimos 'translationName'.
    enum CodingKeys: String, CodingKey {
        case reference
        case text
        case translationName = "translation_name"
    }
}
