//
//  LoginService.swift
//
//  Created by Tommy on 04/12/21.
//

import Foundation
import UIKit

protocol HomeService {
    func home(url: String ,httpMethod: HttpMethod, result: @escaping (HomeResponse) -> Void)
}

class HomeServiceImpl: HomeService {
    private let network: NetworkHelper<HomeResponse>

    init(network: NetworkHelper<HomeResponse>) {
        self.network = network
    }
    
    func home(url: String, httpMethod: HttpMethod, result: @escaping (HomeResponse) -> Void) {
        network.performDataTask(url: url, httpMethod: httpMethod, body: nil) { error in
        } successResponse: { data in
            result(data)
        }
    }
}
