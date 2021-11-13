//
//  UniversityDetail.swift
//  UniFinder
//
//  Created by Oğuzhan Aslan on 16.10.2021.
//

import Foundation

struct UniversityDetail {
    let id : Int
    let name : String
    let cityName : String
    let coverPhotoUrl : String
    let promotionImageUrls : [String]
}

extension UniversityDetail {
    static func createFrom( universityDTO: UniversityDTO) -> UniversityDetail {
        return UniversityDetail(
            id: universityDTO.pk ?? -1 ,
            name: universityDTO.name ?? "",
            cityName: universityDTO.province?.name ?? "",
            coverPhotoUrl: universityDTO.thumbnail ?? "",
            promotionImageUrls: []
        )
    }
}
