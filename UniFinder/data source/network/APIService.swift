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
            fetchResult(url: APIURLManager.createUrlFor(
                action : APIUrlAction.UniversityList(page: page)),
                onLoading : onLoading,
                onComplation : onComplation
       )
    
      
        return result
     
    }

    func fetchUniversityDetail(with id: Int,onLoading : () -> Void , onComplation :  (NetworkResult<APIResponse<UniversityDetailDTO>>) -> Void) -> NetworkResult<APIResponse<UniversityDetailDTO>> {
         return NetworkResult.Error("")
    }
    
    func fetchResult<T: Decodable>(url : String, onLoading :@escaping () -> Void , onComplation : @escaping  (NetworkResult<T>) -> Void ) -> NetworkResult<T> {
        
        
        var result : NetworkResult<T> = NetworkResult.getDefaultCase()
       
        
        onLoading()
        
        AF.request(
            url,
            method: .get
        )
        .validate()
        .response { response in
            print("response : \(response)")
            switch response.result {
              
            case .success(let value):
                print("value : \(value)")
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




