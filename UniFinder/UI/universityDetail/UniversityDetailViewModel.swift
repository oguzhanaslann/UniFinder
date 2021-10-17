//
//  UniversityDetailViewModel.swift
//  UniFinder
//
//  Created by Oğuzhan Aslan on 16.10.2021.
//

import Foundation

class UniversityDetailViewModel : ViewModel {
    let universityDetail = Observable<UniversityDetail?>(nil)
    
    public func getUniversityDetailFor(id : String) {
        universityDetail.value = UniversityDetail(
            id: id,
            name: "String",
            cityName: "String",
            coverPhotoUrl: "https://via.placeholder.com/180x120",
            promotionImageUrls: [
                "https://via.placeholder.com/180x120",
                "https://via.placeholder.com/180x120",
                "https://via.placeholder.com/180x120",
                "https://via.placeholder.com/180x120",
                "https://via.placeholder.com/180x120",
                "https://via.placeholder.com/180x120"
            ])
    }
}
