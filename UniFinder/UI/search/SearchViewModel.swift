//
//  SearchViewModel.swift
//  UniFinder
//
//  Created by Oğuzhan Aslan on 14.11.2021.
//

import Foundation

class SearchViewModel {
    let universityList = Observable<DataState<[UniversityListItem]>>(DataState.getDefaultCase())
   
    let universityRepository : UniversityRepository
    
    
    
    init(universityNetworkSource : UniversityNetworkSource) {
        universityRepository   = UniversityRepository(apiService: universityNetworkSource)
    }
        
    private var searchText : String? = nil
    private var currentPage: Int = 1
    
    func doSearchWith(page:Int, text: String, onSuccess: @escaping  () -> Void = {}) {
        universityRepository.fetchUniversityListWithName(
            name: text,
            page: page,
            onSuccess: {result in
                print("result \(result.count) ")
                print("first \(result[0])")
                onSuccess()
                self.universityList.value = DataState.Success(DataContent.createFrom(data:  result))
            },
            onError: { error in
                print("err \(error) ")
                self.universityList.value = DataState.Error(error)
            },
            onLoading: {
                print("load ")
                self.universityList.value = DataState.Loading
            }
        )
    }
    
    func onSearchTextChanged(to text: String ) {
        currentPage = 1
        searchText = text
        doSearchWith(page: currentPage, text: text)
    }
}
