//
//  MenuView.swift
//  RayDownloaderApp
//
//  Created by Juan Andres Vasquez Ferrer on 08-10-21.
//

import SwiftUI

struct MenuView: View {
    
    let features: [String] = [
        "Listado de cursos ✅",
        "Paginación listado de cursos ✅",
        "Ver Detalle de un curso ✅",
        "Descargar un curso ✅",
        "Galeria de descarga ✅",
        "Abrir curso descargado en macOS ✅",
        "Abrir curso descargado en iOS 👷🏽‍♂️🔨",
        "Issue creación de carpeta una vez apretado el botón de descarga 👷🏽‍♂️🔨",
        "Reproducir un curso dentro de la app 👷🏽‍♂️🔨",
        "Search en listado de curso 👷🏽‍♂️🔨",
        "Habilitar descarga en HD 👷🏽‍♂️🔨",
        "Habilitar seteo de token de acceso custom 👷🏽‍♂️🔨",
        "Implementar Cache local con Realm 👷🏽‍♂️🔨",
        "Cache con KVS Usando Firebase 👷🏽‍♂️🔨",
        "Crear pantalla about US👷🏽‍♂️🔨"
    ]
    
    var body: some View {
        List {
            ForEach(features, id: \.self) {
                Text($0)
            }
        }
        
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
