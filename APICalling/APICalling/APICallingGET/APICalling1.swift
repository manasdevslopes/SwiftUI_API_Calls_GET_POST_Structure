//
//  APICalling1.swift
//  APICalling
//
//  Created by MANAS VIJAYWARGIYA on 09/12/21.
//

import SwiftUI

struct APICalling1: View {
    @State private var _results = [Result]()
    
    var body: some View {
        List(_results, id: \.trackId) { item in
            HStack {
                AsyncImage(url: URL(string: item.artworkUrl100)) {phase in
                    if let image = phase.image {
                        image
                            .resizable()
                            .scaledToFit()
                    } else if phase.error != nil {
                        Text("There was an error loading the image.")
                    } else {
                        ProgressView()
                    }
                }
                .frame(width: 65, height: 65)
                
                VStack(alignment: .leading) {
                    Text(item.trackName)
                        .font(.headline)
                    Text(item.collectionName)
                }
                .padding(.leading, 8)
            }
        }
        .task {
            await loadData()
        }
    }
    
    func loadData() async {
        guard let url = URL(string: "https://itunes.apple.com/search?term=taylor+swift&entity=song") else {
            print("Invalid URL")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let decodedResponse = try? JSONDecoder().decode(Response.self, from: data) {
                _results = decodedResponse.results
                print("DATA------->", decodedResponse.results)
            }
        } catch {
            print("Invalid data")
        }
    }
}

struct APICalling1_Previews: PreviewProvider {
    static var previews: some View {
        APICalling1()
    }
}
