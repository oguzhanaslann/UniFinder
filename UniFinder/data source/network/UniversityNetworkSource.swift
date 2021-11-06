//
//  UniversityNetworkSource.swift
//  UniFinder
//
//  Created by Oğuzhan Aslan on 17.10.2021.
//

import Foundation

protocol UniversityNetworkSource{
    func fetchUniversitylistList(on page : Int,onLoading :@escaping () -> Void , onComplation :  @escaping(NetworkResult<APIResponse<[UniversityDTO]>>) -> Void) -> NetworkResult<APIResponse<[UniversityDTO]>>
    func fetchUniversityDetail(with id : Int,onLoading :@escaping () -> Void , onComplation :  @escaping(NetworkResult<APIResponse<UniversityDetailDTO>>) -> Void) -> NetworkResult<APIResponse<UniversityDetailDTO>>
}
