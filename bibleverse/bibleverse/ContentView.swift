//
//  ContentView.swift
//  bibleverse
//
//  Created by Janice on 1/2/22.
//

import SwiftUI

struct ContentView: View {

    var verses: [BibleVerse] = [BibleVerse]()
    
    @ObservedObject var datasource = DataSource()
    
    var body: some View {
        HStack {
            NavigationView {
                VStack {
                    HStack {
                        TextField("Search", text: $datasource.searchWord)
                        Button(/*@START_MENU_TOKEN@*/"Button"/*@END_MENU_TOKEN@*/) {
                            print("test")
                            print($datasource.items.count)
                        }
                    }
                            
                    List(verses, id: \.id) { item in
                        VStack(alignment: .leading) {
                            Text(item.title)
                                .font(.headline)
                                .foregroundColor(Color.gray)
                                       
                            Text(item.verse)
                                .font(.subheadline)
                                .foregroundColor(Color.gray)
                        }
                    }.navigationBarTitle(Text("Verses"))
                        .task {
                            await DataSource().loadData()
                        }
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
