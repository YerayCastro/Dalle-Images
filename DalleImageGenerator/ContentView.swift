//
//  ContentView.swift
//  DalleImageGenerator
//
//  Created by Yery Castro on 10/3/23.
//

import SwiftUI

struct ContentView: View {
    
    @State private var texto = ""
    @State private var imagen: UIImage? = nil
    @State private var cargador = false
    @StateObject var dalle = DalleViewModel()
    
    var body: some View {
        NavigationStack{
            VStack{
                TextField("Descripción", text: $texto)
                    .textFieldStyle(.roundedBorder)
                Button {
                    cargador = true
                    imagen = nil
                    
                    Task{
                        do{
                            let response = try await dalle.generarImagen(texto: texto)
                            if let url = response.data.map(\.url).first {
                                let (data,_) = try await URLSession.shared.data(from: url)
                                imagen = UIImage(data: data)
                                cargador = false
                            }
                        }catch{
                            print(error)
                        }
                    }
                    
                } label: {
                    Text("Generar")
                        .font(.title2)
                        .foregroundColor(.white)
                }
                .buttonStyle(.borderedProminent)
                .tint(.blue)
                
                if let imagen {
                    Image(uiImage: imagen)
                        .resizable()
                        .frame(width: 400,height: 400)
                    
                    Button("Guardar imagen"){
                        UIImageWriteToSavedPhotosAlbum(imagen, nil, nil, nil)
                    }
                } else {
                    if cargador {
                        ProgressView()
                    }
                }
                
                Spacer()
            }.padding(.all)
                .navigationTitle("DallE")
        }
    }
}


