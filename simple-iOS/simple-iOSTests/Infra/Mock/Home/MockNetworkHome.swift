//
//  MockNetworkLogin.swift
//
//  Created by Tommy on 04/12/21.
//

import Foundation
@testable import simple_iOS

class MockNetworkHome : NetworkHelper<HomeResponse> {
    
    override func performDataTask(url: String, httpMethod: HttpMethod, body: [String : Any]?, authorization: String? = nil, errorResponse: @escaping (AppError) -> Void, successResponse: @escaping (HomeResponse) -> Void) {
        if url == "" {
            errorResponse(AppError.decodingError("url empty"))
            return
        }
        
        successResponse(HomeResponse(data: [HomeData(name: "name", about: "about", photo: PhotoData(url: "url"), specialization: SpecializationData(name: "name"), hospital: [HospitalData(name: "name")], price: PriceData(formatted: "format"))]))
    
    }
}
