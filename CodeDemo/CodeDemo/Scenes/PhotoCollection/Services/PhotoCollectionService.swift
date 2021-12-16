//
//  PhotoCollectionService.swift
//

import Foundation

let API_PHOTO_COLLECTION: String = "https://api.pexels.com/v1/collections/3hnxz7v?per_page=15"

protocol PhotoCollectionServiceProtocol {
    func getPhotoCollectionsRemote(completion: @escaping (_ success: Bool,
                                                   _ results: Collection?,
                                                   _ error: String?) -> Void)
}

class PhotoCollectionService: PhotoCollectionServiceProtocol {
    // MARK: - Remote Data
    func getPhotoCollectionsRemote(completion: @escaping (Bool, Collection?, String?) -> Void) {

        HttpRequestHelper().GET(urlString: API_PHOTO_COLLECTION) { success, data in
            if success {
                do {
                    let model = try JSONDecoder().decode(Collection.self, from: data!)
                    completion(true, model, nil)
                } catch {
                    completion(false, nil, "Error: Trying to parse Feeds to model")
                }
            } else {
                completion(false, nil, "Error: Feeds GET Request failed")
            }
        }

    }

    // MARK: - Local Data
}
