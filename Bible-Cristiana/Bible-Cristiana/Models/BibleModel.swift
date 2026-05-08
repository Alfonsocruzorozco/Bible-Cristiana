//
//  BibleModel.swift
//  Bible-Cristiana
//
//  Created by Alfonso Cruz Orozco on 20/04/26.
//

import Foundation

struct BibliaArchivo: Codable {
    let abbrev: String
    let chapters: [[String]]
}

struct BibleResponse: Codable {
    let reference: String
    let text: String
}
