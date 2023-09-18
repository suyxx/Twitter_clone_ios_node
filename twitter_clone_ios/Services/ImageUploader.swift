//
//  ImageUploader.swift
//  twitter_clone_ios
//
//  Created by Suyash Saurabh on 09/03/23.
//

import SwiftUI

struct ImageUploader {
    static func uploadImage(paramName: String, fileName: String, image: UIImage, urlPath: String){
        let url = URL(string: "http://localhost:3000\(urlPath)")
        let boundry = UUID().uuidString
        print(boundry)
        let session = URLSession.shared
        var urlRequest = URLRequest(url: url!)
        urlRequest.httpMethod = "POST"
        
        let token = UserDefaults.standard.string(forKey: "jsonwebtoken")
        if let token = token {
            urlRequest.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        
        urlRequest.addValue("multipart/form-data; boundary=\(boundry)", forHTTPHeaderField: "Content-Type")
        
        var data = Data()
        data.append("\r\n--\(boundry)\r\n".data(using: .utf8)!)
        data.append("Content-Disposition: form-data; name=\"\(paramName)\"; fileName=\"\(fileName)\"\r\n".data(using: .utf8)!)

        data.append("Content-Type: image/png\r\n\r\n".data(using: .utf8)!)
        data.append(image.pngData()!)
        data.append("\r\n--\(boundry)--\r\n".data(using: .utf8)!)
        
        session.uploadTask(with: urlRequest, from: data, completionHandler:  { responseData, response, error in
            
            if let error = error {
                    // Handle error
                    print("Error uploading image: \(error)")
                    return
                }
                
                guard let responseData = responseData else {
                    // Handle missing response data
                    print("Error: No response data")
                    return
                }
                
                guard let jsonData = try? JSONSerialization.jsonObject(with: responseData, options: .allowFragments) as? [String: Any] else {
                    // Handle invalid JSON data
                    print("Error: Invalid response data")
                    return
                }
                
                // Handle successful response
                print(jsonData)
        }).resume()
        
    }
}
