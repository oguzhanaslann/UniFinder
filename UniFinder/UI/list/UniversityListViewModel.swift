//
//  UniversityListViewModel.swift
//  UniFinder
//
//  Created by Oğuzhan Aslan on 3.10.2021.
//

import Foundation

class UniversityListViewModel : ViewModel {
  
    let universityList = Observable<[UniversityListItem]>([])
    
    func fetchData() {
        self.universityList.value = [
            UniversityListItem(id: "0",imageUrl: "https://via.placeholder.com/180x120", name: "Yaşar Universitesi", city: "İzmir"),
            UniversityListItem(id: "1",imageUrl: "https://via.placeholder.com/180x120", name: "Celal Bayar Universitesi", city: "Isparta"),
            UniversityListItem(id: "2",imageUrl: "https://via.placeholder.com/180x120", name: "İzzet Baysal Universitesi", city: "Bolu")
        ]
    }
    
    
}
