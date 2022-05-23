//
//  PlaceDescription.swift
//  WorldPeek
//
//  Created by Avishka Amunugama on 5/19/22.
//

import SwiftUI
import RichText

struct PlaceDescription: View {
    
    var page: Page
    var selectedSection: DescriptionSection
    
    var body: some View {
        Section {
            switch selectedSection {
            case .about:
                if !page.longDescription.isEmpty {
                    RichText(html: page.longDescription)
                        .lineHeight(170)
                        .imageRadius(12)
                        .fontType(.system)
                        .colorScheme(.automatic)
                        .colorImportant(true)
                        .linkOpenType(.SFSafariView)
                        .linkColor(ColorSet(light: "#007AFF", dark: "#0A84FF"))
                        .placeholder { Text("Loading...").padding() }
                }
                else {
                    Text("\(page.title) \(page.shortDescription)")
                        .padding()
                }
            case .reviews:
                Text("No idea what to put here")
                    .padding()
            }
        }
    }
}

struct PlaceDescription_Previews: PreviewProvider {
    static var previews: some View {
        PlaceDescription(page: Page.example, selectedSection: DescriptionSection.about)
    }
}
