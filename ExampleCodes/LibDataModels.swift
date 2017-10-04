//
//  LibDataModels.swift
//  ExampleCodes
//
//  Created by boqian cheng on 2017-10-03.
//  Copyright © 2017 boqiancheng. All rights reserved.
//

import Foundation
import Marshal

struct Library: Unmarshaling {
    var zip: String?
    var phone: String?
    var teacher_in_the_library: String?
    var location: Location?
    var website: Website?
    var address: String?
    var hours_of_operation: String?
    var state: String?
    var cybernavigator: String?
    var name_: String?
    var city: String?
    
    
    init(object: MarshaledObject) {
        zip = try? object.value(for: "zip")
        phone = try? object.value(for: "phone")
        teacher_in_the_library = try? object.value(for: "teacher_in_the_library")
        location = try? object.value(for: "location")
        website = try? object.value(for: "website")
        address = try? object.value(for: "address")
        hours_of_operation = try? object.value(for: "hours_of_operation")
        state = try? object.value(for: "state")
        cybernavigator = try? object.value(for: "cybernavigator")
        name_ = try? object.value(for: "name_")
        city = try? object.value(for: "city")
    }
}

extension Library: Marshaling {
    func marshaled() -> [String:Any] {
        let locationDict: [String:Any] = [
            "needs_recoding" : false,
            "longitude" : "",
            "latitude": ""]
        let websiteDict: [String:Any] = ["url" : ""]
        
        return [
            "zip" : zip ?? "",
            "phone" : phone ?? "",
            "teacher_in_the_library" : teacher_in_the_library ?? "",
            "location" : location != nil ? location!.marshaled() : locationDict,
            "website" : website != nil ? website!.marshaled() : websiteDict,
            "address" : address ?? "",
            "hours_of_operation" : hours_of_operation ?? "",
            "state" : state ?? "",
            "cybernavigator" : cybernavigator ?? "",
            "name_" : name_ ?? "",
            "city" : city ?? ""
        ]
    }
}

struct Location: Unmarshaling {
    var needs_recoding: Bool?
    var longitude: String?
    var latitude: String?
    
    init(object: MarshaledObject) {
        needs_recoding = try? object.value(for: "needs_recoding")
        longitude = try? object.value(for: "longitude")
        latitude = try? object.value(for: "latitude")
    }
}

extension Location: Marshaling {
    func marshaled() -> [String: Any] {
        return [
            "needs_recoding" : needs_recoding ?? false,
            "longitude" : longitude ?? "",
            "latitude": latitude ?? ""
        ]
    }
}

struct Website: Unmarshaling {
    var url: String?
    
    init(object: MarshaledObject) {
        url = try? object.value(for: "url")
    }
}

extension Website: Marshaling {
    func marshaled() -> [String: Any] {
        return [
            "url" : url ?? ""
        ]
    }
}


