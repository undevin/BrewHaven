//
//  BreweryController.swift
//  BrewHaven
//
//  Created by Devin on 4/20/21.
//

import Foundation

class BreweryController {
    
    // MARK: - Properties
    static let baseURL = URL(string: "https://api.openbrewerydb.org")
    static let breweryEndpoint = "breweries"
    let cache = NSCache<NSString, NSArray>()
    
    // MARK: - Enums
    enum BrewerySearch: String {
        case city = "by_city"
        case state = "by_state"
        case name = "by_name"
    }
    
    // MARK: - Methods
    static func fetchByCity(searchTerm: String, completion: @escaping (Result<[Brewery], NetworkError>) -> Void) {
        guard let baseURL = baseURL else { return completion(.failure(.invalidURL))}
        let breweriesURL = baseURL.appendingPathComponent(breweryEndpoint)
        var components = URLComponents(url: breweriesURL, resolvingAgainstBaseURL: true)
        
        let replacedSearchTerm = searchTerm.replacingOccurrences(of: " ", with: "_")
        
        let cityQuery = URLQueryItem(name: BrewerySearch.city.rawValue, value: replacedSearchTerm)
        components?.queryItems = [cityQuery]
        guard let finalURL = components?.url else { return }
        print(finalURL)
        
        URLSession.shared.dataTask(with: finalURL) { (data, response, error) in
            if let error = error {
                return completion(.failure(.thrownError(error)))
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { return completion(.failure(.invalidURL))}
            
            guard let data = data else { return completion(.failure(.noData))}
            do {
                let decoder = JSONDecoder()
                let topLevel = try decoder.decode(TopLevel.self, from: data)
                let breweries = topLevel.breweries
                return completion(.success(breweries))
                
            } catch {
                return completion(.failure(.unableToDecode))
            }
        }.resume()
    }
    
    static func fetchByState(searchTerm: String, completion: @escaping (Result<[Brewery], NetworkError>) -> Void) {
        guard let baseURL = baseURL else { return completion(.failure(.invalidURL))}
        let breweriesURL = baseURL.appendingPathComponent(breweryEndpoint)
        var components = URLComponents(url: breweriesURL, resolvingAgainstBaseURL: true)
        
        let stateQuery = URLQueryItem(name: BrewerySearch.state.rawValue, value: searchTerm)
        components?.queryItems = [stateQuery]
        guard let finalURL = components?.url else { return }
        print(finalURL)
        
        URLSession.shared.dataTask(with: finalURL) { (data, response, error) in
            if let error = error {
                return completion(.failure(.thrownError(error)))
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { return completion(.failure(.invalidURL))}
            
            guard let data = data else { return completion(.failure(.noData))}
            do {
                let decoder = JSONDecoder()
                let topLevel = try decoder.decode(TopLevel.self, from: data)
                let breweries = topLevel.breweries
                return completion(.success(breweries))
            } catch {
                return completion(.failure(.unableToDecode))
            }
        }.resume()
    }
}//End of Class
