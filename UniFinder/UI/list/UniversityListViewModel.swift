//
//  UniversityListViewModel.swift
//  UniFinder
//
//  Created by Oğuzhan Aslan on 3.10.2021.
//

import Foundation

class UniversityListViewModel : ViewModel {
  
    let universityList = Observable<[UniversityListItem]>([])
   
    var currentPage = 1
    
    
    private func fetchData(on page: Int,onSuccess: @escaping  () -> Void = {} ) {
        APIService.shared.fetchUniversitylistList(
            on : page,
            onLoading: {
            
            },
            onComplation: {result in
                switch result {
                    case .Error(let error):
                        print("error : \(error)")
                    case .Loading:
                        print("Loading")
                    case .Success(let unilist ):
                        
                            var currentList =   self.universityList.value
                        
                            unilist.data.results?.forEach({ universityDTO in
                                currentList.append(
                                    UniversityListItem.createFrom(universityDTO: universityDTO)
//                                    DataState.Success(DataContent.init(data:))
                                )
                            })
                            
                            self.universityList.value = currentList
                            
                            onSuccess()
                       
                }
        })
    }
    
    func fetchInitialPage() {
        currentPage = 1
        fetchData(on: currentPage)
    }
    
    func fetchNextPage() {
        fetchData(on: currentPage + 1) {
            self.currentPage += 1
        }
    }
    
    
    
    
}
