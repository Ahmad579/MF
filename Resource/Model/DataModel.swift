//
//  DataModel.swift
//  ADIM
//
//  Created by Ahmed Durrani on 06/10/2017.
//  Copyright © 2017 Expert_ni.halal_Pro. All rights reserved.
//

import Foundation
import ObjectMapper
import AlamofireObjectMapper


class UserFavModel: Mappable {
    
    var success                        :       Bool?
    var message                        :       String?
    var status                         :       Int?
    
    
    required init?(map: Map){
        
    }
    func mapping(map: Map) {
        success <- map["success"]
        message <- map["message"]
        status  <- map["status"]
        
        
    }
}


class Collection: Mappable {
    
    var success                        :       Bool?
    var message                        :       String?
    var status                         :       Int?
    var collection                     :       [CollectionObject]?
    

    required init?(map: Map){
        
    }
    func mapping(map: Map) {
        success <- map["success"]
        message <- map["message"]
        status  <- map["status"]
        collection    <- map["collection"]
        
        
    }
}


class CollectionObject : Mappable {
    
    var id: Int?
    var name: String?
    var image: String?
    var facebook: String?
    var likes: Int?
    var liked : String?
    var price : String?
    var link : String?
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        image <- map["image"]
        facebook <- map["facebook"]
        likes <- map["likes"]
        liked <- map["liked"]
        price <- map["price"]
        link <- map["link"]
    }
}

class UserModel: Mappable {
    
    var success                        :       Bool?
    var message                        :       String?
    var status                         :       Int?
    var collection                     :       UserModelObject?
    var userData                       :       UserModelObject?

    
    
    required init?(map: Map){
        
    }
    func mapping(map: Map) {
        success <- map["success"]
        message <- map["message"]
        status  <- map["status"]
        collection    <- map["collection"]
        userData    <- map["user"]

        
        
    }
}

class UserModelObject : Mappable {
    
    var user_id             : String?
    var user_idOfCollection : Int?
    var email: String?
    var token: String?
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        user_id <- map["user_id"]
        user_idOfCollection <- map["user_id"]
        email <- map["email"]
        token <- map["token"]
    }
}



