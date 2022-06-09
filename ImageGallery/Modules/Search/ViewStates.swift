//
//  ViewStates.swift
//  ImageGallery
//
//  Created by Melvyn on 08/06/22.
//

import Foundation

enum ViewStates: Equatable {
    case showActivityIndicator
    case showGalleryView
    case showError(String)
    case none
}
