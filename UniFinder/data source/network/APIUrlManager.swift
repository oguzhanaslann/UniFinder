//
//  APIUrlManager.swift
//  UniFinder
//
//  Created by Oğuzhan Aslan on 17.10.2021.
//

import Foundation

class APIURLManager {
    static let BASE_URL = "https://univerlist.com/en/api/v2"
    
   
    public static func createUrlFor(action : APIUrlAction) -> String {
        switch action {
        case .UniversityDetail :
            return "\(APIURLManager.BASE_URL)/university"
        case .UniversityList(let page, let pageSize):
            print("\(APIURLManager.BASE_URL)/university/?page=\(page)&page_size=\(pageSize)")
            return "\(APIURLManager.BASE_URL)/university/?page=\(page)&page_size=\(pageSize)"
       
        default:
            return APIURLManager.BASE_URL
        }
        

    }
}

enum APIUrlAction{
    case UniversityList(page: Int, pageSize:Int = 10 )
    case UniversityDetail
}
