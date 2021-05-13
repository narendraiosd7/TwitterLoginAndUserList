//
//  DashboardViewModel.swift
//  TwitterSignin
//
//  Created by narendra.vadde on 13/05/21.
//

import Foundation

protocol DashboardViewModelDelegate: class {
    func getPresentListView()
}

class DashboardViewModel {
    
    weak var delegate: DashboardViewModelDelegate?
    
    var authToken: String?
    var userID: String?
    var count = 20
    var token: String?
    var usersData: [User] = []
    
    func getAuthenticationToken() {
        
        let request = (baseURLString: "https://api.twitter.com/oauth/access_token", httpMethod: "POST", consumerKey: ClientCredentials.APIKey, consumerSecret: ClientCredentials.APIKeySecret, callbackURLString: "\(ClientCredentials.CallbackURLScheme)://")
        
        var parameters = [
            URLQueryItem(name: "oauth_consumer_key", value: request.consumerKey),
            URLQueryItem(name: "oauth_token", value: token ?? ""),
            URLQueryItem(name: "oauth_signature_method", value: "HMAC-SHA1"),
            URLQueryItem(name: "oauth_timestamp", value: String(Int(Date().timeIntervalSince1970))),
            URLQueryItem(name: "oauth_nonce", value: UUID().uuidString.replacingOccurrences(of: "-", with: "")),
            URLQueryItem(name: "oauth_version", value: "1.0")
        ]
        
        let signature = oAuthSignature(httpMethod: request.httpMethod, baseURLString: request.baseURLString, parameters: parameters, consumerSecret: request.consumerSecret)
        
        parameters.append(URLQueryItem(name: "oauth_signature", value: signature))
        
        authToken = oAuthAuthorizationHeader(parameters: parameters)
    }
    
    func oAuthSignature(httpMethod: String, baseURLString: String, parameters: [URLQueryItem], consumerSecret: String, oAuthTokenSecret: String? = nil) -> String {
        let signatureBaseString = oAuthSignatureBaseString(httpMethod: httpMethod, baseURLString: baseURLString, parameters: parameters)
        
        let signingKey = oAuthSigningKey(consumerSecret: consumerSecret, oAuthTokenSecret: oAuthTokenSecret)
        
        return signatureBaseString.hmacSHA1Hash(key: signingKey)
    }
    
    func oAuthSignatureBaseString(httpMethod: String, baseURLString: String, parameters: [URLQueryItem]) -> String {
        var parameterComponents: [String] = []
        for parameter in parameters {
            let name = parameter.name.oAuthURLEncodedString
            let value = parameter.value?.oAuthURLEncodedString ?? ""
            parameterComponents.append("\(name)=\(value)")
        }
        let parameterString = parameterComponents.sorted().joined(separator: "&")
        return httpMethod + "&" +
            baseURLString.oAuthURLEncodedString + "&" +
            parameterString.oAuthURLEncodedString
    }
    
    func oAuthSigningKey(consumerSecret: String, oAuthTokenSecret: String?) -> String {
        if let oAuthTokenSecret = oAuthTokenSecret {
            return consumerSecret.oAuthURLEncodedString + "&" +
                oAuthTokenSecret.oAuthURLEncodedString
        } else {
            return consumerSecret.oAuthURLEncodedString + "&"
        }
    }
    
    func oAuthAuthorizationHeader(parameters: [URLQueryItem]) -> String {
        var parameterComponents: [String] = []
        for parameter in parameters {
            let name = parameter.name.oAuthURLEncodedString
            let value = parameter.value?.oAuthURLEncodedString ?? ""
            parameterComponents.append("\(name)=\"\(value)\"")
        }
        return "OAuth " + parameterComponents.sorted().joined(separator: ",")
    }
    
    func getFollowersList() {
        usersData.removeAll()
        getAuthenticationToken()
        var request = URLRequest(url: URL(string: "https://api.twitter.com/1.1/followers/list.json?id=\(userID ?? "")&count=\(count)")!,timeoutInterval: 60)
        request.addValue(authToken ?? "", forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if error != nil {
                if let followersData = data as? AnyObject {
                    do {
                        let followersJSON = try JSONSerialization.data(withJSONObject: followersData, options: .prettyPrinted)
                        let followers = try JSONDecoder().decode(Followers.self, from: followersJSON)
                        self.usersData = followers.users ?? []
                    }catch {
                        print(error.localizedDescription)
                    }
                } else {
                    print(response ?? "")
                }
            }
            self.delegate?.getPresentListView()
        }.resume()
    }
    
    func getFollowingUsersList() {
        usersData.removeAll()
        getAuthenticationToken()
        var request = URLRequest(url: URL(string: "https://api.twitter.com/1.1/friends/list.json?id=\(userID ?? "")&count=\(count)")!,timeoutInterval: 60)
        request.addValue(authToken ?? "", forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            if error != nil {
                if let followingData = data as? AnyObject {
                    do {
                        let followingUsersJson = try JSONSerialization.data(withJSONObject: followingData, options: .prettyPrinted)
                        let followingUsers = try JSONDecoder().decode(Followers.self, from: followingUsersJson)
                        self.usersData = followingUsers.users ?? []
                    }catch {
                        print(error.localizedDescription)
                    }
                } else {
                    print(error?.localizedDescription ?? "")
                }
            } else {
                print(error?.localizedDescription ?? "")
            }
            self.delegate?.getPresentListView()
        }.resume()
    }
}

