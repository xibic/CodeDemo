//
//  HTTPRequestHelper.swift
//

import Foundation

enum HTTPHeaderFields {
    case applicationJson
    case applicationurlencoded
    case none
}

class HttpRequestHelper {
    // MARK: - SessionManager
    private let sessionManager: URLSession = {
        let urlSessionConfiguration: URLSessionConfiguration = URLSessionConfiguration.default
        return URLSession(configuration: urlSessionConfiguration, delegate: nil, delegateQueue: nil)
    }()
    // MARK: - GET 
    func GET(urlString: String, complete: @escaping (Bool, Data?) -> Void) {
        guard let url = URL(string: urlString) else {
            print("Error: cannot create URL")
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        // Demo purpose static "Authorization Token"
        request.setValue("563492ad6f91700001000001917f30fb9b7d4552a495bcdc759ed731",
                         forHTTPHeaderField: "Authorization")
        sessionManager.dataTask(with: request) { data, response, error in
            guard error == nil else {
                print("Error: problem calling GET")
                print(error!)
                complete(false, nil)
                return
            }
            guard let data = data else {
                print("Error: did not receive data")
                complete(false, nil)
                return
            }
            guard let response = response as? HTTPURLResponse, (200 ..< 300) ~= response.statusCode else {
                print("Error: HTTP request failed")
                complete(false, nil)
                return
            }
            complete(true, data)
        }.resume()
    }
}
