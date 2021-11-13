//
//  DataState.swift
//  UniFinder
//
//  Created by Oğuzhan Aslan on 5.11.2021.
//

import Foundation


enum DataState<T> {
    
    case Loading
    case Success(DataContent<T>)
    case Error(String)
    case Empty
    
    static func getDefaultCase() -> DataState {
        return DataState.Empty
    }
    
}




struct DataContent<Data> {
    let data : Data
    static func createFrom(data : Data) -> DataContent<Data> {
        return DataContent.init(data: data)
    }
}
