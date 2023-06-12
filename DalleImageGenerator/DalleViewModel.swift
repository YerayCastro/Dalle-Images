//
//  DalleViewModel.swift
//  DalleImageGenerator
//
//  Created by Yery Castro on 10/3/23.
//

import Foundation


class DalleViewModel: ObservableObject {
    
    let session = UUID().uuidString
    
    func generarImagen(texto: String) async throws -> ImageModel {
        guard let url = URL(string: "https://api.openai.com/v1/images/generations") else { throw ImageError.badUrl }
        
        let parametros: [String: Any] = [
            "prompt": texto,
            "n": 1,
            "size": "1024x1024",
            "user": session
        ]
        
        let data: Data = try JSONSerialization.data(withJSONObject: parametros)
        let apikey = "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"
        var request = URLRequest(url: url)
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(apikey)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "POST"
        request.httpBody = data
        
        let (response, _) = try await URLSession.shared.data(for: request)
        let result = try JSONDecoder().decode(ImageModel.self, from: response)
        return result
        
        
    }
    
}

enum ImageError: Error{
    case badUrl
}
