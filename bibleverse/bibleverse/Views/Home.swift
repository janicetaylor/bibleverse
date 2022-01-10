//
//  Home.swift
//  bibleverse
//
//  Created by Janice on 1/4/22.
//

import SwiftUI

struct Home: View {
    
    @State var randomVerse = [RandomResult]()
    
    var userData = UserData()
    var randomVerseUrl = "https://labs.bible.org/api/?passage=votd&type=json"
    let userDefaultsVerseKey = "randomverse"
    
    func updateViewIfToday() async {
        
        // never opened app before
        if(UserDefaults.standard.object(forKey: "todayDate") == nil) {
            UserDefaults.standard.set(Date(), forKey: "todayDate")
            await loadData(url: URL(string: randomVerseUrl)!)
            return
        }
        
        // is today the same day as the last time we opened app?
        let olderDate = UserDefaults.standard.object(forKey: "todayDate") as! Date
        let now = Date()
        let isSameDate = Calendar.current.isDate(now, inSameDayAs: olderDate)
        
        if(isSameDate) {
            // already loaded, don't do anything
            // if object is empty for some reason
            if(randomVerse.count == 0) {
                if(UserDefaults.standard.object(forKey: userDefaultsVerseKey) == nil) {
                    await loadData(url: URL(string: randomVerseUrl)!)
                    return
                }
                else {
                    randomVerse = userData.getVerse()
                }
            }
        }
        else {
            await loadData(url: URL(string: randomVerseUrl)!)
        }
    }
    
    func loadData(url:URL) async {
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let decodedResponse = try? JSONDecoder().decode([RandomResult].self, from: data) {
                    randomVerse = decodedResponse
                    
                    let verseToSave = [RandomResult(bookname: decodedResponse[0].bookname, chapter: decodedResponse[0].chapter, verse: decodedResponse[0].verse, text: decodedResponse[0].text)]
                    userData.saveVerse(verse: verseToSave)
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
                .padding()
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
