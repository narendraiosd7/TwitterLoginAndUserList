//
//  LoginController.swift
//  TwitterSignin
//
//  Created by narendra.vadde on 12/05/21.
//

import UIKit
import TwitterKit

class LoginController: UIViewController {
    
    @IBOutlet weak var buttonContainer: UIView!
    
    var viewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        buttonContainer.layer.cornerRadius = 5
    }
    
    @IBAction func loginWithTwitterTapped(_ sender: UIButton) {
        viewModel.getUserData()
    }
}

extension LoginController: LoginViewModelDelegate {
    func getPresentDashboard() {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let dashboard = storyBoard.instantiateViewController(withIdentifier: "DashboardViewController") as! DashboardViewController
        self.present(dashboard, animated: true) {
            dashboard.userEmailStr = self.viewModel.userEmail
            dashboard.userNameStr = self.viewModel.profileName
            dashboard.userImageStr = self.viewModel.profileImage
            dashboard.userID = self.viewModel.userID
            dashboard.token = self.viewModel.token
            dashboard.updateUI()
        }
    }
}
