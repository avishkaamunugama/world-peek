//
//  PlacesListRow.swift
//  WorldPeek
//
//  Created by Avishka Amunugama on 5/19/22.
//

import SDWebImageSwiftUI
import SwiftUI

struct PlacesListRow: View {
    
    var page: Page
    var location: Location
    @StateObject var viewModel = PlacesViewModel()
    
    var body: some View {
        VStack {
            HStack {
                if let url = page.thumbnailImageURL {
                    WebImage(url: url)
                        .resizable()
                        .placeholder{
                            Image(systemName: "hourglass")
                                .font(.title)
                                .frame(width: 50, height: 50)
                        }
                        .scaledToFill()
                        .frame(width:75, height: 75)
                        .clipped()
                        .cornerRadius(20)
                }
                    VStack(alignment:.leading) {
                        Text(page.title)
                            .font(.headline)
                        HStack {
                            Text(page.shortDescription)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                            Spacer()
                            HStack {
                                Image(systemName: "mappin.circle")
                                Text(String(format: "%.1f km", viewModel.distance(from: location, to: page)))
                                    .italic()
                                    .font(.subheadline)
                            }
                            .padding(4)
                            .background(.blue.opacity(0.1))
                            .cornerRadius(10)
                        }
                    }
                    .frame(height: 75)
            }
            Divider()
        }
    }
}

struct PlacesListRow_Previews: PreviewProvider {
    static var previews: some View {
        PlacesListRow(page: Page.example, location: Location.example)
    }
}
