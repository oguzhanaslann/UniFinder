//
//  APIService.swift
//  UniFinder
//
//  Created by Oğuzhan Aslan on 17.10.2021.
//

import Foundation
import Alamofire
import SwiftyJSON


class APIService : UniversityNetworkSource{
    
    static let shared = APIService()
    
    func fetchUniversitylistList(
        on page: Int,onLoading : @escaping () -> Void ,
        onComplation :  @escaping (NetworkResult<APIResponse<[UniversityDTO]>>) -> Void) ->NetworkResult<APIResponse<[UniversityDTO]>> {
    
        let result : NetworkResult<APIResponse<[UniversityDTO]>> =
            fetchResult(
                url: APIURLManager.createUrlFor(
                    action : APIUrlAction.UniversityList(page: page)
                ),
                onLoading : onLoading,
                onComplation : onComplation
       )
    
      
        return result
     
    }


    
    
    func fetchUniversityDetail(
        with id: Int,
        onLoading: @escaping () -> Void,
        onComplation: @escaping (NetworkResult<UniversityDTO>
    ) -> Void) -> NetworkResult<UniversityDTO> {

        print(" url : \((APIURLManager.createUrlFor(action : APIUrlAction.UniversityDetail(pk: id))))")
        
        let result : NetworkResult<UniversityDTO> = fetchResult(
            url: APIURLManager.createUrlFor(action : APIUrlAction.UniversityDetail(pk: id)),
            onLoading: onLoading,
            onComplation: onComplation
        )
    
      
        return result
    }
    
    
    
    func fetchUniversityListWithName(
        name : String,
        page : Int,
        onLoading: @escaping () -> Void,
        onComplation: @escaping (NetworkResult<APIResponse<[UniversityShortDTO]>>) -> Void) -> NetworkResult<APIResponse<[UniversityShortDTO]>> {
            
        
        let parameters : Parameters = [
            "q" : name
        ]
        
        let result : NetworkResult<APIResponse<[UniversityShortDTO]>> =
            fetchResult(
                url: APIURLManager.createUrlFor(
                    action : APIUrlAction.UniversityListSearch(page: page, name: name)
                ),
                onLoading : onLoading,
                onComplation : onComplation,
                method: .post,
                parameters: parameters
       )
    
      
        return result
     
    }
    
    
    
    func fetchResult<T: Codable>(
        url : String,
        onLoading :@escaping () -> Void ,
        onComplation : @escaping  (NetworkResult<T>) -> Void,
        method: HTTPMethod = .get,
        parameters: Parameters? = nil
    ) -> NetworkResult<T> {
        
        var result : NetworkResult<T> = NetworkResult.getDefaultCase()
    
        onLoading()
        
        AF.request(
            url,
            method: method,
            parameters: parameters,
            encoding: Alamofire.JSONEncoding.default
        )
        .validate()
        .response { response in
            print("Call \(method.rawValue), response code :  \(response.response?.statusCode)")
          
            switch response.result {
            case .success(let value):
                do {
                    let decodedResult = try JSONDecoder().decode(T.self, from: value!)
                    result = NetworkResult.Success(Content.createFrom(data: decodedResult))
                    onComplation(result)
                    
                } catch { print(error) }
                
            case .failure(let error):
                
                result = NetworkResult<T>.Error("\(error)")
                onComplation(result)
            }
            

        }
        
        return result
        
    }
    
    
    
    
}




