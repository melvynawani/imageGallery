//
//  SearchViewModel.swift
//  ImageGallery
//
//  Created by Melvyn on 08/06/22.
//

import Foundation
import Combine

final class SearchViewModel {
    
    private var imageGalleryRepository: GalleryRepository

    private var imageRecords: [PhotoRecord] = []
 
    private weak var coordinator: Coordinator?

    @Published  var state: ViewStates = .none
    
    private var cancellables:Set<AnyCancellable> = Set()
    
    init(imageGalleryRepository: GalleryRepository,
         coordinator: Coordinator) {
        self.imageGalleryRepository = imageGalleryRepository
        self.coordinator = coordinator
    }
    
    func getGalleryImages(keyword: String?) async {
        guard let keyword = keyword, keyword.count > 0 else {
            self.state = .showError(APIError.invalidSearch.localizedDescription)
            return
        }

        do {
            self.imageRecords = try await  self.imageGalleryRepository.getImages(for: keyword)
            
            self.state = .showGalleryView
        } catch {
            self.state = .showError((error as! APIError).localizedDescription)
        }
    }
    
    func navigateToGallery() {
        coordinator?.navigatToGallery(imageRecords: imageRecords)
    }
}
