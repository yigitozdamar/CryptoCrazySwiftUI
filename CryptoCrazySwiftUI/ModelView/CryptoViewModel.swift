//
//  CryptoViewModel.swift
//  CryptoCrazySwiftUI
//
//  Created by Yigit Ozdamar on 23.08.2022.
//

import Foundation

@MainActor //Bunu yazınca Dispatchqueue yapmaya gerek kalmıyor. Ben kaldırmadım ama şu an
class CryptoListViewModel : ObservableObject{
    
    @Published var cryptoList = [CryptoViewModel]()
    
    let webservice = WebService()
    
    //İkinci Yöntem
    /*
    func downloadCryptosAsync(url:URL) async {
        do{
            let cryptos = try await webservice.downloadCurrenciesAsync(url: url)
            DispatchQueue.main.async {
                self.cryptoList = cryptos.map(CryptoViewModel.init)
            }
        }catch{
            print(error.localizedDescription)
        }
       
    }
    */
    
    // İlk Yönteme Continuation Ekleme (3. Yöntem)
    
    func downloadCryptosContinuation(url:URL) async {
        do{
            let cryptos = try await webservice.downloadCurrenciesContinuation(url: url)
            DispatchQueue.main.async {
                self.cryptoList = cryptos.map(CryptoViewModel.init)
            }
        }catch{
            print(error)
        }
        
    }
    
    //İlk Yöntem
    /*
    func downloadCryptos(url : URL) {
            webservice.downloadCurrencies(url: url, completion: { result in
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let cryptos):
                    if let cryptos = cryptos {
                        DispatchQueue.main.async {
                            self.cryptoList = cryptos.map(CryptoViewModel.init)
                            print("123")
                        }
                    }
                }
            })
        }
    */
}


struct CryptoViewModel {
    let crypto : CryptoCurrency
    
    var id : UUID? {
        crypto.id
    }
    
    var price : String {
        crypto.price
    }
    
    var currency : String {
        crypto.currency
    }
}
