//
//  BibleService.swift
//  Bible-Cristiana
//
//  Created by Alfonso Cruz Orozco on 20/04/26.
//

import Foundation
/// Clase encargada de gestionar la conexión a internet para obtener datos bíblicos.
/// Se usa una 'class' porque es un servicio que realiza acciones.
class BibleService {
    /// Obtiene un versículo específico desde la API de bible-api.com.
        /// - Parameter passage: El pasaje que queremos buscar (ej: "Juan 3:16" o "Genesis 1:1").
        /// - Returns: Una estructura de tipo BibleResponse con los datos ya procesados.
        /// - Throws: Puede lanzar errores si la URL es inválida, si no hay internet o si el JSON no coincide.
    func fetchVerse (passage: String) async throws -> BibleResponse {
        // 1. FORMATEO DE LA URL
                // Las URLs no permiten espacios. 'addingPercentEncoding' convierte "Juan 3:16" en "Juan%203:16"
                // para que el navegador/servidor pueda entender la dirección correctamente.
        let urlString = "https://bible-api.com/\(passage)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        // 2. VALIDACIÓN DE LA URL
                // Intentamos crear un objeto URL a partir del texto. Si el texto está mal formado,
                // lanzamos un error de "Bad URL" inmediatamente.
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        // 3. PETICIÓN A INTERNET (REQUEST)
                // 'try' porque la conexión puede fallar (ej: modo avión).
                // 'await' porque la app debe esperar a que los datos bajen sin detener el resto de la interfaz.
                // URLSession.shared.data se encarga de ir a la web y traer los bytes de información.
        let (data, _) = try await URLSession.shared.data(from: url)
        // 4. TRADUCCIÓN DE DATOS (DECODING)
                // El servidor nos envía texto crudo (JSON). El JSONDecoder usa el protocolo 'Codable'
                // de nuestro modelo 'BibleResponse' para convertir ese texto en variables de Swift.
        let decoder = JSONDecoder()
        let response = try decoder.decode(BibleResponse.self, from: data)
        // 5. RETORNO DE RESULTADOS
                // Si todo salió bien, entregamos el objeto 'response' listo para ser usado en la pantalla.
        return response
    }
}
