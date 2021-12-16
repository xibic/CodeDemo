//
//  AppCoordinator.swift
//

import UIKit
import Foundation

class AppCoordinator {

    private let navigationController = UINavigationController()
    var rootViewController: UIViewController {
        return navigationController
    }

    // MARK: - Start
    func start() {
        showPhotoCollection()
    }

    // MARK: - Helper Methods
    private func showPhotoCollection() {
        // Init viewModel
        let photoCollectionViewModel = PhotoCollectionViewModel()
        photoCollectionViewModel.gotoDetailsView = { [weak self] (media) in
            self?.showPhotoDetails(media)
        }

        // Initialize Photo Collection View Controller
        let collectionViewController = PhotoCollectionViewController.instantiate()
        collectionViewController.photoCollectionViewModel = photoCollectionViewModel

        // Push Onto Navigation Stack
        navigationController.pushViewController(collectionViewController, animated: true)
    }
    
    private func showPhotoDetails(_ media: Media) {
        // Init viewModel
        let detailsViewModel = DetailsViewModel()
        detailsViewModel.detailsItem = media
        // Initialize Details View Controller
        let detailsViewController = DetailsViewController.instantiate()
        detailsViewController.detailsViewModel = detailsViewModel

        // Push
        navigationController.pushViewController(detailsViewController, animated: true)
    }

}
