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
    
    func doSearchWith(page:Int, text: String,shouldAppend:Bool = false , onSuccess: @escaping  () -> Void = {}) {
        universityRepository.fetchUniversityListWithName(
            name: text,
            page: page,
            onSuccess: {result in
                print("SearchViewModel: Search result success")
                onSuccess()
                
                if shouldAppend {
                    self.appendListToCurrentStateIfPossible(result:result)
                } else {
                    self.universityList.value = DataState.Success(DataContent.createFrom(data:  result))
                }
                
                
            },
            onError: { error in
                print("SearchViewModel: Search result error")
                self.universityList.value = DataState.Error(error)
            },
            onLoading: {
                print("SearchViewModel: Search Loading")
                self.universityList.value = DataState.Loading
            }
        )
    }

    private func appendListToCurrentStateIfPossible(result: [UniversityListItem]) {
        switch (universityList.value) {
        case .Success(let currentData):
            var newList : [UniversityListItem] = []
            let currentList = currentData.data
            newList.append(contentsOf: currentList)
            newList.append(contentsOf: result)
            self.universityList.value = DataState.Success(DataContent.createFrom(data:  newList))
            break;
        default:
            self.universityList.value = DataState.Success(DataContent.createFrom(data:  result))
            break;
        }
    }
    
    func onSearchTextChanged(to text: String ) {
        currentPage = 1
        searchText = text
        doSearchWith(page: currentPage, text: text)
    }
    
    func fetchNextPage(){
        doSearchWith(page: currentPage, text: searchText ?? "",shouldAppend: true) {
            self.currentPage += 1
        }
    }
    
    func getCurrentPageNumber() -> Int {
        return currentPage
    }
}
