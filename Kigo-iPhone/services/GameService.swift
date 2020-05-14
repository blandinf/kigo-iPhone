//
//  GameService.swift
//  Kigo-iPhone
//
//  Created by Florian on 14/05/2020.
//  Copyright © 2020 blandinf. All rights reserved.
//

import Foundation
import Firebase

class GameService {
    static let db = Firestore.firestore()
    
    static func getGames(completionHandler: @escaping ([Game], Error?) -> Void) {
        var gameArray = [Game]()
        db.collection("game").getDocuments() { (querySnapshot, error) in
            if let err = error {
                completionHandler(gameArray, err)
                return
            } else {
                for document in querySnapshot!.documents {
                    if let game = Game(id: document.documentID, data: document.data()) {
                        gameArray.append(game)
                    }
                }
                completionHandler(gameArray, nil)
            }
        }
    }
}
