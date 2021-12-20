//
//  GetData.swift
//  simple-iOS
//
//  Created by Tommy on 20/12/21.
//

import Foundation
struct GetDataUseCase {
    private var repository: HomeRepository
    
    init() {
        repository = HomeRepositoryImpl(network: NetworkHelper<HomeResponse>())
    }
    
    func showDataToView(result: @escaping ([DataViewModel]) -> Void){
        repository.home { response in
            var dataView: [DataViewModel] = []
            response.data.forEach { element in
                dataView.append(DataViewModel(name: element.name, about: element.about, photo: element.photo.url, specialization: element.specialization.name, hospital: element.hospital.first!.name, price: element.price.formatted))
            }
            result(dataView)
        }
    }
}

