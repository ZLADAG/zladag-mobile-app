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
        static let baseAPIURL = "https://e998-158-140-189-122.ngrok-free.app/"
//        static let baseAPIURL = "http://localhost:8100/api"

//        static let baseAPIURL = "https://zladag-sasato.uc.r.appspot.com/api"
        static let baseAPIURLLocal = "http://localhost:8080/api"
    }
    
    enum APIError: Error {
        case failedToGetData
        
        case invalidURL
        case requestFailed
        case invalidResponse
        case jsonSerializationFailed
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
    
    public func postOTP(completion: @escaping (Result<HomeBoardingResponse, Error>) -> Void) {
        createRequest(with: URL(string: Constants.baseAPIURL + "/signiasdasdas"), type: .POST) { baseRequest in
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
                    /*
                     CARA NGIRIM JSON BODY KE API
                     {
                    body = {
                        "otp": 123
                     } // gimana car aswift
                     
                     */
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
    
    
    
    
    public func searchPhoneNumIsExist(num: String, completion: @escaping (Bool) -> Void){
        let params = "?phoneNumber=\(num)"
        let url = URL(string: "\(MyConstants.Urls.searchPhoneNumURLPath)\(params)")!
        let responseType = SearchAccByPhoneResponse.self
        let reqMethod = HTTPMethod.GET
                
        fetchDataGETRequest(from: url, responseType: responseType, httpReqMethod: reqMethod) { result in
            switch result {
            case .success(let response):
                print(response)
                completion(response.hasAnAccount)

            case .failure(let error):
                print("Error: \(error)")
                completion(false)
            }
        }
        
    }
    
    
    
    
    func fetchDataGETRequest <T: Codable>(from url: URL, responseType: T.Type, httpReqMethod method: HTTPMethod, completion: @escaping (Result<T, Error>) -> Void) {
        
        createRequest(with: url, type: method) { baseRequest in
            let task = URLSession.shared.dataTask(with: baseRequest) { data, _, error in
                guard let data = data, error == nil else {
                    completion(.failure(error!))
                    return
                }
                
                do {
                    let result = try JSONDecoder().decode(T.self, from: data)
                    completion(Result.success(result))
                } catch {
                    print("error in \(T.self):", error.localizedDescription)
                    completion(Result.failure(error))
                }
            }
            task.resume()
        }
    }
    
//    func fetchDataGETRequest <T: Codable>(from url: URL, responseType: T.Type, httpReqMethod method: HTTPMethod, completion: @escaping (Result<T, Error>) -> Void) {
//
//        createRequest(with: url, type: method) { baseRequest in
//            let task = URLSession.shared.dataTask(with: baseRequest) { data, response, error in
//                guard let data = data, error == nil else {
//                    completion(.failure(error!))
////                    completion(.failure(APIError.invalidResponse))
//                    return
//                }
//
//                guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
//                    completion(.failure(APIError.requestFailed))
//                    return
//                }
//
//                do {
//                    let result = try JSONDecoder().decode(T.self, from: data)
//                    completion(Result.success(result))
//                } catch {
//                    print("error in \(T.self):", error.localizedDescription)
//                    completion(Result.failure(error))
//                }
//            }
//            task.resume()
//        }
//    }
//
//    func fetchDataPOSTRequest <B: Encodable, T: Decodable>(
//        url: URL,
//        requestBody: B,
//        responseType: T.Type,
//        completion: @escaping (Result<T, Error>) -> Void
//    ) {
//
//        // Create a URLSession
//        let session = URLSession.shared
//
//        // Define the request method as POST
//        var request = URLRequest(url: url)
//        request.httpMethod = "POST"
//
//        // Set the request headers and body
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//
//        do {
//            let jsonData = try JSONEncoder().encode(requestBody)
//            request.httpBody = jsonData
//        } catch {
//            completion(.failure(APIError.jsonSerializationFailed))
//            return
//        }
//
//        // Create a data task to send the request
//        let task = session.dataTask(with: request) { data, response, error in
//            if let error = error {
//                completion(.failure(error))
//                return
//            }
//
//            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
//                completion(.failure(APIError.requestFailed))
//                return
//            }
//
//            guard let data = data else {
//                completion(.failure(APIError.invalidResponse))
//                return
//            }
//
//            do {
//                let responseObject = try JSONDecoder().decode(T.self, from: data)
//                completion(.success(responseObject))
//            } catch {
//                completion(.failure(APIError.jsonSerializationFailed))
//            }
//        }
//
//        task.resume()
//    }
//
    
    
    
    
    
    
    
    
    
    // MARK: HTTP REQUESTS
    
    enum HTTPMethod: String {
        case GET
        case POST
    }
    
    private func createRequest(with url: URL?, type: HTTPMethod, completion: @escaping (URLRequest) -> Void) {
        guard let apiURL = url else { return }
        
        var request = URLRequest(url: apiURL)
        request.httpMethod = type.rawValue
        // nanti tanya cindy apakah sudah wajib set header auth sebelum requests
        
        completion(request) // continue the request
    }
    

    

    
}
