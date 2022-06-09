//
//  SearchViewController.swift
//  ImageGallery
//
//  Created by Melvyn on 08/06/22.
//

import UIKit
import Combine

final class SearchViewController: UIViewController {

    @IBOutlet private weak var searchBar: UISearchBar!
    
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    
    var viewModel:SearchViewModel?
    
    private var bindings = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = NSLocalizedString("search", comment: "")
        searchBar.delegate = self
        setupBinding()
    }
    
    @IBAction private func searchNowButtonTapped(_ sender: Any) {
        search(for: searchBar.text)
    }
    
    private func search(for keyword:String?) {
        Task {
            await viewModel?.getGalleryImages(keyword:keyword )
        }
    }
    
    private func setupBinding() {
        viewModel?.$state.receive(on: RunLoop.main).sink(receiveValue: {[weak self] states in
            self?.searchBar.resignFirstResponder()
            switch states {
            case .showActivityIndicator:
                self?.showActivity()
            case .showGalleryView:
                self?.hideActivity()
                self?.navigateToGalleryView()
            case .showError( let message):
                self?.hideActivity()
                self?.showErrorMessage(message: message)
            case .none:
                self?.hideActivity()
            }
        }).store(in: &bindings)
    }
    
    private func showErrorMessage(message: String) {
        let alertController = UIAlertController(title:NSLocalizedString("alert", comment: "")
, message:message , preferredStyle: UIAlertController.Style.alert)
        
        let alertActionOk = UIAlertAction(title:"OK", style: UIAlertAction.Style.cancel)
        alertController.addAction(alertActionOk)
        self.present(alertController, animated: true, completion: nil)
    }
    
    private func showActivity() {
        self.activityIndicator.isHidden = false
        self.activityIndicator.startAnimating()
        self.view.isUserInteractionEnabled = false
    }
    
    private func hideActivity() {
        self.activityIndicator.stopAnimating()
        self.activityIndicator.isHidden = true
        self.view.isUserInteractionEnabled = true
    }
    
    private func navigateToGalleryView() {
        viewModel?.navigateToGallery()
    }
}

extension SearchViewController : UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        search(for: searchBar.text)
    }
}
