//
//  UniversityListItem.swift
//  UniFinder
//
//  Created by Oğuzhan Aslan on 23.09.2021.
//

import Foundation


struct UniversityListItem {
    let id : String
    let imageUrl : String
    let name : String
    let city : String 
}

extension UniversityListItem {
    static func createFrom(universityDTO : UniversityDTO)  -> UniversityListItem{
            return  UniversityListItem(
                id: String(universityDTO.pk ?? 0 ),
                imageUrl: universityDTO.thumbnail ?? "",
                name: universityDTO.name ?? ""     ,
                city: universityDTO.country?.name ?? ""
            )
    }
}
