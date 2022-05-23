//
//  ContentView.swift
//  WorldPeek
//
//  Created by Avishka Amunugama on 5/19/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            MapView()
                .tabItem{
                    Text("Map")
                    Image(systemName: "star")
                }
            PinnedPlacesView()
                .tabItem{
                    Text("Pinned Places")
                    Image(systemName: "pin.circle")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
