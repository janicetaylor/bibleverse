//
//  MainView.swift
//  bibleverse
//
//  Created by Janice on 1/4/22.
//

import SwiftUI

struct MainView: View {
    
    @State var currentTab: String = "Home"
    @State var showMenu: Bool = false
    
    init(){
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        ZStack{
            MenuView(currentTab: $currentTab)
            CustomTabView(currentTab: $currentTab, showMenu: $showMenu)
            .offset(x: showMenu ? getRect().width / 2 : 0)
            .ignoresSafeArea()
        }
        .preferredColorScheme(.dark)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

// extending view to get safe area values
extension View{
    func getSafeArea()->UIEdgeInsets{
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else{
            return .zero
        }
        
        guard let safeArea = screen.windows.first?.safeAreaInsets else{
            return .zero
        }
        
        return safeArea
    }
}
