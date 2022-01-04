//
//  ContentView.swift
//  bibleverse
//
//  Created by Janice on 1/2/22.
//

import SwiftUI

struct SecondView: View {
    var body: some View {
        Text("This is the detail view")
    }
}

struct ContentView: View {

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
        
        let drag = DragGesture()
            .onEnded {
                if $0.translation.width < -100 {
                    withAnimation {
                        self.showMenu = false
                    }
                }
            }
        
        return NavigationView {
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    MainView(showMenu: self.$showMenu)
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .offset(x: self.showMenu ? geometry.size.width/2 : 0)
                    .disabled(self.showMenu ? true : false)
                    if self.showMenu {
                        MenuView()
                            .frame(width: geometry.size.width/2)
                            .transition(.move(edge: .leading))
                    }
                    }.gesture(drag)
            }
            .navigationBarTitle("Verses", displayMode: .inline)
            .navigationBarItems(leading: (
                                    Button(action: {
                                        withAnimation {
                                            self.showMenu.toggle()
                                        }
                                    }) {
                                        Image(systemName: "line.horizontal.3")
                                            .imageScale(.large)
                                            .foregroundColor(.gray)
                                    }
                                ))
        }

        
        
//        HStack {
//            NavigationView {
//
//                VStack {
//
//
//
//
//                    HStack {
//                        TextField("Type to Search", text: $searchWord)
//                        Button("Search") {
//                            Task {
//                                let urlToLoad = URL(string: "http://api.biblia.com/v1/bible/search/LEB.txt?query=\(searchWord)&mode=verse&start=0&limit=20&key=\(apikey)")
//                                await loadData(url: urlToLoad!)
//                            }
//                        }
//                    }
//                    .padding(.horizontal, 20.0)
//
//                    List(verses, id: \.title) { item in
//                        VStack(alignment: .leading) {
//                            Text(item.title)
//                                .font(.headline)
//                                .foregroundColor(Color.gray)
//
//                            Text(item.preview)
//                                .font(.subheadline)
//                                .foregroundColor(Color.gray)
//                        }
//                    }.navigationBarTitle(Text("Verses"))
//                        .task {
//                            let urlToLoad = URL(string: "http://api.biblia.com/v1/bible/search/LEB.txt?query=\(defaultSearch)&mode=verse&start=0&limit=20&key=\(apikey)")
//                            await loadData(url: urlToLoad!)
//                        }
//                }
//
//            }
//        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
          ContentView(verses: testData)
        }
    }
}


struct MainView: View {
    
    @Binding var showMenu: Bool
    
    var body: some View {
        Button(action: {
            print("Open the side menu")
            self.showMenu = true
        }) {
            Text("Show Menu")
        }
    }
}
