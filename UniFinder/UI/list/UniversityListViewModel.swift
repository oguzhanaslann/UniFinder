//
//  UniversityListViewModel.swift
//  UniFinder
//
//  Created by Oğuzhan Aslan on 3.10.2021.
//

import Foundation

class UniversityListViewModel : ViewModel {
  
    let universityList = Observable<DataState<[UniversityListItem]>>(DataState.getDefaultCase())
   
    let universityRepository : UniversityRepository
    
    private var currentPage = 1
    
    
    init(universityNetworkSource : UniversityNetworkSource) {
        universityRepository   = UniversityRepository(apiService: universityNetworkSource)
    }
        
    

    
    private func fetchData(on page: Int,onSuccess: @escaping  () -> Void = {} ) {
        
        universityRepository.fetchUniversityList(on: page) { universityItemList in
            onSuccess()
            self.universityList.value = DataState.Success(DataContent.createFrom(data:  universityItemList))
        } onError: { error  in
            self.universityList.value = DataState.Error(error)
        } onLoading: {
            self.universityList.value = DataState.Loading
        }
    }
    
    func fetchInitialPage() {
        currentPage = 1
        fetchData(on: currentPage)
    }
    
    func fetchNextPage() {
        fetchData(on: currentPage + 1) {
            self.currentPage += 1
            print("currentpage \(self.currentPage)")
        }
    }
    
    func getCurrentPageNumber() -> Int  {
        return currentPage
    }
    
    
}
