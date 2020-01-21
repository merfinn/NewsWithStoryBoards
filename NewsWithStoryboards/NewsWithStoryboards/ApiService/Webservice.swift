//
//  Webservice.swift
//  MimiArtistsAndSongs
//
//  Created by merve kavaklioglu on 01.12.19.
//  Copyright © 2019 Merve Kavaklioglu. All rights reserved.
//

import UIKit

struct Resource<T> {
    let url: URL
    let parse: (Data) -> T?
}

final class Webservice {
    func load<T>(resource: Resource<T>, completion: @escaping (T?) -> ()) {
        URLSession.shared.dataTask(with: resource.url) { data, response, error in
            if let data = data {
                DispatchQueue.main.async {
                    completion(resource.parse(data))
                }
            } else {
                completion(nil)
            }
        }.resume()
    }
}
