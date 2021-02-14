//
//  PhotoInfoController.swift
//  Space Photo
//
//  Created by Jonathan Burnett on 13/02/2021.
//

import Foundation

class PhotoInfoController {
    
    func fetchPhotoInfo(matching query: [String: String], completion: @escaping (PhotoInfo?) -> Void) {

        let baseURL = URL(string: "https://api.nasa.gov/planetary/apod")!

        let url = baseURL.withQueries(query)!

        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in

            let jsonDecoder = JSONDecoder()

            if let data = data,
                let photoInfo = try? jsonDecoder.decode(PhotoInfo.self, from: data) {

                completion(photoInfo)
                
            } else {

                print("Either no data was returned, or data was not properly decoded.")

                completion(nil)
            }
        }

        task.resume()
    }
}

