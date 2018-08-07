//
//  MFPRofileVC.swift
//  MF
//
//  Created by Ahmed Durrani on 05/04/2018.
//  Copyright © 2018 TechEase. All rights reserved.
//

import UIKit
import FacebookLogin
import FBSDKLoginKit

class MFPRofileVC: UIViewController {
    @IBOutlet var btnIsLoginOrLogout: UIButton!
    var index: Int?

    @IBOutlet var userImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let userID = UserDefaults.standard.string(forKey: "id")
        let userImage = UserDefaults.standard.string(forKey: "image")
        

        if userID == nil {
//            self.showAlert(title: "MF", message: "Please Login First", controller: self)
            btnIsLoginOrLogout.setTitle("Continue with Facebook", for: .normal)
           
//            WAShareHelper.loadImage(urlstring:userImage! , imageView: (self.userImage)!, placeHolder: "logo_grey")

            
        } else {
            
            btnIsLoginOrLogout.setTitle("Logout", for: .normal)
            WAShareHelper.loadImage(urlstring:userImage! , imageView: (self.userImage)!, placeHolder: "logo_grey")


        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnBack_Pressed(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    func logOutUser(){
        let logOut = LoginManager()
        logOut.logOut()
    }
   
    @IBAction func btnCreateUserThroughSocial_Pressed(_ sender: UIButton) {
        
        let userID = UserDefaults.standard.string(forKey: "id")
        
        if userID == nil {
            let facebookMangager = SocialMediaManager()
            facebookMangager.facebookSignup(self)
            facebookMangager.successBlock = { (response) -> Void in
                self.signupWebservice(response as! Dictionary)
            } }else {
            
            logOutUser()
            btnIsLoginOrLogout.setTitle("Continue with Facebook", for: .normal)
            UserDefaults.standard.set(nil , forKey: "email")
            UserDefaults.standard.set(nil , forKey: "id")
            UserDefaults.standard.set(nil , forKey: "image")

            
        }

        
        
       
    }
    func signupWebservice(_ params: Dictionary<String, String>) {
        let email : String?
        let idOfFb : String?
        let firstName : String?
        let gender  : String?
        let phonenumber : String?
        let deviceType  : String?
        let deviceToken : String?
        let image : String?
        email =  params["data[User][email]"]
        idOfFb =  params["data[User][facebook_id]"]
        firstName =  params["data[User][first_name]"]
        gender     = params["data[User][gender]"]
        deviceType  = params["data[Device][device_type]"]
        deviceToken = "81dc9bdb52d04dc20036dbd8313ed055"
        image = params["data[User][picture]"]
        

       

        let param = [ "email"               : email!
            ] as [String : Any]
        
        
       
        
        WebServiceManager.post(params:param as Dictionary<String, AnyObject> , serviceName: SIGNUPSOCIAL, isLoaderShow: true, serviceType: "Sign Up", modelType: UserModel.self, success: { (response) in
            let responseObj = response as! UserModel

            if responseObj.success == true {
                
                if responseObj.userData == nil {
                    UserDefaults.standard.set(responseObj.collection?.email , forKey: "email")
                    UserDefaults.standard.set(responseObj.collection?.user_id , forKey: "id")
                    UserDefaults.standard.set(image , forKey: "image")
                    self.btnIsLoginOrLogout.setTitle("Logout", for: .normal)
                    WAShareHelper.loadImage(urlstring:image! , imageView: (self.userImage)!, placeHolder: "logo_grey")
                    self.navigationController?.popViewController(animated: true)

                } else {
                    UserDefaults.standard.set(responseObj.userData?.email , forKey: "email")
                    UserDefaults.standard.set(responseObj.userData?.user_id , forKey: "id")
                    UserDefaults.standard.set(image , forKey: "image")
                    self.btnIsLoginOrLogout.setTitle("Logout", for: .normal)
                    WAShareHelper.loadImage(urlstring:image! , imageView: (self.userImage)!, placeHolder: "logo_grey")
                    self.navigationController?.popViewController(animated: true)

                    
                }
                

            } else {
//                self .showAlert(title: "OPEN SPOT ", message: responseObj.message! , controller: self)
            }



        }, fail: { (error) in
//            self.showAlert(title: "OPEN SPOT", message: error.description , controller: self)
        }, showHUD: true)
    
    }
    
    
    
}
