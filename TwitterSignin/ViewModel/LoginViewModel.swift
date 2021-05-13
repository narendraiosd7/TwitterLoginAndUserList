//
//  LoginViewModel.swift
//  TwitterSignin
//
//  Created by narendra.vadde on 13/05/21.
//

import Foundation
import TwitterKit

protocol LoginViewModelDelegate: class {
    func getPresentDashboard()
}

class LoginViewModel {
    
    weak var delegate: LoginViewModelDelegate?
    
    var userName: String?
    var userEmail: String?
    var userID: String?
    var profileImage: String?
    var profileName: String?
    var token: String?
    var secretToken: String?
    
    func getUserData() {
        TWTRTwitter.sharedInstance().logIn { (session, error) in
            if (session != nil) {
                if let token = TWTRTwitter.sharedInstance().sessionStore.session()?.authToken, let secret = TWTRTwitter.sharedInstance().sessionStore.session()?.authTokenSecret {
                
                    let twitterClient = TWTRAPIClient.withCurrentUser()
                    
                    twitterClient.requestEmail { (email, error) in
                        self.userEmail = email ?? ""
                    }
                    
                    twitterClient.loadUser(withID: session!.userID) { (user:TWTRUser?, error:Error?) in
                        self.profileImage = user?.profileImageLargeURL ?? ""
                        self.profileName = user?.name ?? ""
                        self.token = token
                        self.secretToken = secret
                        self.userID = session?.userID ?? ""
                        self.userName = session?.userName ?? ""
                        self.delegate?.getPresentDashboard()
                    }
                }
            } else {
                print(error?.localizedDescription ?? "")
            }
        }
    }
}
