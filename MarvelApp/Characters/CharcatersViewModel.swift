//
//  CharcatersViewModel.swift
//  MarvelApp
//
//  Created by karim  on 25/12/2023.
//

import Foundation
import Alamofire
import RxSwift
import RxCocoa

class CharcatersViewModel {
    private(set) var total:Int?
    private(set) var limit:Int?
    private var charactersModelSubject = PublishSubject<[Result]>()
    var charactersObservable: Observable<[Result]> {
        return charactersModelSubject
    }
    
    
    func getAllCharacters(limit:Int) {
        fetchData(limit: limit) { [weak self] result in
            guard let self = self else {return}
            switch result {
            case .success(let data):
                self.charactersModelSubject.onNext(data.data?.results ?? [])
                self.limit = data.data?.limit
                self.total = data.data?.total
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func fetchData(limit:Int,onComplete: @escaping onComplete<CharactersModel>) {
        let fullUrl = URLEndpoints.getCharacters
        let queryItems = [URLQueryItem(name: "ts", value: "1"),URLQueryItem(name: "apikey", value: "3dd11098535a444e45cf6194d031a4d7"),URLQueryItem(name: "hash", value: "d59b5f54d75b93b69e1c43b9d2e8aec4"),URLQueryItem(name: "limit", value: "\(limit)")]
        var urlComps = URLComponents(string:fullUrl)!
        urlComps.queryItems = queryItems
        let urlParams = urlComps.url?.absoluteString ?? ""
        print(urlParams)
        let endPoint = EndPoint(method: .get,endPoint: urlParams)
        print(endPoint)
        API.shared.startAPI(endPoint: endPoint, onComplete: onComplete)
    }
    
}
