//
//  DevotionalViewModel.swift
//  Bible-Cristiana
//
//  Created by Alfonso Cruz Orozco on 28/04/26.
//

import Foundation
import SwiftUI

class DevotionalViewModel: ObservableObject {
    @Published var listaFavoritos: [Devocional] = [] {
        didSet { guardarFavoritos() }
    }
    
    @Published var devocionalDelDia: Devocional = Devocional(
        titulo: "Caminar en Confianza",
        versiculo: "Salmos 23:1",
        contenido: "Jehová es mi pastor; nada me faltará. En lugares de delicados pastos me hará descansar; junto a aguas de reposo me pastoreará.",
        fecha: Date(),
        cita_texto: "El Señor es quien me guía y me provee de todo lo necesario.",
        esFavorito: false
    )
    
    @Published var devocionalActualEmocion: Devocional = Devocional(
        titulo: "Encuentra Paz",
        versiculo: "Juan 14:27",
        contenido: "La paz os dejo, mi paz os doy; yo no os la doy como el mundo la da.",
        fecha: Date(),
        cita_texto: "No se turbe vuestro corazón.",
        esFavorito: false
    )
    
    private let llaveFavoritos = "lista_favoritos_key"

    init() {
        cargarFavoritos()
        actualizarEstados()
    }
    
    func guardarFavoritos() {
        if let encoded = try? JSONEncoder().encode(listaFavoritos) {
            UserDefaults.standard.set(encoded, forKey: llaveFavoritos)
        }
    }
    
    func cargarFavoritos() {
        if let data = UserDefaults.standard.data(forKey: llaveFavoritos),
           let decoded = try? JSONDecoder().decode([Devocional].self, from: data) {
            self.listaFavoritos = decoded
        }
    }

    func toggleFavorito(para devocional: Devocional) {
        if let index = listaFavoritos.firstIndex(where: { $0.titulo == devocional.titulo }) {
            listaFavoritos.remove(at: index)
        } else {
            var nuevoFav = devocional
            nuevoFav.esFavorito = true
            listaFavoritos.append(nuevoFav)
        }
        actualizarEstados()
    }

    func esFavorito(devocional: Devocional) -> Bool {
        listaFavoritos.contains(where: { $0.titulo == devocional.titulo })
    }

    func actualizarEstados() {
        devocionalDelDia.esFavorito = esFavorito(devocional: devocionalDelDia)
        devocionalActualEmocion.esFavorito = esFavorito(devocional: devocionalActualEmocion)
    }
    
    func eliminarDeFavoritos(at offsets: IndexSet) {
        listaFavoritos.remove(atOffsets: offsets)
        actualizarEstados()
    }

    func generarNuevoDevocionalParaEmocion(emocion: String) {
        let nuevos = [
            Devocional(titulo: "Fortaleza en \(emocion)", versiculo: "Isaías 41:10", contenido: "No temas, porque yo estoy contigo; no desmayes, porque yo soy tu Dios...", fecha: Date(), cita_texto: "Yo soy tu Dios que te esfuerzo.", esFavorito: false),
            Devocional(titulo: "Victoria sobre \(emocion)", versiculo: "Romanos 8:37", contenido: "Antes, en todas estas cosas somos más que vencedores por medio de aquel que nos amó.", fecha: Date(), cita_texto: "Somos más que vencedores.", esFavorito: false)
        ]
        self.devocionalActualEmocion = nuevos.randomElement() ?? nuevos[0]
        actualizarEstados()
    }
}
