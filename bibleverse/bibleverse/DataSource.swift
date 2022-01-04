//
//  DataSource.swift
//  bibleverse
//
//  Created by Janice on 1/3/22.
//

import Foundation
import SwiftUI

// http://api.biblia.com/v1/bible/search/LEB.txt?query=bread&mode=verse&start=0&limit=20&key=fd37d8f28e95d3be8cb4fbc37e15e18e

class DataSource: ObservableObject {
    
    var apikey = "c2d68419edd19a8fc2207c9976c46896"
    
    @State var searchWord = "goat"
    @Published var items = [Result]()
    @Published var results = []

    func loadData() async {
        guard let url = URL(string: "http://api.biblia.com/v1/bible/search/LEB.txt?query=\(searchWord)&mode=verse&start=0&limit=20&key=\(apikey)") else {
            print("Invalid URL")
            return
        }
        print(url)
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            print("Task completed")

            guard let data = data, error == nil else {
                print(error?.localizedDescription)
                return
            }
            
            print(data)
                       
            if let jsonString = String(data: data, encoding: .utf8) {
               // print(jsonString)
            }
            
            do {
                let result = try JSONDecoder().decode(Response.self, from: data)
                print(result)
                print("----")
                // print(result.results)
                print("----")
                print(result.results.count)
                print("----")
                print(result.results[0].title)
                self.items = result.results
                self.results = result.results
                } catch let error {
                    print(error.localizedDescription)
            }
            
          }.resume()
            
    }
    
    
    init() {
    }
    
}




