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
        static let baseAPIURL = "https://zladag-catnip-services.as.r.appspot.com/api"
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
        getRequest(path: "/home") { result in
            completion(result)
        }
    }
    
    public func getBoardingsSearch(params: String, completion: @escaping (Result<SearchBoardingsResponse, Error>) -> Void) {
        getRequest(path: "/search?\(params)") { result in
            completion(result)
        }
    }
    
    public func getBoardingBySlug(slug: String, completion: @escaping (Result<BoardingDetailsResponse, Error>) -> Void) {
        print("Slug: \(slug)")
        getRequest(path: "/boardings/\(slug)") { result in
            completion(result)
        }
    }
    
    public func getUserProfile(completion: @escaping (Result<UserProfileResponse, Error>) -> Void) {
        getRequest(path: "/profile", usingToken: true) { result in
            completion(result)
        }
    }
    
    public func getPetDetailsById(id: String, completion: @escaping (Result<PetProfileDetailsResponse, Error>) -> Void) {
        getRequest(path: "/profile/pets/\(id)", usingToken: true) { result in
            completion(result)
        }
    }
    
    public func getBreedsAndHabits(species: String, completion: @escaping (Result<BreedsAndHabitsResponse, Error>) -> Void) {
        getRequest(path: "/pet-categories/\(species)/breeds-and-habits", usingToken: true) { result in
            completion(result)
        }
    }
    
    public func getSearchPhoneNumIfExists(num: String, completion: @escaping (Result<SearchAccByPhoneResponse, Error>) -> Void) {
        getRequest(path: "/search-for-account-by-phone-number?phoneNumber=\(num)") { result in
            completion(result)
        }
    }
    
    public func getBoardingReservationDataBySlug(slug: String, completion: @escaping (Result<BoardingReservationDataResponse, Error>) -> Void) {
        print("Slug: \(slug)")
        getRequest(path: "/boardings/\(slug)/pets-cages-and-services", usingToken: true) { result in
            completion(result)
        }
    }
    
    public func getProfileOrders(isActive: Bool, completion: @escaping (Result<OrdersResponse, Error>) -> Void) {
        getRequest(path: "/profile/orders?active=\(isActive.description)", usingToken: true) { result in
            completion(result)
        }
    }
    
    public func getOrderDetailsById(orderId: String, completion: @escaping (Result<OrderDetailsResponse, Error>) -> Void) {
        getRequest(path: "/profile/orders/\(orderId)", usingToken: true) { result in
            completion(result)
        }
    }
    
    public func postPetOrder(postOrdersBody: PostOrdersBody, completion: @escaping (Result<VerificationCodeResponse, Error>) -> Void) {
        postRequest(
            path: "/profile/orders/store",
            usingToken: true,
            body: postOrdersBody) { result in
                completion(result)
            }
    }
    
    public func postAskWhatsAppVerificationCode(sendPhoneCodeBody: SendPhoneCodeBody, completion: @escaping (Result<VerificationCodeResponse, Error>) -> Void) {
        postRequest(
            path: "/send-whatsapp-verification-code",
            body: sendPhoneCodeBody) { result in
                completion(result)
            }
    }
    
    public func postValidateWhatsAppVerificationCode(validatePhoneCodeBody: ValidatePhoneCodeBody, completion: @escaping (Result<SuccessResponse, Error>) -> Void) {
        postRequest(
            path: "/validate-whatsapp-verification-code",
            body: validatePhoneCodeBody) { result in
                completion(result)
            }
    }
    
    public func postCreateOrder(createReservationBody: CreateReservationBody, completion: @escaping (Result<SuccessResponse, Error>) -> Void) {
        postRequest(
            path: "/profile/orders/store",
            usingToken: true,
            body: createReservationBody) { result in
                completion(result)
            }
    }

    public func postFcmToken(firebaseCloudMessagingToken: FirebaseCloudMessagingToken, completion: @escaping (Result<SuccessResponse, Error>) -> Void) {
        postRequest(
            path: "/set-token",
            usingToken: true,
            body: firebaseCloudMessagingToken) { result in
                completion(result)
            }
    }
    
    public func getImage(path: String) -> String  {
        return Constants.baseAPIURL + "/images?path=\(path)"
    }
    
    public func getRandomImageURL(id: Int) -> String  {
        return Constants.baseAPIURLLocal + "/get_image/\(id)"
    }

    
    // MARK: GENERIC REQUESTS
    
    func getRequest<T: Codable>(
        path: String,
        usingToken: Bool = false,
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        
        guard let apiURL = URL(string: Constants.baseAPIURL + path) else { return }
        
        var request = URLRequest(url: apiURL)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        print(AuthManager.shared.token)

        if usingToken {
            request.addValue(
                "Bearer " + (AuthManager.shared.token ?? "NO-TOKEN"),
                forHTTPHeaderField: "Authorization"
            )
        }
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(error!))
                return
            }
            
            do {
                let result = try JSONDecoder().decode(T.self, from: data)
                print("GET \(path)")
                completion(Result.success(result))
            } catch {
                let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments)
                print(json)
                
                print("error in GET \(path)\n", error.localizedDescription)
                completion(Result.failure(error))
            }
        }.resume()
    }
    
    public func postRequest<A: Codable, B: Codable>(
        path: String,
        usingToken: Bool = false,
        body: B? = nil,
        completion: @escaping (Result<A, Error>) -> Void
    ) {
        var req = URLRequest(url: URL(string: Constants.baseAPIURL + path)!)
        req.httpMethod = "POST"
        req.setValue("application/json", forHTTPHeaderField: "Content-Type")
        req.setValue("application/json", forHTTPHeaderField: "Accept")
        
        if let body {
            print("\nUSING HTTP BODY")
            print(body)
            req.httpBody = try? JSONEncoder().encode(body)
//            let body: [String: Any] = [
//                "boarding": "pinkpetz",
//                "checkInDate": "2023-12-22",
//                "checkOutDate": "2023-12-23",
//                "orders": [
//                    [
//                        "petId": "PT6522321364",
//                        "note": "",
//                        "boardingCageId": "BF5474689054",
//                        "boardingServiceIds": ["BF3890412831", "BF3511921720", "BF2073565413"]
//                    ]
//                ]
//            ]
//            req.httpBody = try! JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
        }
        
        if usingToken {
            req.addValue(
                "Bearer " + (AuthManager.shared.token ?? "NO-TOKEN"),
                forHTTPHeaderField: "Authorization"
            )
        }
        
        URLSession.shared.dataTask(with: req) { data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(error!))
                return
            }
            
            do {
                let result = try JSONDecoder().decode(A.self, from: data)
                completion(Result.success(result))
            } catch {
                let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments)
                print(json)
                
                print("error when decoding in \(path):\n", error.localizedDescription)
                completion(Result.failure(error))
            }
        }.resume()
    }
    
}
