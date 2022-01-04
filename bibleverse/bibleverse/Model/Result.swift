//
//  Result.swift
//  bibleverse
//
//  Created by Janice on 1/2/22.
//

import Foundation

struct Response: Codable {
    var results: [Result]
}

struct Result: Codable {
    var title: String
    var preview: String
}

// random verse 
// https://api.biblia.com/v1/bible/content/LEB.html?passage=Lamentations3.16&key=fd37d8f28e95d3be8cb4fbc37e15e18e

struct Verse: Codable {
    var book: String
    var chapter: String
    var verse: String
}

#if DEBUG
let testData = [
    Result(title: "Numbers 7:16", preview: "one he-goat as a sin offering;"),
    Result(title: "Leviticus 16:5", preview: "And he must take from the Israelites’ community two he-goats as a sin offering and one ram as a burnt offering."),
    Result(title: "Zechariah 11:4", preview: "Thus says Yahweh my God: “Shepherd the flock doomed to slaughter."),
    Result(title: "Numbers 29:5", preview: "with one male goat for a sin offering, to make atonement for you,")
]
#endif
