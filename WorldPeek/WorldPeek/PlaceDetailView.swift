//
//  PlaceDetailView.swift
//  WorldPeek
//
//  Created by Avishka Amunugama on 5/19/22.
//

import SDWebImageSwiftUI
import SwiftUI

struct PlaceDetailView: View {
    
    var page: Page
    @StateObject var viewModel: PlaceDetailViewModel = PlaceDetailViewModel()
    
    var body: some View {
        GeometryReader { geo in
            ScrollView {
                VStack(alignment:.leading, spacing: 0) {
                    ZStack(alignment:.bottomTrailing) {
                        ScrollView(.horizontal, showsIndicators: true) {
                            HStack {
                                Group {
                                    WebImage(url: page.thumbnailImageURL)
                                        .resizable()
                                    ForEach(viewModel.pageImages, id:\.title) { image in
                                        WebImage(url: image.pageImageURL)
                                            .resizable()
                                            .placeholder{
                                                Image(systemName: "hourglass")
                                                    .font(.title)
                                                    .frame(width: 50, height: 50)
                                            }
                                    }
                                }
                                .scaledToFill()
                                .frame(width:geo.size.width, height: geo.size.height*0.6)
                                .clipped()
                            }
                        }
                        
                        PlaceQuickInfo()
                    }
                    
                    Section {
                        Text(page.title)
                            .font(.largeTitle.weight(.bold))
                            .padding(.vertical)
                            .padding(.horizontal,10)
                        
                        HStack {
                            ForEach(DescriptionSection.allCases, id:\.self) { section in
                                Button {
                                    viewModel.setSelectedSection(section)
                                }label: {
                                    Text(section.displayName)
                                        .font(.title3.weight(.medium))
                                        .foregroundColor(viewModel.selectedSection == section ? .blue : .black)
                                        .underline(viewModel.selectedSection == section)
                                        .padding(.horizontal, 10)
                                }
                            }
                        }
                        
                        PlaceDescription(page: page, selectedSection: viewModel.selectedSection)
                    }
                    .padding(.horizontal)
                    
                    
                    Spacer()
                }
            }
        }
        .task {
            guard let imagesNames = page.images else {return}
            await viewModel.fetchImages(imagesNames)
        }
        .edgesIgnoringSafeArea(.top)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar{
            ToolbarItem(placement:.navigationBarTrailing){
                Button {
                    
                }label: {
                    HStack {
                        Text("Pin")
                            .font(.caption)
                            .padding(.horizontal, 5)
                        Image(systemName: "star.fill")
                    }
                    .padding(7)
                    .background(.black.opacity(0.75))
                    .foregroundColor(.white)
                    .clipShape(Capsule())
                }
            }
        }
    }
}

struct PlaceDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PlaceDetailView(page: Page.example)
    }
}
