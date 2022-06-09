//
//  AppCoordinator.swift
//  ImageGallery
//
//  Created by Melvyn on 08/06/22.
//

import Foundation
import UIKit

protocol Coordinator: AnyObject {
    func navigatToGallery(imageRecords:[PhotoRecord])
}

class AppCoordinator: Coordinator {
    
    var navController: UINavigationController
    
    init(navBarController: UINavigationController) {
        self.navController = navBarController
    }
    
    func start() {
        let networkManager = NetworkManager()
        let imageRepository = GalleryRepository(networkManager: networkManager)
        
        let  imageSearchViewModel =       SearchViewModel(imageGalleryRepository: imageRepository, coordinator: self)
        

        let sb = UIStoryboard(name: "Main", bundle:nil)

        if  let imageSearchViewController = sb.instantiateViewController(withIdentifier:"ImageSearchViewController") as? SearchViewController {
            
            navController.viewControllers = [imageSearchViewController]
            
            imageSearchViewController.viewModel = imageSearchViewModel
        }
        
    }
    
    func navigatToGallery(imageRecords: [PhotoRecord]) {
    
        let sb = UIStoryboard(name: "Main", bundle:nil)
        if  let galleryViewController = sb.instantiateViewController(withIdentifier:"GalleryViewController") as? ImageGalleryViewController {
            
            let networkManager = NetworkManager()
            let imageManager = ImageManager(networkManager: networkManager)
            
            galleryViewController.galleryViewModel  = ImageGalleryViewModel(imageRecodrs: imageRecords, imageManager: imageManager)
            navController.pushViewController(galleryViewController, animated: false)
        }
    }
}
