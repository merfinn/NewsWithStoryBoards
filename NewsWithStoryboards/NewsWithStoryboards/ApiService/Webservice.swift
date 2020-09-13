//
//  Webservice.swift
//  MimiArtistsAndSongs
//
//  Created by merve kavaklioglu on 01.12.19.
//  Copyright © 2019 Merve Kavaklioglu. All rights reserved.
//

import UIKit


final class Webservice {
    func load<T: Codable>(with url: URL, completionHandler: @escaping (T?, URLResponse?, Error?) -> ())  {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completionHandler(nil, response, error)
                return
            }
            completionHandler(try? self.newJSONDecoder().decode(T.self, from: data), response, nil)
        }.resume()
    }
    
    func newJSONDecoder() -> JSONDecoder {
        let decoder = JSONDecoder()
        if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
            decoder.dateDecodingStrategy = .iso8601
        }
        return decoder
    }
}



