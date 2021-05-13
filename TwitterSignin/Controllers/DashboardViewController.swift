//
//  DashboardViewController.swift
//  TwitterSignin
//
//  Created by narendra.vadde on 13/05/21.
//

import UIKit
import SDWebImage

class DashboardViewController: UIViewController {
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameDescriptionLabel: UILabel!
    @IBOutlet weak var emailDescriptionLabel: UILabel!
    
    var userNameStr: String?
    var userEmailStr: String?
    var userImageStr: String?
    var userID: String?
    var token: String?
    
    var viewModel = DashboardViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        updateUI()
    }
    
    func updateUI() {
        profileImage.layer.cornerRadius = profileImage.frame.size.height/2
        let url = URL(string: userImageStr ?? "")
        profileImage.sd_setImage(with: url, placeholderImage: #imageLiteral(resourceName: "placeholder"), options: .retryFailed, context: nil)
        nameDescriptionLabel.text = userNameStr
        emailDescriptionLabel.text = userEmailStr
        viewModel.userID = userID
        viewModel.token = token
    }
    
    @IBAction func followersTappped(_ sender: UIButton) {
        viewModel.getFollowersList()
    }
    
    @IBAction func followingTapped(_ sender: UIButton) {
        viewModel.getFollowingUsersList()
    }
}

extension DashboardViewController: DashboardViewModelDelegate {
    func getPresentListView() {
        DispatchQueue.main.async {
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let usersList = storyBoard.instantiateViewController(withIdentifier: "UsersListTableViewController") as! UsersListTableViewController
            self.present(usersList, animated: true) {
                usersList.dataSource = self.viewModel.usersData
                usersList.tableView.reloadData()
            }
        }
    }
}
