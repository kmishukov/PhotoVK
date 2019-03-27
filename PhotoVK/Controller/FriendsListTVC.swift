//
//  FriendsListTVC.swift
//  PhotoVK
//
//  Created by Konstantin Mishukov on 10/06/2018.
//  Copyright © 2018 MyCompany. All rights reserved.
//

import UIKit

class FriendsListTVC: UITableViewController {
    
    var api = API()
    var friendsResponse: GetFriendsResponse? {
        didSet {
            print("Response recieved.")
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        if let auth = authorized {
            api.getFriendsList(authorization: auth, completion: { getFriendsObject in
                if let response = getFriendsObject?.response {
                    self.friendsResponse = response
                }
            })
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
      // MARK: - TableView DataSource
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = friendsResponse?.items?.count {
           return count
        } else {
            return 0
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! FriendsListCell
        cell.selectionStyle = .none
        
        if let friend = friendsResponse?.items?[indexPath.row] {
            cell.configureCell(friend: friend)
        }
        return cell
    }

    @IBAction func logoutButtonPressed(_ sender: Any) {
        authorized = nil
        removeCookies()
        dismiss(animated: true, completion: nil)
    }
    
    func removeCookies(){
        let cookieJar = HTTPCookieStorage.shared
        for cookie in cookieJar.cookies! {
            cookieJar.deleteCookie(cookie)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showPhoto" {
             let destination = segue.destination as! ScrollViewController
            if let indexPath = self.tableView.indexPathForSelectedRow {
                destination.friend = friendsResponse?.items![indexPath.row]
            }
        }
    }
}

