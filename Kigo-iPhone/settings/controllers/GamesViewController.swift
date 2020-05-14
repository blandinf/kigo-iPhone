//
//  GamesViewController.swift
//  Kigo-iPhone
//
//  Created by Florian on 07/05/2020.
//  Copyright © 2020 blandinf. All rights reserved.
//

import UIKit

class GamesViewController: UIViewController {
    @IBOutlet weak var myCollectionView: UICollectionView!
    var games = [Game]()
    var childrens = [Child]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myCollectionView.delegate = self
        myCollectionView.dataSource = self
        initializeChildren()
        initializeGames()
    }
    
    func initializeGames () {
       GameService.getGames { gameArray, error in
           if let err = error {
               print(err)
               return
           }
           self.games = gameArray
           self.myCollectionView.reloadData()
       }
    }
    
    func initializeChildren () {
       ChildrenService.getChildren { childrenArray, error in
           if let err = error {
               print(err)
               return
           }
           self.childrens = childrenArray
       }
    }
}

extension GamesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

extension GamesViewController: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return games.count / 2
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GamesCollectionViewCell", for: indexPath) as! GamesCollectionViewCell
        
//        cell.myImageView.image = UIImage(named: games[indexPath.row].image)
        cell.myImageView.image = UIImage(named: "bird")
        cell.nameLbl.text = games[indexPath.row].name
        
        cell.listenToBanClicked { () in
            for var child in self.childrens {
                child.gamesNotAllowed.append(self.games[indexPath.row].name)
                ChildrenService.updateGamesNotAllowed(id: child.id, gamesNotAllowed: child.gamesNotAllowed)
            }
        }

        return cell
    }
}

extension GamesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let w = collectionView.frame.width
        let h = collectionView.frame.height

        return CGSize(width: Int(w/2), height: Int(h/2))
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {

        return 0.0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {

        return 0.0
    }
}
