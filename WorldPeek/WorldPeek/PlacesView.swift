//
//  PlacesView.swift
//  WorldPeek
//
//  Created by Avishka Amunugama on 5/19/22.
//

import SwiftUI

struct PlacesView: View {
    
    var location: Location
    @StateObject var viewModel = PlacesViewModel()
    
    var body: some View {
        VStack {
            Section {
                Picker("Filter places by type.", selection:$viewModel.selectedFilter) {
                    ForEach(PlaceFilters.allCases, id:\.self) { type in
                        Text(type.displayName)
                    }
                }
                .pickerStyle(.segmented)
            }
            .padding()
            
            Spacer()
            
            Section {
                switch viewModel.loadingState {
                case .loading:
                    Text("Loading...")
                        .font(.caption)
                        .italic()
                        .foregroundColor(.secondary)
                case .loaded:
                    List {
                        ForEach(viewModel.sortPagesByDistance(to: location), id:\.pageid){ page in
                            NavigationLink(destination: PlaceDetailView(page: page)) {
                                PlacesListRow(page: page, location: location)
                            }
                        }
                        .listRowSeparator(.hidden)
                    }
                    .listStyle(.plain)
                case .failed:
                    Text("Failed to load. Please try again later.")
                        .font(.caption)
                        .italic()
                        .foregroundColor(.secondary)
                }
            }
            
            Spacer()
        }
        .navigationTitle("Nearby places")
        .task {
            await viewModel.fetchPlacesNearby(location)
        }
    }
}

struct PlacesView_Previews: PreviewProvider {
    static var previews: some View {
        PlacesView(location: Location.example)
    }
}
