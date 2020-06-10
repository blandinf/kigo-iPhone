//
//  GameService.swift
//  Kigo-iPhone
//
//  Created by Florian on 14/05/2020.
//  Copyright © 2020 blandinf. All rights reserved.
//

import Foundation
import Firebase

class SleepService {
    static let db = Firestore.firestore()
    
    static func getSleeps(completionHandler: @escaping ([Sleep], Error?) -> Void) {
        var sleepsArray = [Sleep]()
        db.collection("sleeps").getDocuments() { (querySnapshot, error) in
            if let err = error {
                completionHandler(sleepsArray, err)
                return
            } else {
                for document in querySnapshot!.documents {
                    if let sleep = Sleep(id: document.documentID, data: document.data()) {
                        sleepsArray.append(sleep)
                    }
                }
                completionHandler(sleepsArray, nil)
            }
        }
    }
}
