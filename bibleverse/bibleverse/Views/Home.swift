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
        
        // never opened app before
        if(UserDefaults.standard.object(forKey: "todayDate") == nil) {
            UserDefaults.standard.set(Date(), forKey: "todayDate")
            await loadData(url: URL(string: randomVerseUrl)!)
            print("xxx \(randomVerse)")
            return
        }
        
        // is today the same day as the last time we opened app?
        let olderDate = UserDefaults.standard.object(forKey: "todayDate") as! Date
        let now = Date()
        let isSameDate = Calendar.current.isDate(now, inSameDayAs: olderDate)

        if(isSameDate) {
            // already loaded, don't do anything
            print("xxx isSameDate \(randomVerse) \(randomVerse.count)")
            // if object is empty for some reason 
            if(randomVerse.count == 0) {
                await loadData(url: URL(string: randomVerseUrl)!)
                return
            }
            let data = UserDefaults.standard.data(forKey: "decodedResponse")
            do {
                randomVerse = try (NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data!) as? [RandomResult])!
            } catch {
               print("ERROR: \(error.localizedDescription)")
               print("can't get random verse from user defaults")
               randomVerse = [RandomResult(bookname: "Deuteronomy", chapter: "13", verse: "14", text: "with the harvest produced by the daylight and by the moonlight;")]
            }
        }
        else {
            await loadData(url: URL(string: randomVerseUrl)!)
        }
        
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
                
                    let encodedData = try? NSKeyedArchiver.archivedData(withRootObject: decodedResponse, requiringSecureCoding: false)
                    UserDefaults.standard.set(encodedData, forKey: "decodedResponse")
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
