//
//  CustomTabView.swift
//  bibleverse
//
//  Created by Janice on 1/4/22.
//

import SwiftUI

struct CustomTabView: View {
    
    @Binding var currentTab: String
    @Binding var showMenu: Bool
    
    var body: some View {
        VStack {

            // create header view for tab pages
            HStack {
                // menu button
                Button {
                    withAnimation(.spring()) {
                        showMenu = true
                    }
                } label: {
                    Image(systemName: "line.3.horizontal")
                        .font(.title2)
                        .foregroundColor(.white)
                }
                // hiding when menu is visible
                .opacity(showMenu ? 0 : 1)
                Spacer()
                
                
                } // close header view HStack
                .background(Color.black)
            
                // page title
                .overlay(
                    Text("")
                        .font(.title2.bold())
                        .foregroundColor(.gray)
                        .opacity(showMenu ? 0 : 1)
                )
                .padding([.horizontal,.top])
                .padding(.bottom,8)
                .padding(.top,getSafeArea().top)
                
                TabView(selection: $currentTab) {
                    // custom tab view here
                    Home()
                        .tag("Home")
                    Bible()
                        .tag("Read")
                    Topics() 
                        .tag("Topics")
                    Search()
                        .tag("Search")
                    Text("Logout")
                        .tag("Logout")
                }
                // disable actions when menu is visible
                .disabled(showMenu)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .overlay(
                    // close button
                    Button {
                        withAnimation(.spring()){
                            showMenu = false
                        }
                    } label: {
                        Image(systemName: "xmark")
                            .font(.title2)
                            .foregroundColor(.white)
                    }
                    .opacity(showMenu ? 1 : 0)
                    .padding()
                    .padding(.top)
                    ,alignment: .topLeading
                )
                .background(Color.black)
            }
            .background(Color.black)
          
        }
    } 

struct CustomTabView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
