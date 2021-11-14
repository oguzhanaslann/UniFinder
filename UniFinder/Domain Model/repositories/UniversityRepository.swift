//
//  UniversityRepository.swift
//  UniFinder
//
//  Created by Oğuzhan Aslan on 6.11.2021.
//

import Foundation


class UniversityRepository : Repository{
    
    let  apiService  : UniversityNetworkSource
    
    init(apiService : UniversityNetworkSource) {
        self.apiService = apiService
    }
    
    func fetchUniversityList(
        on page :Int,
        onSuccess: @escaping  ([UniversityListItem]) -> Void = {_ in },
        onError: @escaping  (String) -> Void = {_ in },
        onLoading: @escaping  () -> Void = { }
    ) {
        apiService.fetchUniversitylistList(
            on : page,
            onLoading: {
                onLoading()
            },
            onComplation: {result in
                switch result {
                    case .Error(let error):
                        onError(error)
                    case .Loading:
                        onLoading()
                    case .Success(let unilist ):
                        
                        var currentList : [UniversityListItem] = []
                    
                        unilist.data.results?.forEach({ universityDTO in
                            currentList.append(
                                UniversityListItem.createFrom(universityDTO: universityDTO)
                            )
                        })
                        
                        onSuccess(currentList)
                       
                }
            }
        )
    }
    
    func fetchUniversityDetail(
        id : Int,
        onSuccess: @escaping  (UniversityDetail) -> Void = {_ in },
        onError: @escaping  (String) -> Void = {_ in },
        onLoading: @escaping  () -> Void = { }
    ) {
        
        print("fetchUniversityDetail")
     
        apiService.fetchUniversityDetail(with: id) {
            onLoading()
        } onComplation: { result  in
            
               switch result {
                case .Error(let error):
                    onError(error)
                case .Loading:
                    onLoading()
                case .Success(let universityDTO ):
                    let  universityDetail = UniversityDetail.createFrom(universityDTO: universityDTO.data)
                    onSuccess(universityDetail)
                
                   
                   
            }
        }

    }
    
    
    func fetchUniversityListWithName(
        name:String,
        page:Int,
        onSuccess: @escaping  ([UniversityListItem]) -> Void = {_ in },
        onError: @escaping  (String) -> Void = {_ in },
        onLoading: @escaping  () -> Void = { }
    ) {
        apiService.fetchUniversityListWithName(
            name: name,
            page: page,
            onLoading:onLoading,
            onComplation: { result in
                switch result {
                    case .Error(let error):
                        onError(error)
                    case .Loading:
                        onLoading()
                    case .Success(let unilist ):
                        
                        var currentList : [UniversityListItem] = []
                    
                        unilist.data.results?.forEach({ universityShortDTO in
                            currentList.append(
                                UniversityListItem.createFrom(universityShortDTO: universityShortDTO)
                            )
                        })
                        
                        onSuccess(currentList)
                       
                }
            }
       )
    }
    
}
