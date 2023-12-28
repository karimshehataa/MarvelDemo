//
//  CharactersVC.swift
//  MarvelApp
//
//  Created by karim  on 25/12/2023.
//

import UIKit
import RxSwift
import RxCocoa
import AlamofireImage

class CharactersVC: UIViewController, UICollectionViewDelegateFlowLayout {
    var limit:Int = 10
    let viewModel = CharcatersViewModel()
    let disposeBag = DisposeBag()
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupNavigation()
        setupCollectionView()
        subscribeToCharacterSelected()
        subscribeToResponse()
        getAllCharacters()
    }
    
    private func setupCollectionView() {
        collectionView.register(UINib(nibName: "CharactersCell", bundle: nil), forCellWithReuseIdentifier: "CharactersCell")
        collectionView.rx.setDelegate(self).disposed(by: disposeBag)
    }
    
    private func setupNavigation() {
        title = "Characters"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func subscribeToResponse() {
        viewModel.charactersObservable.bind(to: collectionView.rx.items(cellIdentifier: "CharactersCell", cellType: CharactersCell.self)) { [weak self] item , character,cell in
            guard let self = self else {return}
            if item == (self.viewModel.limit ?? 0) - 1 || item == (self.viewModel.total ?? 0) - 1 {
                cell.characterImage.image = nil
                self.limit += 10
                self.viewModel.getAllCharacters(limit: self.limit)
            }
            cell.characterName.text = character.name
            let stringUrl = (character.thumbnail?.path ?? "") + "/landscape_amazing.jpg"
            let url = URL(string: stringUrl)
            print(stringUrl)
            cell.characterImage.af.setImage(withURL: url ?? URL(fileURLWithPath: ""))
        }.disposed(by: disposeBag)
    }
    
    func subscribeToCharacterSelected() {
        Observable.zip(collectionView.rx.itemSelected, collectionView.rx.modelSelected(Result.self)).bind { index,character in
            let vc = DetailsCharacterVC()
            let viewModel = DetailsCharacterViewModel()
            vc.viewModel = viewModel
            viewModel.characterSubject.onNext(character.comics?.items ?? [])
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                viewModel.character?(character)
            }
            self.navigationController?.pushViewController(vc, animated: true)
        }.disposed(by: disposeBag)
    }
    
    func getAllCharacters() {
        viewModel.getAllCharacters(limit: limit)
    }
    
    func navigateToDetails(character:Result) {
      
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.size.width
          return CGSize(width: width, height: 200)
      }
  }


