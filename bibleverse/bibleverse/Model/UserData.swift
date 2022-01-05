//
//  UserData.swift
//  bibleverse
//
//  Created by Janice on 1/4/22.
//

import Foundation

class UserData  {
    
    let defaultVerse = [RandomResult(bookname: "Deuteronomy", chapter: "13", verse: "14", text: "with the harvest produced by the daylight and by the moonlight;")]
    let userDefaultsVerseKey = "randomverse"
    
    func saveVerse(verse:[RandomResult]) {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(verse)
            UserDefaults.standard.set(data, forKey: userDefaultsVerseKey)
            UserDefaults.standard.synchronize()
        }
        catch {
            print("unable to encode verse (\(error.localizedDescription))")
        }
    }

    func getVerse() -> [RandomResult] {
        var verse = defaultVerse
        
        if let data = UserDefaults.standard.data(forKey: userDefaultsVerseKey) {
            do {
                let decoder = JSONDecoder()
                let verseDecoder = try decoder.decode([RandomResult].self, from: data)
                verse = verseDecoder
            }
            catch {
                print("unable to decode verse (\(error.localizedDescription))")
            }
        }
        
        return verse
    }
    
}


