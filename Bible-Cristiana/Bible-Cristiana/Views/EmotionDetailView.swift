//
//  EmotionDetailView.swift
//  Bible-Cristiana
//
//  Created by Alfonso Cruz Orozco on 28/04/26.
//

import SwiftUI

struct EmotionDetailView: View {
    let emocion: String
    let icono: String
    let color: Color
    
    @State private var versoActual: VersoEmocional
    
    init(emocion: String, icono: String, color: Color) {
        self.emocion = emocion
        self.icono = icono
        self.color = color
        let lista = BancoDeVersiculos.datos[emocion] ?? []
        _versoActual = State(initialValue: lista.randomElement() ?? VersoEmocional(texto: "Cargando...", cita: ""))
    }
    
    var body: some View {
        ZStack {
            color.opacity(0.08).ignoresSafeArea()
            
            VStack(spacing: 25) {
                // Icono con diseño circular
                Image(systemName: icono)
                    .font(.system(size: 60))
                    .foregroundColor(color)
                    .padding(25)
                    .background(Circle().fill(.white).shadow(color: color.opacity(0.2), radius: 15))
                
                Text(emocion)
                    .font(.system(size: 32, weight: .bold, design: .rounded))
                
                // Tarjeta de Versículo con Animación
                VStack(spacing: 20) {
                    Image(systemName: "quote.opening")
                        .font(.largeTitle)
                        .foregroundColor(color.opacity(0.3))
                    
                    Text(versoActual.texto)
                        .font(.system(size: 22, weight: .medium, design: .serif))
                        .italic()
                        .multilineTextAlignment(.center)
                        .lineSpacing(4)
                        .id(versoActual.texto)
                        .transition(.asymmetric(
                            insertion: .opacity.combined(with: .move(edge: .trailing)),
                            removal: .opacity.combined(with: .move(edge: .leading))
                        ))
                    
                    Text(versoActual.cita)
                        .font(.headline)
                        .foregroundColor(color)
                        .padding(.top, 10)
                }
                .padding(35)
                .frame(maxWidth: .infinity)
                .background(
                    RoundedRectangle(cornerRadius: 35)
                        .fill(.white)
                        .shadow(color: .black.opacity(0.05), radius: 20)
                )
                .padding(.horizontal)
                
                Spacer()
                
                // Botón Profesional "Dame otra palabra"
                Button(action: {
                    withAnimation(.spring(response: 0.5, dampingFraction: 0.7)) {
                        obtenerNuevoVerso()
                    }
                }) {
                    HStack {
                        Image(systemName: "sparkles")
                        Text("Dame otra palabra")
                            .fontWeight(.bold)
                    }
                    .foregroundColor(.white)
                    .padding(.vertical, 18)
                    .padding(.horizontal, 40)
                    .background(color)
                    .cornerRadius(25)
                    .shadow(color: color.opacity(0.4), radius: 10, y: 5)
                }
                .padding(.bottom, 30)
            }
            .padding()
        }
        .navigationBarTitleDisplayMode(.inline)
    }
    
    func obtenerNuevoVerso() {
        if let lista = BancoDeVersiculos.datos[emocion] {
            let nuevaLista = lista.filter { $0.texto != versoActual.texto }
            if let nuevo = nuevaLista.randomElement() {
                versoActual = nuevo
            }
        }
    }
}

// MARK: - MODELO DE DATOS
struct VersoEmocional {
    let texto: String
    let cita: String
}

struct BancoDeVersiculos {
    static let datos: [String: [VersoEmocional]] = [
        "Sabiduría": [
            VersoEmocional(texto: "Si alguno de vosotros tiene falta de sabiduría, pídala a Dios, el cual da a todos abundantemente.", cita: "Santiago 1:5"),
            VersoEmocional(texto: "El principio de la sabiduría es el temor de Jehová; buen entendimiento tienen todos los que practican sus mandamientos.", cita: "Salmos 111:10"),
            VersoEmocional(texto: "Porque Jehová da la sabiduría, y de su boca viene el conocimiento y la inteligencia.", cita: "Proverbios 2:6")
        ],
        "Consuelo": [
            VersoEmocional(texto: "Bendito sea el Dios y Padre de nuestro Señor Jesucristo... el Dios de toda consolación.", cita: "2 Corintios 1:3"),
            VersoEmocional(texto: "Cercano está Jehová a los quebrantados de corazón; y salva a los contritos de espíritu.", cita: "Salmos 34:18"),
            VersoEmocional(texto: "Como aquel a quien consuela su madre, así os consolaré yo a vosotros.", cita: "Isaías 66:13")
        ],
        "Paz": [
            VersoEmocional(texto: "La paz os dejo, mi paz os doy; yo no os la doy como el mundo la da. No se turbe vuestro corazón.", cita: "Juan 14:27"),
            VersoEmocional(texto: "Y la paz de Dios, que sobrepasa todo entendimiento, guardará vuestros corazones.", cita: "Filipenses 4:7"),
            VersoEmocional(texto: "En paz me acostaré, y asimismo dormiré; porque solo tú, Jehová, me haces vivir confiado.", cita: "Salmos 4:8")
        ],
        "Fortaleza": [
            VersoEmocional(texto: "Todo lo puedo en Cristo que me fortalece.", cita: "Filipenses 4:13"),
            VersoEmocional(texto: "Jehová es mi fortaleza y mi escudo; en él confió mi corazón, y fui ayudado.", cita: "Salmos 28:7"),
            VersoEmocional(texto: "No temas, porque yo estoy contigo; no desmayes, porque yo soy tu Dios que te esfuerzo.", cita: "Isaías 41:10")
        ]
    ]
}
