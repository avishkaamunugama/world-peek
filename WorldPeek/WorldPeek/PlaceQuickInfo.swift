//
//  PlaceQuickInfo.swift
//  WorldPeek
//
//  Created by Avishka Amunugama on 5/19/22.
//

import SwiftUI

struct PlaceQuickInfo: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        HStack {
            HStack {
                Spacer()
                HStack {
                    Image(systemName: "map.circle")
                        .resizable()
                        .frame(width: 27, height: 27)
                    Text("12.5km")
                        .font(.title2.lowercaseSmallCaps().bold())
                    Text("Distance")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                .foregroundColor(colorScheme == .dark ? .black : .white)
                
                Spacer()
                HStack {
                    Image(systemName: "sun.max.circle.fill")
                        .resizable()
                        .frame(width: 27, height: 27)
                    Text("30°c")
                        .font(.title2.lowercaseSmallCaps().bold())
                    Text("Sunny")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                .foregroundColor(colorScheme == .dark ? .black : .white)
                Spacer()
            }
            .padding()
            .padding(.top, 100)
            .background{
                LinearGradient(gradient: Gradient(colors: [.clear, colorScheme == .dark ? .white : .black]), startPoint: .top, endPoint: .bottom)
            }
        }
    }
}

struct PlaceQuickInfo_Previews: PreviewProvider {
    static var previews: some View {
        PlaceQuickInfo()
    }
}
