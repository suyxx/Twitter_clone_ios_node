//
//  Utility.swift
//  twitter_clone_ios
//
//  Created by Suyash Saurabh on 09/02/23.
//

import Foundation

struct Utility {
    
    static func stringify(jsonTOConvert: Data?){
        do {
            let json = try JSONSerialization.jsonObject(with: jsonTOConvert!, options: []) as? [String : Any]
            let data =  try JSONSerialization.data(withJSONObject: json, options: JSONSerialization.WritingOptions.prettyPrinted)
            let convertedString = String(data: data, encoding: String.Encoding.utf8)
            print(convertedString)
        } catch let myJSONError {
            print(myJSONError)
        }

}
}
