//
//  LoginRepository.swift
//
//  Created by Tommy on 04/12/21.
//

import Foundation

protocol HomeRepository {
    func home( result: @escaping (HomeResponse) -> Void)
}

struct HomeRepositoryImpl : HomeRepository {
    private var homeService: HomeService
   
    init(network: NetworkHelper<HomeResponse>){
        homeService = HomeServiceImpl(network: network)
    }
    
    func home(result: @escaping (HomeResponse) -> Void) {
        homeService.home(url: "https://run.mocky.io/v3/c9a2b598-9c93-4999-bd04-0194839ef2dc", httpMethod: .get) { response in
            result(response)
        }
    }
    
    
}
