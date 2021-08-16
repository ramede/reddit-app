//
//  NetworkingManager.swift
//  RedditApp
//
//  Created by Râmede on 13/08/21.
//

import Foundation


enum RedditAppError: Error {
    case networking(code: Int, message: String)
    case parser(code: Int, message: String)
    case fetch(code: Int, message: String)
    case generic(code: Int, message: String)
}

struct NetworkDispatcher {
    func execute<T: Decodable>(sessionURL: URL, completion : @escaping (Result<T, Error>) -> Void) {
        let session = URLSession(configuration: .default)
        let dataTask = session.dataTask(with: sessionURL) { (data, response, error) in
            
            // TODO: handle status code
            if let httpResponse = response as? HTTPURLResponse {
                print(httpResponse.statusCode)
            }
            
            if error == nil {
                if let safeData = data {
                    do {
                        let decodedData = try JSONDecoder().decode(T.self, from: safeData)
                        completion(.success(decodedData))
                    } catch {
                        completion(.failure(RedditAppError.parser(code: -1, message: "Error while parsing data")))
                    }
                } else {
                    completion(.failure(RedditAppError.fetch(code: -2, message: "Failed to fetch data")))
                }
            }
            else {
                completion(.failure(RedditAppError.generic(
                                        code: -3,
                                        message: "Error in data task is \(String(describing: error))"
                        )
                    )
                )
            }
        }
        dataTask.resume()
    }    
}
