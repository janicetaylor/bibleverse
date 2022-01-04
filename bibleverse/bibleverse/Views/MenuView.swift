//
//  MenuView.swift
//  bibleverse
//
//  Created by Janice on 1/4/22.
//

import SwiftUI

struct MenuView: View {
    
    @Binding var currentTab: String
    @Namespace var animation
    
    var body: some View {
        VStack {
            ScrollView(getRect().height < 750 ? .vertical : .init(), showsIndicators: false, content: {
                VStack(alignment: .leading, spacing: 25) {
                    CustomButton(icon: "sun.min", title: "Random")
                    CustomButton(icon: "moon", title: "Topics")
                    CustomButton(icon: "magnifyingglass", title: "Search")
                    CustomButton(icon: "safari.fill", title: "Discover")
                    CustomButton(icon: "person.fill", title: "Profile")
                    CustomButton(icon: "gearshape.fill", title: "Setting")
                    Spacer()
                    CustomButton(icon: "rectangle.portrait.and.arrow.right", title: "Logout")
                }
                .padding()
                .padding(.top,0)
            })
            
            // max width of screen width
            .frame(width: getRect().width / 2,alignment: .leading)
            .frame(maxWidth: .infinity,alignment: .leading)
        }
        .padding(.leading,10)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
    }
    
    @ViewBuilder
    func CustomButton(icon: String, title: String) -> some View {
        Button {
            if title == "Logout"{
                // logout ...
                print("Logout")
            }
            else {
                withAnimation {
                    currentTab = title
                }
            }
            
        } label: {
            HStack(spacing: 10) {
                Image(systemName: icon)
                    .font(.title3)
                    .frame(width: currentTab == title ? 48 : nil, height: 48)
                    .foregroundColor(.purple)
                    .background(
                        ZStack{
                            if currentTab == title {
                                Color.white
                                    .clipShape(Circle())
                                    .matchedGeometryEffect(id: "tabcircle", in: animation)
                            }
                        }
                    )
                Text(title)
                    .font(.callout)
                    .fontWeight(.semibold)
                    .foregroundColor(title == "Logout" ? Color("Orange") : .white)
                    
            }
            .padding(.trailing, 10)
            .background(
                ZStack{
                    if currentTab == title{
                        Color("Purple")
                            .clipShape(Capsule())
                            .matchedGeometryEffect(id: "tabcapsule", in: animation)
                    }
                }
            )
        }
        .offset(x: currentTab == title ? 15 : 0)
    }
}


struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

// extending view to get screen bounds
extension View {
    func getRect() -> CGRect {
        return UIScreen.main.bounds
    }
}
