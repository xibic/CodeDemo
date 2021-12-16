//
//  HomeViewModel.swift
//

import Foundation

final class PhotoCollectionViewModel {
    // MARK: - Properties
    var gotoDetailsView: ((Media) -> Void)?
    let photoCollectionService: PhotoCollectionServiceProtocol = PhotoCollectionService()
    var reloadTableViewClosure: (() -> Void)?
    var mediaArray = [Media]() {
        didSet {
            self.reloadTableViewClosure?()
        }
    }
    var numberOfRows: Int {
        return mediaArray.count
    }

    // MARK: - Fetch
    func fetchPhotoCollection() {
        photoCollectionService.getPhotoCollectionsRemote { success, results, error in
            if success, let mediaCollection = results {
                DispatchQueue.main.async { [weak self] in
                    self?.processFetchedMediaCollection(medias: mediaCollection.media)
                }
            } else {
                fatalError("Photo collection loading error - \(String(describing: error))")
            }
        }
    }
    func processFetchedMediaCollection(medias: [Media]) {
        mediaArray = medias
    }

    // MARK: -
    func selectedRowForDetails(selectedRow: Int) {
        gotoDetailsView?(mediaArray[selectedRow])
    }

}

// MARK: - Cell Extentions
extension PhotoCollectionViewModel {
    // MARK: - Title
    func getTitleForCellRow(_ rowIndex: Int) -> String? {
        return mediaArray[rowIndex].alt
    }

    // MARK: - Thumbnaile
    func getThumbnailUrlForRow(_ rowIndex: Int) -> String? {
        return mediaArray[rowIndex].src.medium
    }
}
