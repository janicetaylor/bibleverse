//
//  Search.swift
//  bibleverse
//
//  Created by Janice on 1/4/22.
//

import SwiftUI

struct Search: View {
    
    @State var verses = [Result]()
    @State var searchWord = ""
    @State var showMenu = false

    var apikey = "c2d68419edd19a8fc2207c9976c46896"
    var defaultSearch = "angels"

    func loadData(url:URL) async {
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
                if let decodedResponse = try? JSONDecoder().decode(Response.self, from: data) {
                    verses = decodedResponse.results
                }
        } catch {
            print("Invalid data")
        }
    }
    
    var body: some View {
        
        HStack {
            NavigationView {
                VStack {
                    HStack {
                        TextField("Type to Search", text: $searchWord)
                        Button("Search") {
                            Task {
                                let urlToLoad = URL(string: "http://api.biblia.com/v1/bible/search/LEB.txt?query=\(searchWord)&mode=verse&start=0&limit=20&key=\(apikey)")
                                await loadData(url: urlToLoad!)
                            }
                        }
                    }
                    .padding(.horizontal, 20.0)

                    List(verses, id: \.title) { item in
                        VStack(alignment: .leading) {
                            Text(item.title)
                                .font(.headline)
                                .foregroundColor(Color.gray)

                            Text(item.preview)
                                .font(.subheadline)
                                .foregroundColor(Color.gray)
                        }
                    }.navigationBarTitle(Text("Verses"))
                        .task {
                            let urlToLoad = URL(string: "http://api.biblia.com/v1/bible/search/LEB.txt?query=\(defaultSearch)&mode=verse&start=0&limit=20&key=\(apikey)")
                            await loadData(url: urlToLoad!)
                        }
                }
            }
        }
    }
}


struct Search_Previews: PreviewProvider {
    static var previews: some View {
        Search()
    }
}

