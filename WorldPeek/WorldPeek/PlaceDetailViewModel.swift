//
//  PlaceDetailViewModel.swift
//  WorldPeek
//
//  Created by Avishka Amunugama on 5/19/22.
//

import Foundation

enum DescriptionSection: String, CaseIterable {
    case about, reviews
    
    var displayName: String {
        return self.rawValue.capitalized
    }
}

@MainActor class PlaceDetailViewModel: ObservableObject {
    @Published var selectedSection: DescriptionSection = .about
    @Published var pageImages = [ImagePage]()
    @Published var loadingState: LoadingState = .loading
    
    func setSelectedSection(_ section:DescriptionSection) {
        selectedSection = section
    }
    
    func fetchImages(_ imgNames: [ImageURL]) async {
        
        let imageExtensions = [".png", ".jpg", ".jpeg"]
        
        for imgName in imgNames {
            let formattedImgName = formatImgName(imgName.title)
            
            if imageExtensions.contains(String(formattedImgName.suffix(4)).lowercased()) {
                let urlString = "https://en.wikipedia.org/w/api.php?ggscoord=35.689506%7C139.691700&action=query&titles=Image:\(formattedImgName)&prop=imageinfo&iiprop=url&format=json"
                
                guard let url = URL(string: urlString) else{
                    print("Bad URL: \(urlString)")
                    return
                }
                
                do {
                    let (data, _) = try await URLSession.shared.data(from: url)
                    let items = try JSONDecoder().decode(ImageResult.self, from: data)
                    pageImages.append(items.query.pages.values.first!)
                    loadingState = .loaded
                } catch {
                    loadingState = .failed
                }
            }
        }
    }
    
    func formatImgName(_ imgName:String) -> String {
        let formattedImgName = imgName.replacingOccurrences(of: "File:", with: "")
        return formattedImgName.replacingOccurrences(of: " ", with: "%20")
    }
    
}
