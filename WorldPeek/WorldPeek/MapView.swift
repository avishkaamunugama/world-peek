//
//  MapView.swift
//  WorldPeek
//
//  Created by Avishka Amunugama on 5/19/22.
//

import MapKit
import SwiftUI

struct MapView: View {
    
    @StateObject private var viewModel = MapViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                Map(coordinateRegion: $viewModel.mapRegion, showsUserLocation: true)
                    .ignoresSafeArea()
                    .onAppear{
                        viewModel.checkIfLocationsEnabled()
                    }
                
                Image(systemName: "smallcircle.filled.circle")
                    .resizable()
                    .frame(width: 44, height: 44)
                    .foregroundColor(.blue)
                    .opacity(0.7)
                
                HStack {
                    Spacer()
                    
                    VStack {
                        Spacer()
                        
                        HStack {
                            Spacer()
                            
                            Button {
                                viewModel.viewButtonTitles.toggle()
                            }label: {
                                Image(systemName: viewModel.viewButtonTitles ? "chevron.right" : "chevron.left")
                                    .foregroundColor(.black.opacity(0.75))
                                    .font(.title3)
                                    .padding()
                            }
                        }
                        
                        HStack {
                            Spacer()
                            
                            VStack {
                                NavigationLink(destination: PinnedPlacesView(), tag: 2, selection: $viewModel.selection) {
                                    HStack {
                                        Button {
                                            viewModel.selection = 2
                                        }label: {
                                            Image(systemName: "star")
                                                .padding()
                                                .background(.black.opacity(0.75))
                                                .foregroundColor(.white)
                                                .font(.subheadline)
                                                .clipShape(Capsule())
                                        }
                                        if viewModel.viewButtonTitles {
                                            Text("Pinned Places")
                                                .font(.headline)
                                                .foregroundColor(.black)
                                        }
                                    }
                                }
                                .padding(.bottom, 20)
                                
                                NavigationLink(destination: PlacesView(location: viewModel.selectedLocation()), tag: 1, selection: $viewModel.selection) {
                                    HStack {
                                        Button {
                                            viewModel.selection = 1
                                        }label: {
                                            Image(systemName: "magnifyingglass")
                                                .padding()
                                                .background(.black.opacity(0.75))
                                                .foregroundColor(.white)
                                                .font(.title)
                                                .clipShape(Circle())
                                        }
                                        
                                        if viewModel.viewButtonTitles {
                                            Text("Nearby Places")
                                                .font(.headline)
                                                .foregroundColor(.black)
                                        }
                                        
                                    }
                                }
                            }
                            .padding()
                            .background(viewModel.viewButtonTitles ? .white: .gray.opacity(0.6))
                            .cornerRadius(32)
                        }
                        
                    }
                    .padding()
                }
            }
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
