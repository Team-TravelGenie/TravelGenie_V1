//
//  DefaultLocationPhotosRepository.swift
//  TravelGenie
//
//  Created by 서현웅 on 2023/09/25.
//

import Foundation

final class DefaultLocationPhotosRepository: LocationPhotosRepository {
    
    private let networkService = NetworkService()
    
    func searchLocation(
        query: String,
        languageCode: String,
        completion: @escaping ((Result<String, ResponseError>) -> Void))
    {
        let requestModel = LocationSearchRequestModel(language: languageCode, searchQuery: query)
        
        networkService.request(TripadvisorLocationSearchAPI.locationSearch(requestModel)) { result in
            switch result {
            case .success(let response):
                guard let locationID = response.data.first?.locationID else {
                    completion(.failure(ResponseError.emptyResponse))
                    return
                }
                
                completion(.success(locationID))
            case .failure(let error):
                completion(.failure(ResponseError.moyaError(error)))
            }
        }
    }
}
