//
//  UniversityListItem.swift
//  UniFinder
//
//  Created by Oğuzhan Aslan on 23.09.2021.
//

import Foundation


struct UniversityListItem {
    let id : Int
    let imageUrl : String
    let name : String
    let city : String 
}

extension UniversityListItem {
    static func createFrom(universityDTO : UniversityDTO)  -> UniversityListItem{
            return  UniversityListItem(
                id: universityDTO.pk ?? 0,
                imageUrl: universityDTO.thumbnail ?? "",
                name: universityDTO.name ?? ""     ,
                city: universityDTO.province?.name ?? ""
            )
    }
    
    static func createFrom( universityShortDTO: UniversityShortDTO) -> UniversityListItem {
        return UniversityListItem(
            id: universityShortDTO.pk ?? 0,
            imageUrl: universityShortDTO.thumbnail ?? "",
            name: universityShortDTO.name ?? ""     ,
            city: universityShortDTO.province ?? ""
        )
    }
}
