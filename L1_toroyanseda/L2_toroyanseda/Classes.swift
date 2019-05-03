//
//  Classes.swift
//  L2_toroyanseda
//
//  Created by Seda on 03/05/2019.
//  Copyright © 2019 Seda. All rights reserved.
//

import Foundation
import ObjectMapper

// Get Friends
class UserResponse: Mappable{
    var countResponse: Int?
    var itemsResponse: [Items]?
    
    required init?(map: Map){
        
    }
    func mapping(map: Map){
        countResponse <- map["response.count"]
        itemsResponse <- map["response.items"]
    }
}

class Items: Mappable {
    var id : Int?
    var firstName : String?
    var lastName : String?
    var photo: String?
    required init?(map: Map){
        
    }
    func mapping(map: Map){
        id <- map["id"]
        firstName <- map["first_name"]
        lastName <- map["last_name"]
        photo <- map["photo_100"]
    }
}



// Get Groups
class GroupsResponse: Mappable{
    var itemsResponse: [ItemsGroups]?
    
    required init?(map: Map){
        
    }
    func mapping(map: Map){
        itemsResponse <- map["response.items"]
    }
}
class ItemsGroups: Mappable {
    var id : Int?
    var name : String?
    var photo: String?
    required init?(map: Map){
        
    }
    func mapping(map: Map){
        id <- map["id"]
        name <- map["name"]
        photo <- map["photo_100"]
    }
}


// Get Photos
class PhotosResponse: Mappable{
    var photosResponse: [ItemsPhotos]?
    
    required init?(map: Map){
        
    }
    func mapping(map: Map){
        photosResponse <- map["response.items.0.sizes"] // указан ноль так как у моего пользователя только одно фото
    }
}
class ItemsPhotos: Mappable{
    var type: String?
    var url: String?
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map){
        type <- map["type"]
        url <- map["url"]
    }
}


