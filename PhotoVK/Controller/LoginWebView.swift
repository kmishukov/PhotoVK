//
//  LoginWebView.swift
//  PhotoVK
//
//  Created by Konstantin Mishukov on 01.06.2018.
//  Copyright © 2018 MyCompany. All rights reserved.
//

import UIKit
import WebKit
import SafariServices

public var authorized: Authorization?

class LoginWebView: UIViewController, UIWebViewDelegate {

    @IBOutlet var myWebView: UIWebView!

    
    override func viewWillAppear(_ animated: Bool) {
        self.myWebView.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        requestLogIn()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func requestLogIn() {
        let url = URL(string: API.authURL)
        let requestObj = NSURLRequest(url: url!);
        myWebView.loadRequest(requestObj as URLRequest)
    }
    
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        return checkRequestForCallbackURL(request: request)
    }

    func checkRequestForCallbackURL(request: URLRequest) -> Bool {
        let requestURLString = (request.url?.absoluteString)! as String
        if requestURLString.hasPrefix(API.redirect_uri) {
            handleAuth(stringToParse: requestURLString)
            return false;
        }
        return true
    }
    
    enum parametersToParse: String {
        case access_token = "#access_token="
        case user_id = "user_id="
        case expires_in = "expires_in="
        case state = "state="
    }
    
    func parseString(stringToParse: String, parameters: parametersToParse) -> String {
        let range: Range<String.Index> = stringToParse.range(of: parameters.rawValue)!
        let slicedString = String(stringToParse[range.upperBound...])
        if let characterIndex = slicedString.index(of: "&") {
            let parsedString = String(slicedString[slicedString.startIndex..<characterIndex])
            return parsedString
        }
        return "Error"
    }
    
    func handleAuth(stringToParse: String)  {
        var accessToken: String
        var userID: String
        var expiresIn: String

        accessToken = parseString(stringToParse: stringToParse, parameters: .access_token)
        userID = parseString(stringToParse: stringToParse, parameters: .user_id)
        expiresIn = parseString(stringToParse: stringToParse, parameters: .expires_in)
        
        authorized = Authorization(access_token: accessToken, user_id: userID, expires_in: expiresIn)
        
        NotificationCenter.default.post(name: NSNotification.Name("Logged in"), object: nil)
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}


