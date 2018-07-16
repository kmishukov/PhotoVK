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
    
      // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if let count = friendsResponse?.items?.count {
           return count
        } else {
            return 0
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! FriendsListCell
        cell.selectionStyle = .none
        if let items = friendsResponse?.items {
            
            // Names
            if let name = items[indexPath.row].first_name, let surname = items[indexPath.row].last_name {
                    cell.nameLabel.text = name + " " + surname
            } else {
                print("Error retrieving first_name & last_name on \(indexPath.row) row.")
                cell.nameLabel.text = "Error?"
            }
            
            
            // User Image
            cell.userImage.image = UIImage(named: "placeholder")
            if let photoAdress = items[indexPath.row].photo_100 {
                cell.userImage.loadImage(fromURL: photoAdress)
            } else {
                print("Error: image URL is nil.")
                cell.userImage.image = UIImage(named: "errorURL")
            }
            cell.userImage.translatesAutoresizingMaskIntoConstraints = false
            cell.userImage.layer.cornerRadius = 25
            cell.userImage.clipsToBounds = true
        }
        return cell
    }

    @IBAction func logoutButtonPressed(_ sender: Any) {
        authorized = nil
        removeCookies()
        dismiss(animated: true, completion: nil)
    }
    
    func removeCookies(){
//        let cookie = HTTPCookie.self
        let cookieJar = HTTPCookieStorage.shared
        for cookie in cookieJar.cookies! {
            // print(cookie.name+"="+cookie.value)
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

