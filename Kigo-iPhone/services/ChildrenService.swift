//
//  ChildrenService.swift
//  Kigo-iPhone
//
//  Created by Florian on 13/05/2020.
//  Copyright © 2020 blandinf. All rights reserved.
//

import Foundation
import Firebase

class ChildrenService {
    static let db = Firestore.firestore()
    
    static func getChildren(completionHandler: @escaping ([Child], Error?) -> Void) {
        var childrenArray = [Child]()
        db.collection("child").getDocuments() { (querySnapshot, error) in
            if let err = error {
                completionHandler(childrenArray, err)
                return
            } else {
                for document in querySnapshot!.documents {
                    if let child = Child(id: document.documentID, data: document.data()) {
                        childrenArray.append(child)
                    }
                }
                completionHandler(childrenArray, nil)
            }
        }
    }
    
    static func updateLocation(id: String, locationValue: Int) {
        db.collection("child").document(id)
          .getDocument() { (document, err) in
              document?.reference.updateData([
                  "location": locationValue
              ])
          }
    }
}
