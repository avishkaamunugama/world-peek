//
//  PlacesViewModel.swift
//  WorldPeek
//
//  Created by Avishka Amunugama on 5/19/22.
//

import Foundation
import CoreLocation


enum LoadingState {
    case loading, loaded, failed
}

enum PlaceFilters: String, CaseIterable {
    case all, parks, libraries, cities, peaks
    
    var displayName: String {
        return self.rawValue.capitalized
    }
}

@MainActor class PlacesViewModel: ObservableObject {
    
    @Published var pages = [Page]()
    @Published var loadingState: LoadingState = .loading
    @Published var searchRadius: Double = 10000.0
    @Published var selectedFilter: PlaceFilters = .all
    
    func fetchPlacesNearby(_ location: Location) async {
        let urlString = "https://en.wikipedia.org/w/api.php?ggscoord=\(location.coordinate.latitude)%7C\(location.coordinate.longitude)&action=query&prop=pageimages%7Cextracts%7Ccoordinates%7Cimages%7Cpageterms&colimit=50&wbptterms=description&generator=geosearch&ggsradius=10000&ggslimit=50&format=json&pithumbsize=1024"
        
        
        guard let url = URL(string: urlString) else{
            print("Bad URL: \(urlString)")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let items = try JSONDecoder().decode(Result.self, from: data)
            pages = items.query.pages.values.sorted()
            loadingState = .loaded
        } catch {
            loadingState = .failed
        }
    }
    
    func sortPagesByDistance(to location:Location) -> [Page] {
        return filteredPages().sorted {
            distance(from: location, to: $0) < distance(from: location, to: $1)
        }
    }
    
    func distance(from l1:Location, to l2:Page) -> Double {
        return l2.cllLocation.distance(from: l1.cllLocation) / 1000
        
    }
    
    func filteredPages() -> [Page] {
        return pages.filter{
            ($0.imageCount > 0 || $0.thumbnail != nil || $0.pageimage != nil) && !($0.shortDescription.isEmpty)
        }
    }
}

