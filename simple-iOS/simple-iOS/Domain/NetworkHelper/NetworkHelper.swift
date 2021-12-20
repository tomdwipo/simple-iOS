//
//  NetworkHelper.swift
//
//  Created by Tommy on 03/12/21.
//

import UIKit
protocol URLSessionProtocol {
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
    
}

extension URLSession: URLSessionProtocol {
    
}

enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
}

enum AppError: Error {
    case networkError(Error)
    case decodingError(String)
    case noResponse
    
    public func errorMessage() -> String {
        switch self {
        case .networkError(let error):
            return "networkError: \(error)"
        case .decodingError(let error):
            return "\(error)"
        case .noResponse:
            return "no response"
        }
    }
}

class NetworkHelper<T: Decodable> {
    var session: URLSessionProtocol = URLSession.shared
    private var dataTask: URLSessionDataTask?
    var result: T?
    
    deinit {
        dataTask = nil
        result = nil
    }
    
    func performDataTask(url: String, httpMethod: HttpMethod, body: [String: Any]?, authorization: String? = nil,errorResponse: @escaping (AppError) ->Void, successResponse: @escaping (T) -> Void){
        let url = URL(string: url)
        var request = URLRequest(url: url!)
        request.httpMethod = httpMethod.rawValue
        if let body = body {
            let httpBody = try? JSONSerialization.data(withJSONObject: body)
            request.httpBody = httpBody
        }
        if let authorization = authorization {
            request.addValue("Bearer \(authorization)", forHTTPHeaderField: "Authorization")
        }
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        dataTask = self.session.dataTask(with: request, completionHandler: { [weak self] (data: Data?, response: URLResponse?, error: Error?) -> Void in
            guard let self = self else { return }
            var decoded: T?
            var message: String?
            if let error = error {
                message = String(describing: error)
            }else if let response = response as? HTTPURLResponse, response.statusCode != 200 {
                if response.statusCode == 422 {
                    message = "The email has already been taken."
                }else if(response.statusCode == 400){
                    message = "Terjadi kesalahan pada sistem"
                }else{
                    message =  HTTPURLResponse.localizedString(forStatusCode: response.statusCode)
                }
            }else if let data =  data {
                do {
                    decoded = try JSONDecoder().decode(T.self, from: data)
                }catch {
                    message = error.localizedDescription
                }
            }else{
                message = "data nil"
            }
          
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                if let decoded = decoded {
                    self.result = decoded
                    successResponse(decoded)
                    return
                }
                if let message = message {
                    errorResponse(AppError.decodingError(message))
                    return
                }
            }
          
        })
        dataTask?.resume()
    }
}
