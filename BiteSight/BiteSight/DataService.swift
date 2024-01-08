////
////  DataService.swift
////  BiteSight
////
////  Created by (Vincent) GuoWei Li on 11/27/23.
////
//
import Foundation
import Alamofire

struct DataService {

    let apiKey = Bundle.main.infoDictionary?["API_KEY"] as? String
//    let apiKey = APIConfigs.apiKey

    func getCloseByRestaurants(latitude: Double, longitude: Double, completion: @escaping (Result<[Business], Error>) -> Void) {
        guard apiKey != nil else {
            return
        }
        
        print("api key: \(apiKey)")
        
        let endpoint = Configs.searchRestaurantBaseURL
        let parameters: [String: Any] = [
            "latitude": latitude,
            "longitude": longitude,
            "sort_by": "distance",
            "is_closed": false,
            "limit": 20
        ]
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(apiKey!)",
            "accept": "application/json"
        ]

        AF.request(endpoint, method: .get, parameters: parameters, headers: headers).responseData { response in
            let status = response.response?.statusCode
            switch response.result {
            case .success(let data):
                if let uwStatusCode = status {
                    switch uwStatusCode {
                    case 200...299:
                        let decoder = JSONDecoder()
                        do {
                            let receivedData = try decoder.decode(BusinessSearch.self, from: data)
                            print("api call success: \(receivedData)")
                            completion(.success(receivedData.businesses!))
//                            print(data)
                        } catch {
                            print("Decoding error: \(error)")
                        }

                    case 400...499:
                        print("Client-side error: \(data)")

                    default:
                        print("Server-side error: \(data)")
                    }
                }

            case .failure(let error):
                print("Network error: \(error)")
            }
        }
    }
    
    func getCityRestaurants(city: String, completion: @escaping (Result<[Business], Error>) -> Void) {
        guard apiKey != nil else {
            return
        }
        
        let endpoint = Configs.searchRestaurantBaseURL
        let parameters: [String: Any] = [
            "location": city,
            "is_closed": false,
            "sort_by": "rating",
            "limit": 20
        ]
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(apiKey!)",
            "accept": "application/json"
        ]

        AF.request(endpoint, method: .get, parameters: parameters, headers: headers).responseData { response in
            let status = response.response?.statusCode
            switch response.result {
            case .success(let data):
                if let uwStatusCode = status {
                    switch uwStatusCode {
                    case 200...299:
                        let decoder = JSONDecoder()
                        do {
                            let receivedData = try decoder.decode(BusinessSearch.self, from: data)
                            print("api call success: \(receivedData)")
                            completion(.success(receivedData.businesses!))
//                            print(data)
                        } catch {
                            print("Decoding error: \(error)")
                        }

                    case 400...499:
                        print("Client-side error: \(data)")

                    default:
                        print("Server-side error: \(data)")
                    }
                }

            case .failure(let error):
                print("Network error: \(error)")
            }
        }
    }
}

