//
//  Injector.swift
//  UniFinder
//
//  Created by Oğuzhan Aslan on 6.11.2021.
//

import Foundation
import Swinject

class Injector {
    
    public static let shared =  Injector()
    
    let dependencyContainer  = Container()
    
    init() {
        dependencyContainer.register(APIService.self) { r in
            APIService.shared
        }
    }
    
    public func injectAPIService() -> APIService {
        
        registerDependencyIfNotRegistered(
            dependency: APIService.self,
            onRegisterNeeded: { r in
                APIService.shared
            }
        )
        
        return dependencyContainer.resolve(APIService.self)!
    }
    
    private func registerDependencyIfNotRegistered<T>(dependency : T.Type, onRegisterNeeded : @escaping ( Resolver ) -> T ) {
        
        if dependencyContainer.resolve(dependency.self) == nil  {
            dependencyContainer.register(dependency) { resolver in
                onRegisterNeeded(resolver)
            }
        }
        
    }
    
    
    public func injectUniversityListViewModel() ->  UniversityListViewModel {
        registerDependencyIfNotRegistered(
            dependency: UniversityListViewModel.self,
            onRegisterNeeded: {  r  in
                UniversityListViewModel(universityNetworkSource: self.injectAPIService())
            }
        )
     
        return dependencyContainer.resolve(UniversityListViewModel.self)!
    }
    

    
    func injectUniversityDetailViewModel() -> UniversityDetailViewModel {
        
        registerDependencyIfNotRegistered(
            dependency: UniversityDetailViewModel.self,
            onRegisterNeeded: { resolver in
                UniversityDetailViewModel(universityNetworkSource:self.injectAPIService())
            }
        )
       
        return dependencyContainer.resolve(UniversityDetailViewModel.self)!
    }
    
    
    func injectSearchViewModel() -> SearchViewModel {
        
        registerDependencyIfNotRegistered(
            dependency: SearchViewModel.self,
            onRegisterNeeded: { resolver in
                SearchViewModel(universityNetworkSource: self.injectAPIService())
            }
        )
        
        return dependencyContainer.resolve(SearchViewModel.self)!
    }
   
    func injectProfileViewModel() -> ProfileViewModel {
        registerDependencyIfNotRegistered(
            dependency: ProfileViewModel.self,
            onRegisterNeeded:  { resolver in
                ProfileViewModel(repository: ProfileRepository(preferences: UniFinderPreferences()))
            }
        )
        
        return dependencyContainer.resolve(ProfileViewModel.self)!
    }
    
}
