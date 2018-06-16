//
//  ScrollViewController.swift
//  PhotoVK
//
//  Created by Konstantin Mishukov on 12/06/2018.
//  Copyright © 2018 MyCompany. All rights reserved.
//

import UIKit

class ScrollViewController: UIViewController {

    @IBOutlet var mainScrollView: UIScrollView!
    
    var friend: Friend?
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        if friend != nil {
            if let name = friend?.first_name, let surname = friend?.last_name {
                navigationItem.title = name + " " + surname
            } else {
                navigationItem.title = "Error?"
            }
            retrievePhotos()
        } else {
            print("Can't retrieve photos, Friend value is nil.")
        }
    }
    
    // Load profile Photos
    
    func retrievePhotos() {
        var api = API()
        guard let current_authorization = authorized else {
            print("Error: Can't retrieve Photos, no authorization.")
            return
        }
        guard let user_id = self.friend?.id else {
            print("Error: Can't retrieve Photos, user_id is nil.")
            return
        }
        api.getPhotos(authorization: current_authorization, profile_id: user_id) { (jsonObject) in
            if let response = jsonObject?.response {
                guard let count = response.count else {
                    print("Response.count returned nil")
                    return
                }
                print("Count: \(count)")
                if count > 1 {
                    var i = 0
                    guard let items = response.items else {
                        print("Error: Cant load photos, items array returned nil.")
                        return
                    }
                    for item in items {
                        DispatchQueue.main.async {
                        let imageView = UIImageView()
                            if let url = item.sizes?.last?.url {
                                imageView.loadImage(fromURL: url)
                            } else {
                                imageView.image = UIImage(named: "errorURL")
                                print("Error: Image URL returned nil.")
                            }
                            
                        imageView.contentMode = .scaleAspectFit
                        let xPosition = self.view.frame.width * CGFloat(i)
                        i += 1
                        imageView.frame = CGRect(x: xPosition, y: 0, width: self.mainScrollView.frame.width, height: self.mainScrollView.frame.height)
                        self.mainScrollView.contentSize.width = self.mainScrollView.frame.width * CGFloat(count-1)
                        self.mainScrollView.addSubview(imageView)
                            
                        let shadeView = UIView()
                            shadeView.frame = CGRect(x: xPosition, y: self.mainScrollView.frame.height - 150, width: self.mainScrollView.frame.width, height: 100)
                            shadeView.backgroundColor = .black
                            shadeView.alpha = 0.4
                        self.mainScrollView.addSubview(shadeView)
                       
                            // Text Labels
                            
                            if let count = item.comments?.count {
                                let commentsLabel = UILabel()
                                commentsLabel.textColor = .white
                                commentsLabel.frame = CGRect(x: xPosition + 20, y: self.mainScrollView.frame.height - 140, width: self.mainScrollView.frame.width, height: 25)
                                commentsLabel.text = "Comments: \(count)"
                                self.mainScrollView.addSubview(commentsLabel)
                            }
                            if let count = item.likes?.count {
                                let likesLabel = UILabel()
                                likesLabel.textColor = .white
                                likesLabel.frame = CGRect(x: xPosition + 20, y: self.mainScrollView.frame.height - 110, width: self.mainScrollView.frame.width, height: 25)
                                likesLabel.text = "Likes: \(count)"
                                self.mainScrollView.addSubview(likesLabel)
                            }
                            
                            if let date = item.date {
                                let dateLabel = UILabel()
                                dateLabel.textColor = .white
                                dateLabel.alpha = 0.75
                                dateLabel.frame = CGRect(x: xPosition + 20, y: self.mainScrollView.frame.height - 80, width: self.mainScrollView.frame.width, height: 25)
                                dateLabel.text = "\(self.dateToString(timestamp: date))"
                                self.mainScrollView.addSubview(dateLabel)
                            }
                        }
                    }
                } else {
                    DispatchQueue.main.async {
                    let imageView = UIImageView()
                    imageView.image = UIImage(named: "noImageAvailable")
                    imageView.contentMode = .center
                    imageView.frame = CGRect(x: 0, y: 0, width: self.mainScrollView.frame.width, height: self.mainScrollView.frame.height)
                    self.mainScrollView.addSubview(imageView)
                    }
                }
            } else {
                if let error = jsonObject?.error {
                    DispatchQueue.main.async {
                        let errorLabel = UILabel()
                        errorLabel.frame = CGRect(x: 0, y: 0, width: self.mainScrollView.frame.width - 100, height: 200)
                        errorLabel.center = self.view.center
//                        errorLabel.backgroundColor = .yellow
                        errorLabel.textColor = .red
                        errorLabel.numberOfLines = 0
                        errorLabel.alpha = 0.5
                        errorLabel.textAlignment = .center
                        if let code = error.error_code, let msg = error.error_msg {
                            errorLabel.text = "error_code: \(code)\n\n\nerror_msg:\n\n\(msg)"
                        } else {
                            errorLabel.text = "Unrecognized error."
                        }
                        self.mainScrollView.addSubview(errorLabel)
                    }
                }
            }
        }
    }
    
    func dateToString(timestamp: Double) -> String {
        let formatter = DateFormatter()
        formatter.timeStyle = .none
        formatter.dateStyle = .medium
        let stampDate = NSDate(timeIntervalSince1970: timestamp)
        return formatter.string(from: stampDate as Date)
    }
}
