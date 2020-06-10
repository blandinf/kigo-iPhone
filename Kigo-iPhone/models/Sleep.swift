//
//  Children.swift
//  Kigo-iPhone
//
//  Created by Florian on 11/05/2020.
//  Copyright © 2020 blandinf. All rights reserved.
//

import Foundation

struct Sleep: Codable {
    let id: String
    let title: String
    var description: String
    var icon: String
    
    init?(id: String, data: [String: Any]) {
        
        self.id = id
        
        guard let title = data["title"] as? String,
            let description = data["description"] as? String,
            let icon = data["icon"] as? String
        else {
            return nil
        }
            
        self.title = title
        self.description = description
        self.icon = icon
    }
}
