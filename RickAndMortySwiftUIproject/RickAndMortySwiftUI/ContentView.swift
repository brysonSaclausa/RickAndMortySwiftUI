//
//  ContentView.swift
//  RickAndMortySwiftUI
//
//  Created by BrysonSaclausa on 7/13/21.
//

import SwiftUI


struct ContentView: View {

    var body: some View {
        NavigationView {
            TabView {
                Tab1()
                    .tabItem {
                        Text("Character")
                        Image(systemName: "person.circle.fill")
                    }
                Tab2()
                    .tabItem {
                        Text("Locations")
                        Image(systemName: "map.fill")
                    }
            }
            .navigationBarTitle("R&M SwiftUI")
        }
        
    }
}//

struct Tab1: View {
    private let url = "https://rickandmortyapi.com/api/character"
    @State private var characters = [Character]()
    
    func fetchCharacterData() {
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
        NavigationView {
            List (characters, id: \.name) { (item) in
                NavigationLink(
                    destination: CharacterDetailView(),
                    label: {
                        characterCell(characterSelected: item)
                    })
            }.onAppear(perform: {
                fetchCharacterData()
            })
            .navigationBarTitle("Characters")
        }
        
        
    }//
}

struct characterCell: View {
    var characterSelected: Character
    
    var body: some View {
        HStack(alignment: .center) {
            Image(systemName: "").data(url: URL(string: "\(characterSelected.image)")!)
                .frame(width: 60, height: 60, alignment: .leading)
                .clipShape(Circle())
            Text(characterSelected.name)
        }
   
    }
    
    
}


struct Tab2: View {
    var body: some View {
        Text("Locations")
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
           
        }
    }
}
