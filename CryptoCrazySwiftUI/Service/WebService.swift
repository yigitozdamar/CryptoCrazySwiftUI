//
//  WebService.swift
//  CryptoCrazySwiftUI
//
//  Created by Yigit Ozdamar on 23.08.2022.
//

import Foundation

class WebService{
    
    //İkinci Yöntem async/await
    /*
    func downloadCurrenciesAsync(url: URL) async throws -> [CryptoCurrency] {
        
        let (data,response) = try await URLSession.shared.data(from: url)
        let currencies = try? JSONDecoder().decode([CryptoCurrency].self, from: data)
        return currencies ?? []
    }
    */
    
    //ilk yöntemi continuation ile async yapma(3. Yöntem)
    
    func downloadCurrenciesContinuation(url: URL) async throws -> [CryptoCurrency] {
        
        try await withCheckedThrowingContinuation({ continuation in
            
            downloadCurrencies(url: url) { result in
                switch result{
                case .success(let cryptos):
                    continuation.resume(returning: cryptos ?? [])
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
            
        })
    }
    
    
    
    
    //İlk yöntem (eski)
    
    func downloadCurrencies(url:URL, completion: @escaping (Result<[CryptoCurrency]?,DownloadedError>) -> Void){
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
                completion(.failure(.badUrl))
            }
            guard let data = data, error == nil else {
                return completion(.failure(.noData))
            }
            guard let currencies = try? JSONDecoder().decode([CryptoCurrency].self, from: data) else {
                return completion(.failure(.dataParseError))
            }
            
            completion(.success(currencies))

        }.resume()
     
    }
     
}

enum DownloadedError : Error{
    case badUrl
    case noData
    case dataParseError
}
