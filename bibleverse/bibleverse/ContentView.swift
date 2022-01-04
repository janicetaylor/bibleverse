//
//  ContentView.swift
//  bibleverse
//
//  Created by Janice on 1/2/22.
//

import SwiftUI

struct ContentView: View {

    @ObservedObject var datasource = DataSource()
    var verses: [Result] = DataSource().items
    
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
                            await DataSource().loadData()
                            print(DataSource().items.count)
                            print(DataSource().results.count)
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
