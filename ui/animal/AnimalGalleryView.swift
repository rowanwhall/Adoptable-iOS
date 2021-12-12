//
//  AnimalGalleryView.swift
//  Adoptable
//
//  Created by Rowan Hall on 11/27/21.
//  Copyright © 2021 Rowan Hall. All rights reserved.
//

import Foundation

import SwiftUI
import Combine

struct AnimalGalleryView: View {
    
    var photoUrls: [String]
    @State var slideGesture: CGSize = CGSize.zero
    @State private var currentIndex: Int = 0
    
    var body: some View {
            GeometryReader { geometry in
                ZStack(alignment: .bottom) {
                    HStack(spacing: 0) {
                        ForEach(photoUrls, id: \.self) { photoUrl in
                            AsyncImage(
                                url: URL(string: photoUrl)!,
                                placeholder: { ProgressView().frame(maxWidth: .infinity) },
                                image: { Image(uiImage: $0) }
                            )
                                .frame(width: geometry.size.width, height: geometry.size.height)
                                .clipped()
                        }
                    }
                        .frame(width: geometry.size.width, height: geometry.size.height, alignment: .leading)
                        .offset(x: CGFloat(self.currentIndex) * -geometry.size.width, y: 0)
                        .animation(.spring())
                        .gesture(DragGesture().onChanged{ value in
                            self.slideGesture = value.translation
                        }
                        .onEnded{ value in
                            if self.slideGesture.width < -50 {
                                if self.currentIndex < self.photoUrls.count - 1 {
                                    withAnimation {
                                        self.currentIndex += 1
                                    }
                                }
                            }
                            if self.slideGesture.width > 50 {
                                if self.currentIndex > 0 {
                                    withAnimation {
                                        self.currentIndex -= 1
                                    }
                                }
                            }
                            self.slideGesture = .zero
                        })
                    
                    HStack(spacing: 3) {
                        ForEach(0..<self.photoUrls.count, id: \.self) { index in
                            Circle()
                                .frame(width: index == self.currentIndex ? 10 : 8,
                                       height: index == self.currentIndex ? 10 : 8)
                                .foregroundColor(index == self.currentIndex ? Color.primaryColorLegacy : .white)
                                .overlay(Circle().stroke(Color.gray, lineWidth: 1))
                                .padding(.bottom, 8)
                                .animation(.spring())
                        }
                    }
                }
                .navigationBarTitle("\(currentIndex + 1) of \(photoUrls.count)")
                .primaryNavigationColor
            }
        }
}
