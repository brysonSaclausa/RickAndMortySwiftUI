//
//  ContentView.swift
//  RickAndMortySwiftUI
//
//  Created by BrysonSaclausa on 7/13/21.
//

import SwiftUI

struct ContentView: View {
    private let url = "https://rickandmortyapi.com/api/character"
    
    @State private var characters = [Character]()
    
    func fetchData() {
        guard let url = URL(string: url) else {
            print("url not valid")
            return
        }
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let data = data {
                print("\(data)")
                if let decodedResult = try? JSONDecoder().decode(Results.self, from: data) {
                    DispatchQueue.main.async {
                        self.characters = decodedResult.results
                    }
                    return
                }
            }
            print("Error: \(error?.localizedDescription ?? "unknown error")")
        }.resume()
        
    }//
    
    var body: some View {
        
        List(characters, id: \.name) { (item) in
            HStack(alignment: .center) {
                Image(systemName: "").data(url: URL(string: "\(item.image)")!)
                    .frame(width: 90, height: 90, alignment: .center)
                    .clipShape(Circle())
                Text(item.name)
            }
        }.onAppear(perform: {
            fetchData()
        })
    }//
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
           
        }
    }
}
