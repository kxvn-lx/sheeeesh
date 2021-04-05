//
//  API.swift
//  
//
//  Created by Kevin Laminto on 5/4/21.
//

import Foundation

public enum HTTPError: LocalizedError {
    case statusCode
}

public class API {
    static public let shared = API()
    static private let URL_PREFIX = "https://"
    static private let HOST = "reddit-meme-api.herokuapp.com"
    
    private var session: URLSession
    
    init() {
        session = URLSession(configuration: Self.makeSessionConfiguration(token: nil))
    }
    
    public func request(withImagesCount count: Int = 20, completion: @escaping (MemeCollection) -> Void)  {
        let url = Self.makeURL().appendingPathComponent("\(count)")
        
        session.dataTask(with: url) { (data, _, error) in
            guard let data = data else { fatalError() }
            if error != nil { fatalError(error!.localizedDescription) }
            
            do {
                let memeCollection = try JSONDecoder().decode(MemeCollection.self, from: data)
                completion(memeCollection)
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
    }
    
    // MARK: - Private methods
    static func makeURL() -> URL {
        let url = URL(string: "\(Self.URL_PREFIX)\(Self.HOST)")!
        let component = URLComponents(url: url, resolvingAgainstBaseURL: false)!
        
        return component.url!
    }
    
    static private func makeSessionConfiguration(token: String?) -> URLSessionConfiguration {
        let configuration = URLSessionConfiguration.default
        configuration.urlCache = .shared
        configuration.requestCachePolicy = .reloadRevalidatingCacheData
        configuration.timeoutIntervalForRequest = 60
        configuration.timeoutIntervalForResource = 120
        return configuration
    }
}