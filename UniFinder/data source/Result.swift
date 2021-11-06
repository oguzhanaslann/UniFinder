//
//  Result.swift
//  UniFinder
//
//  Created by Oğuzhan Aslan on 29.10.2021.
//

import Foundation

enum NetworkResult<T> {
    
    case Loading
    case Success(Content<T>)
    case Error(String)
    
}


struct Content<Data> {
    let data : Data
    
    static func createFrom(data : Data) -> Content<Data> {
        return Content.init(t: data)
    }
}
