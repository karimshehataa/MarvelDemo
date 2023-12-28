//
//  SplashVC.swift
//  MarvelApp
//
//  Created by karim  on 27/12/2023.
//

import UIKit

class SplashVC: UIViewController {
    
    var imageView:UIImageView = {
       let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        imageView.image = UIImage(named: "marvel-logo-2D20B064BD-seeklogo.com")
        return imageView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(imageView)
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        imageView.center = view.center
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.animation()
        }
    }
    
    func animation() {
        UIView.animate(withDuration: 1) {
            let size = self.view.frame.size.width * 2
            let x = size - self.view.frame.size.width
            let y = self.view.frame.size.height - size
            self.imageView.frame = CGRect(x: -(x/2), y: (y/2), width: size, height: size)
        }
        UIView.animate(withDuration: 1) {
            self.imageView.alpha = 0
        } completion: { done in
            if done {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    let vc = CharactersVC()
                    let nav = UINavigationController(rootViewController: vc)
                    nav.modalPresentationStyle = .fullScreen
                    self.present(nav, animated: true)
                }
            }
        }
    }
}
