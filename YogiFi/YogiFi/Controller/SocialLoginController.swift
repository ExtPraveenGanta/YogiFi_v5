//
//  SocialLoginController.swift
//  YogiFi
//
//  Created by Girish Nandagiri on 11/08/20.
//  Copyright © 2020 Girish Nandagiri. All rights reserved.
//

import UIKit
import GoogleSignIn
import FBSDKLoginKit


class SocialLoginController: UIViewController, GIDSignInDelegate, LoginButtonDelegate {
        
    var socialLoginType : String!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()

        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance()?.presentingViewController = self

        if socialLoginType == "facebook" {
            self.facebookLogin()
        }
        else if socialLoginType == "google" {
            self.googleLogin()
        }
        
    }
    
    private func googleLogin(){
        GIDSignIn.sharedInstance()?.signIn()
    }
    
    private func facebookLogin() {
        let fbLoginManager : LoginManager = LoginManager()
        fbLoginManager.logIn(permissions: ["email"], from: self, handler: { (result, error) -> Void in
            if (error == nil) {
                let fbloginresult : LoginManagerLoginResult = result!
             if(fbloginresult.isCancelled) {
             } else if(fbloginresult.grantedPermissions.contains("email")) {
                 self.getUserFaceBookData()
             }
            }
        })
    }
    
    func getUserFaceBookData(){
        if((AccessToken.current) != nil){
            GraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, picture.type(large), email"]).start(completionHandler: { (connection, result, error) -> Void in
                if ((error) != nil) {
                   // Process error
                   print("\n\n Error: \(error!)")
                } else {
                        var userName = ""
                        var userEmail = ""
                        var facebookID = ""
                      let resultDic = result as! NSDictionary
                      print("\n\n  fetched user: \(result ?? [])")
                      if (resultDic.value(forKey:"name") != nil) {
                        userName = resultDic.value(forKey:"name")! as! String
                          print("\n User Name is: \(userName)")
                       }

                      if (resultDic.value(forKey:"email") != nil) {
                           userEmail = resultDic.value(forKey:"email")! as! String
                          print("\n User Email is: \(userEmail )")
                       }
                    
                    if (resultDic.value(forKey:"id") != nil) {
                        facebookID = resultDic.value(forKey:"id")! as! String
                       print("\n User Email is: \(facebookID )")
                    }
                    self.trySocialAutherisation(userName, email: userEmail, socialID: facebookID, socialAccountID: facebookID, socialAccountType: "facebook")
                  }
            })
        }
    }
    
    //callback method for error cases
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        if ((error) != nil) {
            // Process error
        }
        else if result!.isCancelled {
            // Handle cancellations
        }
        
    }

    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        debugPrint("FB DidLogOut")
    }

    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        
        if (error == nil) {
            print(user.profile.name!)
            print(user.profile.email as Any)
            self.trySocialAutherisation(user!.profile.name, email: user.profile.email ?? "", socialID: user.userID ?? "", socialAccountID: user.userID, socialAccountType: "google")
            
        } else {
            print("\(error.localizedDescription)")
        }
    }

    func trySocialAutherisation(_ userName: String, email: String, socialID: String, socialAccountID:String, socialAccountType: String) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "WelcomeToYogiFiScreen") as? WelcomeToYogiFiScreen
        self.navigationController?.pushViewController(vc!, animated: true)

    }

}
