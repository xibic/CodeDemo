//
//  UIImageView+Extensions.swift
//

import Foundation
import UIKit

let imageCache = NSCache<NSString, UIImage>()

extension UIImageView {
    // MARK: - Remote Image
    func loadRemoteImage(_ URLString: String, placeHolder: UIImage?) {
        self.image = placeHolder
        if let cachedImage = imageCache.object(forKey: NSString(string: URLString)) {
            self.image = cachedImage
            return
        }
        if let url = URL(string: URLString) {
            URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                if error != nil {
                    let status = (response as? HTTPURLResponse)?.statusCode
                    print("ERROR LOADING IMAGES: \(String(describing: error)) STATUS:\(String(describing: status))")
                    DispatchQueue.main.async {
                        self.image = placeHolder
                    }
                    return
                }
                DispatchQueue.main.async {
                    if let data = data {
                        if let downloadedImage = UIImage(data: data) {
                            imageCache.setObject(downloadedImage, forKey: NSString(string: URLString))
                            self.image = downloadedImage
                        }
                    }
                }
            }).resume()
        }
    }
}
