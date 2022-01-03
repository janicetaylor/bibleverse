//
//  BibleVerse.swift
//  dorothyparker
//
//  Created by Janice on 1/2/22.
//

import Foundation

struct BibleVerse: Identifiable {
    var id: String
    var title: String
    var verse: String    
}

#if DEBUG
let testData = [
    BibleVerse(id: "Numbers 7:16", title: "Numbers 7:16", verse: "one he-goat as a sin offering;"),
    BibleVerse(id: "Leviticus 16:5", title: "Leviticus 16:5", verse: "And he must take from the Israelites’ community two he-goats as a sin offering and one ram as a burnt offering."),
    BibleVerse(id: "Zechariah 11:4", title: "Zechariah 11:4", verse: "Thus says Yahweh my God: “Shepherd the flock doomed to slaughter."),
    BibleVerse(id: "Numbers 29:5", title: "Numbers 29:5", verse: "with one male goat for a sin offering, to make atonement for you,")
]

#endif
