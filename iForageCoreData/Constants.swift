//
//  Constants.swift
//  iForageCoreData
//
//  Created by Connor A Lynch on 12/11/2021.
//

import Foundation
import SwiftUI

struct LazyView<Content: View>: View {
    let build: () -> Content
    init(_ build: @autoclosure @escaping () -> Content) {
        self.build = build
    }
    var body: Content {
        build()
    }
}

struct FlatLinkStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
    }
}

//MARK:- StrechingHeader
struct StretchingHeader<Content: View>: View {
    let height: CGFloat
    let content: () -> Content
    
    var body: some View {
        GeometryReader { geo in
            content()
                .frame(width: geo.size.width, height: self.getHeightForHeaderImage(geo))
                .clipped()
                .offset(x: 0, y: self.getOffsetForHeaderImage(geo))
        }
        .frame(height: height)
    }
    
    private func getScrollOffset(_ geometry: GeometryProxy) -> CGFloat {
        geometry.frame(in: .global).minY
    }
    
    // 2
    private func getOffsetForHeaderImage(_ geometry: GeometryProxy) -> CGFloat {
        let offset = getScrollOffset(geometry)
        
        // Image was pulled down
        if offset > 0 {
            return -offset
        }
        else if offset > 0 {
            return offset
        }
        
        
        return 0
    }
    
    private func getHeightForHeaderImage(_ geometry: GeometryProxy) -> CGFloat {
        let offset = getScrollOffset(geometry)
        let imageHeight = geometry.size.height

        if offset > 0 {
            return imageHeight + offset
        }

        return imageHeight
    }
}
