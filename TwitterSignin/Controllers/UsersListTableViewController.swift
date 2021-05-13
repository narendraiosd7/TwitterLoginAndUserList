//
//  UsersListTableViewController.swift
//  TwitterSignin
//
//  Created by narendra.vadde on 13/05/21.
//

import UIKit
import SDWebImage

class UsersListTableViewController: UITableViewController {

    var dataSource: [User]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = dataSource?[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! UserTableViewCell
        let url = URL(string: data?.profileImageURL ?? "")
        cell.profileImage.sd_setImage(with: url, placeholderImage: #imageLiteral(resourceName: "placeholder"), options: .retryFailed, context: nil)
        cell.userNameLabel.text = data?.name
        cell.userScreeNameLbel.text = data?.screenName
        cell.userLocationLabel.text = data?.location
        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
