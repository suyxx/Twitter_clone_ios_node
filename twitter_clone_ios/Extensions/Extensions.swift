//
//  Extensions.swift
//  twitter_clone_ios
//
//  Created by Suyash Saurabh on 18/01/23.
//


import UIKit
import SwiftUI

extension UIApplication {
    func endEditing(){
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

extension View {
    func getRect() -> CGRect {
        return UIScreen.main.bounds
    }
}


