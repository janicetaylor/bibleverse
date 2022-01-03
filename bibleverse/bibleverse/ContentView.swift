//
//  ContentView.swift
//  bibleverse
//
//  Created by Janice on 1/2/22.
//

import SwiftUI

struct ContentView: View {

    var verses: [BibleVerse] = []
    
    @ObservedObject var fetchData = DataSource()

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
