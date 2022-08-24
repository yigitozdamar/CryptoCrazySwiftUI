//
//  ContentView.swift
//  CryptoCrazySwiftUI
//
//  Created by Yigit Ozdamar on 23.08.2022.
//

import SwiftUI

struct MainView: View {
    
    @ObservedObject var cryptoListViewModel : CryptoListViewModel
    
    init() {
        self.cryptoListViewModel = CryptoListViewModel()
    }
    
    var body: some View {
       
        NavigationView{
            List(cryptoListViewModel.cryptoList,id:\.id){
                crypto in
                VStack{
                    Text(crypto.currency).font(.title3).foregroundColor(.blue)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text(crypto.price)
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                
            }
            .toolbar(content: {
                Button {
                    Task.init{
                        await cryptoListViewModel.downloadCryptosContinuation(url: URL(string: "https://api.nomics.com/v1/currencies/ticker?key=7be215d9b4e56f64cf04177e17ced018ff1f920a")!)
                    }
                } label: {
                    Text("Refresh")
                }

            })
            .navigationTitle("Crypto Crazy")
        }
        .task {
            
            //3.yöntem continuation
            
            await cryptoListViewModel.downloadCryptosContinuation(url: URL(string: "https://api.nomics.com/v1/currencies/ticker?key=7be215d9b4e56f64cf04177e17ced018ff1f920a")!)
            
            //İkinci yöntem
            /*
            await cryptoListViewModel.downloadCryptosAsync(url: URL(string: "https://api.nomics.com/v1/currencies/ticker?key=7be215d9b4e56f64cf04177e17ced018ff1f920a")!)
             */
        }
        //ilk Yöntem
        /*
        .onAppear{
            cryptoListViewModel.downloadCryptos(url: URL(string: "https://api.nomics.com/v1/currencies/ticker?key=7be215d9b4e56f64cf04177e17ced018ff1f920a")!)
        }
         */

        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            MainView()
        }
    }
}
