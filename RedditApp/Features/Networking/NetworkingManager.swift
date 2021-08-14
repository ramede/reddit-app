//
//  NetworkingManager.swift
//  RedditApp
//
//  Created by Râmede on 13/08/21.
//

import Foundation


enum RedditAppError: Error {
    case networking(code: Int, message: String)
}

//public enum Result {
//    case success(Data)
//    case failure(Error)
//}

struct NetworkDispatcher {
    func execute<T: Decodable>(sessionURL: URL, completion : @escaping (Result<T, Error>) -> Void) {
        let session = URLSession(configuration: .default)
        let dataTask = session.dataTask(with: sessionURL) { (data, response, error) in
            if error == nil {
                if let safeData = data {
                    do {
                        let decodedData = try JSONDecoder().decode(T.self, from: safeData)
                        completion(.success(decodedData))
                    } catch {
                        print("error while parsing data \(error)")
                        completion(.failure(RedditAppError.networking(code: 500, message: "Error")))
                    }
                } else {
                    debugPrint("failed to fetch data")
                    completion(.failure(RedditAppError.networking(code: 500, message: "Error")))
                }
            }
            else {
                print("error in data task is \(String(describing: error))")
                completion(.failure(RedditAppError.networking(code: 500, message: "Error")))
            }
        }
        dataTask.resume()
    }    
}
