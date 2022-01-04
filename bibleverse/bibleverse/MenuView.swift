//
//  MenuView.swift
//  bibleverse
//
//  Created by Janice on 1/4/22.
//

import SwiftUI

struct MenuView: View {
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "sun.min")
                    .foregroundColor(.gray)
                    .imageScale(.medium)
                Text("Verse of the Day")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }.padding(.top, 100)
            HStack {
                Image(systemName: "moon")
                    .foregroundColor(.gray)
                    .imageScale(.medium)
                Text("Topics")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .onTapGesture {
                        print("topics")
                    }
            }.padding(.top, 20)
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                    .imageScale(.medium)
                Text("Search")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .onTapGesture {
                        print("search")
                    }
            }.padding(.top, 20)
            Spacer()
            }
            .padding()
            .frame( maxWidth: .infinity, alignment: .leading)
            .background(Color(red: 32/255, green: 32/255, blue: 32/255))
            .edgesIgnoringSafeArea(.all)
    }
}




struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
