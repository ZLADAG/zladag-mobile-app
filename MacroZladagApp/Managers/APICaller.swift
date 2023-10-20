//
//  APICaller.swift
//  MacroZladagApp
//
//  Created by Daniel Bernard Sahala Simamora on 02/10/23.
//



import Foundation

final class APICaller {
    static let shared = APICaller()
    
    private init() {}
    
    struct Constants {
//        static let baseAPIURL = "https://22c6-158-140-189-122.ngrok-free.app/api"
//        static let baseAPIURL = "http://localhost:8100/api"
        
        static let baseAPIURL = "https://zladag-sasato.uc.r.appspot.com/api"
        static let baseAPIURLLocal = "http://localhost:8080/api"
    }
    
    enum APIError: Error {
        case failedToGetData
    }
    
    public func getBoardings(completion: @escaping (Result<HomeBoardingResponse, Error>) -> Void) {
        createRequest(with: URL(string: Constants.baseAPIURL + "/home"), type: .GET) { baseRequest in
            let task = URLSession.shared.dataTask(with: baseRequest) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(error!))
                    return
                }
                
                do {
//                    let resultTemp = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
//                    let formatter = DateFormatter()
//                    formatter.dateFormat = "YYYY-MM-DD'T'HH:mm:ss.SSS'Z'"
//
//                    let decoder = JSONDecoder()
//                    decoder.dateDecodingStrategy = .formatted(formatter)
//                    let result = try decoder.decode(HomeBoardingResponse.self, from: data)
                    let result = try JSONDecoder().decode(HomeBoardingResponse.self, from: data)
                    
                    print("GET /home")
                    completion(Result.success(result))
                } catch {
                    print("error in getBoardings:", error.localizedDescription)
                    completion(Result.failure(error))
                }
            }
            task.resume()
        }
    }
    
    public func getBoardings2(completion: @escaping (Result<String, Error>) -> Void) {
        createRequest(with: URL(string: Constants.baseAPIURL + "/home"), type: .GET) { baseRequest in
            let task = URLSession.shared.dataTask(with: baseRequest) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(error!))
                    return
                }
                
                do {
                    let resultTemp = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
//                    let formatter = DateFormatter()
//                    formatter.dateFormat = "YYYY-MM-DD'T'HH:mm:ss.SSS'Z'"
//
//                    let decoder = JSONDecoder()
//                    decoder.dateDecodingStrategy = .formatted(formatter)
//                    let result = try decoder.decode(HomeBoardingResponse.self, from: data)
//                    let result = try JSONDecoder().decode(HomeBoardingResponse.self, from: data)
                    
                    print("GET /home")
                    print(resultTemp)
//                    completion(Result.success(result))
                } catch {
                    print("error in getBoardings:", error.localizedDescription)
                    completion(Result.failure(error))
                }
            }
            task.resume()
        }
    }
    
    public func getBoardingsSearch(params: String, completion: @escaping (Result<SearchBoardingsResponse, Error>) -> Void) {
        createRequest(with: URL(string: Constants.baseAPIURL + "/search?\(params)"), type: .GET) { baseRequest in
            let task = URLSession.shared.dataTask(with: baseRequest) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(error!))
                    return
                }

                do {
//                    let result = try JSONDecoder().decode(BoardingsResponse.self, from: data)
                    
//                    let formatter = DateFormatter()
//                    formatter.dateFormat = "YYYY-MM-DD'T'HH:mm:ss.SSS'Z'"
//
//                    let decoder = JSONDecoder()
//                    decoder.dateDecodingStrategy = .formatted(formatter)
                    let result = try JSONDecoder().decode(SearchBoardingsResponse.self, from: data)
                    
                    print("GET /search?\(params)")
                    completion(Result.success(result))
                } catch {
                    print("error in getBoardingsSearch:", error.localizedDescription)
                    completion(Result.failure(error))
                }
            }
            task.resume()
        }
    }
    
    public func getBoardingBySlug(slug: String, completion: @escaping (Result<BoardingDetailsResponse, Error>) -> Void) {
        createRequest(with: URL(string: Constants.baseAPIURL + "/boardings/\(slug)"), type: .GET) { baseRequest in
            print("slug:", slug)
            let task = URLSession.shared.dataTask(with: baseRequest) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(error!))
                    return
                }

                do {
                    let result = try JSONDecoder().decode(BoardingDetailsResponse.self, from: data)
                    print("GET /boardings/{slug}, slug: \(slug)")
                    completion(Result.success(result))
                } catch {
                    print("error in getBoardingBySlug:", error.localizedDescription)
                    completion(Result.failure(error))
                }
            }
            task.resume()
        }
    }
    
    
    public func getBoardingsByName(name: String, completion: @escaping (Result<BoardingsResponse, Error>) -> Void) {
//        createRequest(with: URL(string: Constants.baseAPIURL + "/boardings/\(name)"), type: .GET) { baseRequest in
        createRequest(with: URL(string: Constants.baseAPIURLLocal + "/boardings"), type: .GET) { baseRequest in
            let task = URLSession.shared.dataTask(with: baseRequest) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(error!))
                    return
                }

                do {
//                    let result = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                    let result = try JSONDecoder().decode(BoardingsResponse.self, from: data)

                    completion(Result.success(result))
                } catch {
                    print(error.localizedDescription)
                    completion(Result.failure(error))
                }
            }
            task.resume()
        }
    }
    
    public func getImage(path: String) -> String  {
//        print(Constants.baseAPIURL + "/images?path=\(path)")
        return Constants.baseAPIURL + "/images?path=\(path)"
    }
    
    public func getRandomImageURL(id: Int) -> String  {
        return Constants.baseAPIURLLocal + "/get_image/\(id)"
    }
    
    
    // MARK: HTTP REQUESTS
    
    enum HTTPMethod: String {
        case GET
        case POST
    }
    
    private func createRequest(with url: URL?, type: HTTPMethod, completion: @escaping (URLRequest) -> Void) {
        guard let apiURL = url else { return }
        
        var request = URLRequest(url: apiURL)
        request.httpMethod = type.rawValue
        
        completion(request) // continue the request
    }
    
}
