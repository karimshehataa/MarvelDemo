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
}
