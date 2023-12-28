//
//  DetailsCharacterVC.swift
//  MarvelApp
//
//  Created by karim  on 27/12/2023.
//

import UIKit
import RxSwift
import RxCocoa
import AlamofireImage

class DetailsCharacterVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var character:Result?
    var disposed = DisposeBag()
    var viewModel = DetailsCharacterViewModel()
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupTableView()
    }
    
    private func setupTableView() {
        self.tableView.contentInset = UIEdgeInsets(top: -55, left: 0, bottom: 0, right: 0)
        tableView.register(UINib(nibName: "HeaderImageCell", bundle: nil), forCellReuseIdentifier: "HeaderImageCell")
        tableView.register(UINib(nibName: "CategoryCell", bundle: nil), forCellReuseIdentifier: "CategoryCell")
        viewModel.character = { [weak self] (charater) in
            guard let self = self else {return}
            print(charater)
            
            self.character = charater
            self.tableView.delegate = self
            self.tableView.dataSource = self
            
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "HeaderImageCell", for: indexPath) as! HeaderImageCell
            cell.characterTitle.text = character?.name
            cell.charcterDescription.text = character?.description
            let stringUrl = (character?.thumbnail?.path ?? "") + "/landscape_amazing.jpg"
            let url = URL(string: stringUrl)
            print(stringUrl)
            cell.characterImage.af.setImage(withURL: url ?? URL(fileURLWithPath: ""))
            return cell
        } else  {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath) as! CategoryCell
            cell.categorList = character?.comics?.items
            return cell
        }
       
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return UITableView.automaticDimension

        } else {
            return 200
        }
    }
    
}
