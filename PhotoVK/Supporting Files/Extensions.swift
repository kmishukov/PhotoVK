//
//  Extensions.swift
//  PhotoVK
//
//  Created by Konstantin Mishukov on 16/07/2018.
//  Copyright © 2018 MyCompany. All rights reserved.
//

import UIKit

extension UIColor {
    static let buttonGray = UIColor(red: 237.0/255.0, green: 238.0/255.0, blue: 240.0/255.0, alpha: 1.0)
    static let buttonDarkGray = UIColor(red: 207.0/255.0, green: 212.0/255.0, blue: 220.0/255.0, alpha: 1.0)
    static let blueVK = UIColor(red: 69.0/255.0, green: 131.0/255.0, blue: 181.0/255.0, alpha: 1.0)
}

extension UIImageView {
    func loadImage(fromURL urlString: String) {
        guard let url = URL(string: urlString) else {
            return
        }

        let activityView = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        self.addSubview(activityView)
        activityView.frame = self.bounds
        activityView.translatesAutoresizingMaskIntoConstraints = false
        activityView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        activityView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        activityView.startAnimating()

        URLSession.shared.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                activityView.stopAnimating()
                activityView.removeFromSuperview()
            }

            if let data = data {
                let image = UIImage(data: data)
                DispatchQueue.main.async {
                    self.image = image
                }
            }
        }.resume()
    }
}


