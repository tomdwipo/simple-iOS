//
//  LoginResponse.swift
//
//  Created by Tommy on 03/12/21.
//

import Foundation

struct HomeResponse: Decodable {
    let data: [HomeData]
   
}

struct HomeData: Decodable {
    let name: String
    let about: String
    let photo : PhotoData
    let specialization: SpecializationData
    let hospital: [HospitalData]
    let price: PriceData
}

struct PhotoData: Decodable {
    let url: String
}

struct SpecializationData: Decodable {
    let name: String
}

struct HospitalData: Decodable {
    let name: String
}

struct PriceData: Decodable {
    let formatted: String
}
