//
//  ContentView.swift
//  bibleverse
//
//  Created by Janice on 1/2/22.
//

import SwiftUI

struct ContentView: View {
    
    var verses: [BibleVerse] = []
    
    var body: some View {
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
    }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(verses: testData)
    }
}
