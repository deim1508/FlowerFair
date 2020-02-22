//
//  BackendManager.swift
//  FlowerFair
//
//  Created by Rebeka on 22/02/2020.
//  Copyright © 2020 babycougar. All rights reserved.
//

import Alamofire
import Foundation

class BackendManager {
    static func execute<T: Decodable>(request: RequestRepresentable, succes: @escaping ([T]) -> Void, failure: @escaping(Error) -> Void) {
        performRequest(request: request) { response in
            switch response.result {
            case .success(let data):
                do {
                    let returnValue = try JSONDecoder().decode([T].self, from: data)
                    succes(returnValue)
                } catch {
                    failure(BackendError.invalidJSON)
                }
            case .failure(let error):
                failure(error)
            }
        }
    }
    
    private static func performRequest(request: RequestRepresentable, completion: @escaping (AFDataResponse<Data>) -> Void) {
        do {
            let dataRequest = try self.buildRequest(request: request)
            dataRequest
                .validate()
                .responseData { response in
                    completion(response)
                }
        } catch {
            print("Something went wrong with the request!")
            return
        }
    }
    
    private static func buildHeader() -> HTTPHeaders {
        var headers: HTTPHeaders {
            return [HTTPHeaderField.contentType.rawValue: ContentType.json.rawValue]
        }
        return headers
    }
    
    private static func buildRequest(request: RequestRepresentable) throws -> DataRequest {
        let url = try NetworkConstans.ProductionServer.baseURL
            .asURL()
            .appendingPathComponent(request.suffix)
        return AF.request(url, method: request.methodType, parameters: request.parameters, encoding: request.encoding, headers: buildHeader())
    }
}
