//
//  RemoteImageView.swift
//  Flowers
//
//  Created by Ion Toderasco on 23.02.2024.
//

import SwiftUI

struct RemoteImageView: View {
    
    let url: URL?
    
    var body: some View {
        if let url {
            AsyncImage(url: url) { img in
                img.image?.resizable()
            }
            .scaledToFill()
        } else {
            Image(systemName: "photo")
        }
    }
}

#Preview {
    RemoteImageView(url: nil)
}
