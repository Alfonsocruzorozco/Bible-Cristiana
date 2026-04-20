//
//  BibleReadView.swift
//  Bible-Cristiana
//
//  Created by Alfonso Cruz Orozco on 20/04/26.
//

import SwiftUI

struct BibleReadView: View {
    var body: some View {
        List {
            Section(header: Text("Antiguo Testamento")) {
                ForEach(BibleStructure.antiguoTestamento, id: \.self) { libro in
                    NavigationLink(destination: BookDetailView(bookName: libro)) {
                        Label(libro, systemImage: "book.closed")
                    }
                }
            }
            
            Section(header: Text("Nuevo Testamento")) {
                ForEach(BibleStructure.nuevoTestamento, id: \.self) { libro in
                    NavigationLink(destination: BookDetailView(bookName: libro)) {
                        Label(libro, systemImage: "book.fill")
                            .foregroundColor(.blue)
                    }
                }
            }
        }
        .navigationTitle("Libros de la Biblia")
    }
}
