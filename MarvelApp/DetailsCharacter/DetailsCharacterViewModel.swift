//
//  DetailsCharacterViewModel.swift
//  MarvelApp
//
//  Created by karim  on 27/12/2023.
//

import Foundation
import RxSwift

class DetailsCharacterViewModel {
    var character: ((_ character:Result) -> ())?
     var characterSubject = PublishSubject<[CategoryItem]>()
    var categoriesObservable:Observable<[CategoryItem]> {
        return characterSubject
    }
    
    var comicsSubject = PublishSubject<[ComicsEnum.Result]>()
    var comicsObservable:Observable<[ComicsEnum.Result]> {
       return comicsSubject
   }
    
    func fetchData(characterId: Int) {
        getAllComics(characterId: characterId) { [weak self] result in
            guard let self = self else {return}
            switch result {
            case .success(let data):
                self.comicsSubject.onNext(data.data?.results ?? [])
                print(data.data?.results?[0].thumbnail)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getAllComics(characterId:Int,onComplete: @escaping onComplete<ComicsEnum.ComicsModel>) {
        let fullUrl = URLEndpoints.getCharacters + "/\(characterId)" + URLEndpoints.getComics
        let queryItems = [URLQueryItem(name: "ts", value: "1"),URLQueryItem(name: "apikey", value: "3dd11098535a444e45cf6194d031a4d7"),URLQueryItem(name: "hash", value: "d59b5f54d75b93b69e1c43b9d2e8aec4")]
        var urlComps = URLComponents(string:fullUrl)!
        urlComps.queryItems = queryItems
        let urlParams = urlComps.url?.absoluteString ?? ""
        print(urlParams)
        let endPoint = EndPoint(method: .get,endPoint: urlParams)
        print(endPoint)
        API.shared.startAPI(endPoint: endPoint, onComplete: onComplete)
    }
}
