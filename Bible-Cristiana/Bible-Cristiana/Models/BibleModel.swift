//
//  BibleModel.swift
//  Bible-Cristiana
//
//  Created by Alfonso Cruz Orozco on 20/04/26.
//

import Foundation

//Representa un versiculo
struct Verse: Codable, Identifiable {
    let id: Int //Un numero unico para que swift no se confunda.
    let bookname: String //Nombre del libro
    let chapter: Int //Numero de capitulo
    let number: Int //Numero del versiculo
    let text: String //El mensaje
}

//Representa un capitulo
struct Chapter: Codable, Identifiable {
    let id: Int //Numero unico para cada capitulo
    let number: Int //Numero del capitulo
    let verses: [Verse] // Esto es un array o lista de versiculos
}

//Representa un libro
struct Book: Codable, Identifiable {
    let id: Int //Numero de cada libro
    let name: String //Nombre de capitulo
    let chapters: [Chapter] //Lista de capitulos
}
