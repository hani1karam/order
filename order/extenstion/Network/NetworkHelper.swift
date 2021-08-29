//
//  NetworkHelper.swift
//  order
//
//  Created by hany karam on 8/28/21.
//

import Foundation
class NetworkHelper {
     static var accessToken: String?{
        didSet{
            UserDefaults.standard.set(accessToken, forKey: "token")
        }
    }
    static func getAccessToken() -> String? {
        if let accessToken = UserDefaults.standard.value(forKey: "token") as? String{
            NetworkHelper.accessToken = accessToken
            print("token: \(accessToken)")
        }
        return NetworkHelper.accessToken
    }
}
