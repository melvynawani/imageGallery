//
//  GalleryCollectionViewCell.swift
//  ImageGallery
//
//  Created by Melvyn on 08/06/22.
//

import UIKit

class ImageGalleryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var galleryImageView: UIImageView!
    
    override func prepareForReuse() {
        self.galleryImageView.image = nil
    }
}
