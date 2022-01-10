//
//  Bible.swift
//  bibleverse
//
//  Created by Janice on 1/4/22.
//

import SwiftUI

struct BibleBook: View {
    let name: String

    var body: some View {
        Text("Selected: \(name)")
            .font(.largeTitle)
    }
}

struct Bible: View {
    
    var baseurl = "https://api.scripture.api.bible/v1/bibles"
    var bibleid = "de4e12af7f28f599-01"
    @State var loadedbooks = [Book]()
    let bookName: String

    var body: some View {
        
        NavigationView {
            List(loadedbooks, id: \.id) { item in
                HStack {
                        VStack(alignment: .leading) {
                            NavigationLink(destination: BibleBook(name: item.name)) {
                                               Text(item.name)
                            }
                            .foregroundColor(.white)
                            Spacer()
                            Text(item.nameLong)
                                .font(.caption)
                                .foregroundColor(.gray)
                           
                        }.padding()
                }
            }
            
        }
        .task {
            let bibleBooksUrl = "\(baseurl)/\(bibleid)/books"
            await loadData(url: bibleBooksUrl)
        }
        
    }
        
    func loadData(url: String) async {
        
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = [
            "api-key": "689984dd40f3c8dfce45b72f2f4a112f"
        ]
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let books = try JSONDecoder().decode(BookResponse.self, from: data!)
                
                for item in books.data {
                    let book = Book.init(id: item.id, bibleId: item.bibleId, abbreviation: item.abbreviation, name: item.name, nameLong: item.nameLong)
                    loadedbooks.append(book)
                }

            }
            catch let error as NSError {
                print(error.localizedDescription)
            }
        }
        
        task.resume()
    }
    
    
}


struct Bible_Previews: PreviewProvider {
    static var previews: some View {
       ContentView() 
    }
}


