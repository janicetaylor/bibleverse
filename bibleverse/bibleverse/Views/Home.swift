//
//  Home.swift
//  bibleverse
//
//  Created by Janice on 1/4/22.
//

import SwiftUI

struct Home: View {
    
    @State var randomVerse = [RandomResult]()
    var randomVerseUrl = "https://labs.bible.org/api/?passage=random&type=json"
    
    func updateViewIfToday() async {
        
        // needs help!
        await loadData(url: URL(string: randomVerseUrl)!)
        
        
//        let calendar = Calendar.current
//        var dateToCheck = Date()
//
//        if(UserDefaults.standard.object(forKey: "todayDate") == nil) {
//            dateToCheck = Date()
//            await loadData(url: URL(string: randomVerseUrl)!)
//            UserDefaults.standard.set(dateToCheck, forKey: "todayDate")
//        }
//        else {
//            dateToCheck = UserDefaults.standard.object(forKey: "todayDate") as! Date
//            if(!calendar.isDateInToday(dateToCheck)) {
//                await loadData(url: URL(string: randomVerseUrl)!)
//                UserDefaults.standard.set(dateToCheck, forKey: "todayDate")
//            }
//            else {
//                let decoded = UserDefaults.standard.data(forKey: "todayVerse")
//                randomVerse = NSKeyedUnarchiver.unarchiveObject(with: decoded!) as! [RandomResult]
//            }
//        }
    }
    
    func loadData(url:URL) async {
        do {
            print("task succeeded")
            let (data, _) = try await URLSession.shared.data(from: url)
            print(data)
            print(url)
            if let decodedResponse = try? JSONDecoder().decode([RandomResult].self, from: data) {
                    print(decodedResponse)
                    randomVerse = decodedResponse
                }
        } catch {
            print("Invalid verse data")
        }
    }
    
    var body: some View {
        
        NavigationView {
            List(randomVerse, id: \.bookname) { item in
                HStack {
                        VStack(alignment: .leading) {
                            Text(item.text)
                                .font(.largeTitle)
                            Spacer()
                            Text("\(item.bookname) \(item.chapter):\(item.verse)")
                                .font(.callout)
                                .foregroundColor(.gray)
                        }
                }
            }
        }
        .task {
            await updateViewIfToday()
        }
    }
}


struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home(randomVerse: randomTestData, randomVerseUrl: "https://labs.bible.org/api/?passage=random&type=json")
    }
}
