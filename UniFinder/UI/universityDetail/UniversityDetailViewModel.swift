//
//  UniversityDetailViewModel.swift
//  UniFinder
//
//  Created by Oğuzhan Aslan on 16.10.2021.
//

import Foundation

class UniversityDetailViewModel : ViewModel {
    let universityDetail = Observable<DataState<UniversityDetail>>(DataState.getDefaultCase())
    
    let universityRepository : UniversityRepository
    
    
    init(universityNetworkSource : UniversityNetworkSource) {
        universityRepository   = UniversityRepository(apiService: universityNetworkSource)
    }
    
    public func getUniversityDetailFor(id : Int) {
        universityRepository.fetchUniversityDetail(
            id: id,
            onSuccess: {detail in
                print("detail \(detail)")
                self.universityDetail.value = DataState.Success(DataContent.createFrom(data:  detail))
            },
            onError: {error in
                self.universityDetail.value = DataState.Error(error)
            },
            onLoading: {
                self.universityDetail.value = DataState.Loading
            }
        )
        
    
        
    }
}
