//
//  Topics.swift
//  bibleverse
//
//  Created by Janice on 1/4/22.
//

import SwiftUI

struct Topics: View {
    
    let themes = ["love", "compassion", "joy", "delight", "anger", "wrath", "fear", "terror", "depression", "guilt", "pride", "sin"]
    
    var body: some View {
        
        List(themes, id: \.self) { item in
            VStack {
                HStack {
                    Text(item)
                        .foregroundColor(.white)
                    Button{
                        print("button pressed: \(item)")
                    }
                    label: {
                        Image(systemName: "arrowtriangle.right")
                    }
                    .foregroundColor(.gray)
                    
                }
                
            }
            .padding()
        }
    }
}

struct Topics_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
