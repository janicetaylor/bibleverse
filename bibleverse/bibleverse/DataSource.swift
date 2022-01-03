//
//  DataSource.swift
//  bibleverse
//
//  Created by Janice on 1/3/22.
//

import Foundation

// http://api.biblia.com/v1/bible/search/LEB.txt?query=bread&mode=verse&start=0&limit=20&key=fd37d8f28e95d3be8cb4fbc37e15e18e

class DataSource: ObservableObject {
    
    var apikey = "c2d68419edd19a8fc2207c9976c46896"
    
    var searchterm = "goat"
    @Published var items = [BibleVerse]()
    
    init() {
        let url = URL(string: "http://api.biblia.com/v1/bible/search/LEB.txt?query=\(searchterm)&mode=verse&start=0&limit=20&key=\(apikey)")!
        
        URLSession.shared.dataTask(with: url) {(data, response, error) in
                    do {
                        if let itemsData = data {
                            let decodedData = try JSONDecoder().decode([BibleVerse].self, from: itemsData)
                            DispatchQueue.main.async {
                                self.items = decodedData
                            }
                        } else {
                            print("No data")
                        }
                    } catch {
                        print("Error")
                    }
                }.resume()
    
    }
    
}




