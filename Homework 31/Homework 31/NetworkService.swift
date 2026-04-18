//
//  NetworkService.swift
//  Homework 31
//
//  Created by Margarita Matsonko on 16/04/2026.
//

import Foundation

struct Users: Codable{
    let name: String
    let username: String
    let email: String
    let address: Address
    let phone: String
    let website: String
    let company: Company
    
}
struct Geo: Codable {
    let lat: String
    let lng: String
}
struct Company: Codable {
    let name: String
    let catchPhrase: String
    let bs: String
}
struct Address: Codable{
    let street: String
    let suite: String
    let city: String
    let zipcode: String
    let geo: Geo
}

enum NetworkError: Error, LocalizedError {
    case invalidURL
    case noData
    case httpError(statusCode: Int)
    case decodingError(Error)
    case networkError(Error)
    
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Wrong URL"
        case .noData:
            return "No data"
        case .httpError(let statusCode):
            return "Error: \(statusCode)"
        case .decodingError(let error):
            return "Decoding error: \(error.localizedDescription)"
        case .networkError(let error):
            return "Network error: \(error.localizedDescription)"
        }
    }
}

final class NetworkService{
    
    static let shared = NetworkService()
    private let baseURL = "https://jsonplaceholder.typicode.com"
    private let session: URLSession
    private init() {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 30
        configuration.timeoutIntervalForResource = 60
        configuration.waitsForConnectivity = true
        session = URLSession(configuration: configuration)
    }
    
    func fetchUsersAsync()async throws -> [Users]{
        guard let url = URL(string: "\(baseURL)/users") else {
            throw NetworkError.invalidURL
        }
        do {
            let (data, response) = try await session.data(from: url)
            guard let httpResponse = response as? HTTPURLResponse else {
                throw NetworkError.noData
            }
            guard (200...299).contains(httpResponse.statusCode) else {
                throw NetworkError.httpError(statusCode: httpResponse.statusCode)
            }
            let decoder = JSONDecoder()
            let users = try decoder.decode([Users].self, from: data)
            return users
        }
        catch let error as NetworkError{
            throw error
        } catch {
            throw NetworkError.networkError(error)
            
        }
    }
}
