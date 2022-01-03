//
//  ContentView.swift
//  bibleverse
//
//  Created by Janice on 1/2/22.
//

import SwiftUI

struct ContentView: View {
    
    // http://api.biblia.com/v1/bible/search/LEB.txt?query=bread&mode=verse&start=0&limit=20&key=fd37d8f28e95d3be8cb4fbc37e15e18e
    
    var verses: [BibleVerse] = []
    
    @State private var searchWord = "search word"
    
    var body: some View {
        
        HStack {
           
            NavigationView {
               
                VStack {
                    
                    HStack {
                        TextField("Search word", text: $searchWord)
                            .padding(.leading, 20.0)
                        Button(/*@START_MENU_TOKEN@*/"Button"/*@END_MENU_TOKEN@*/) {
                            print("test")
                        }
                        .padding(.trailing, 20.0)
                    }
                    
                    List(verses) { item in
                        Image(systemName: "photo")
                        VStack(alignment: .leading) {
                            Text(item.title)
                                    .font(.headline)
                                    .foregroundColor(Color.gray)
                                   
                            Text(item.verse)
                                    .font(.subheadline)
                                    .foregroundColor(Color.gray)
                                
                        }
                    }.navigationBarTitle(Text("Verses"))
                }
                
            }
           
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView(verses: testData)
        }
    }
}
