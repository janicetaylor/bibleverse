//
//  ContentView.swift
//  bibleverse
//
//  Created by Janice on 1/2/22.
//

import SwiftUI

struct ContentView: View {

    @ObservedObject var datasource = DataSource()
    // var verses = testData
    @State private var verses = [Result]()
    
    var apikey = "c2d68419edd19a8fc2207c9976c46896"
    @State var searchWord = "goat"
    
    func loadData(url:URL) async {
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
                if let decodedResponse = try? JSONDecoder().decode(Response.self, from: data) {
                    verses = decodedResponse.results
                }
            // more code to come
        } catch {
            print("Invalid data")
        }
    }
    
    var body: some View {
        HStack {
            NavigationView {
                VStack {
                    HStack {
                        TextField("Search", text: $datasource.searchWord)
                        Button(/*@START_MENU_TOKEN@*/"Button"/*@END_MENU_TOKEN@*/) {
                            print("button press")
                        }
                    }
                            
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
                            let urlToLoad = URL(string: "http://api.biblia.com/v1/bible/search/LEB.txt?query=\(searchWord)&mode=verse&start=0&limit=20&key=\(apikey)")
                            await loadData(url: urlToLoad!)
                        }
                }
                
            }
           
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
          //  ContentView(verses: testData)
        }
    }
}
