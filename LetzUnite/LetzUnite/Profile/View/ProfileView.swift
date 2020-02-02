//
//  ProfileView.swift
//  LetzUnite
//
//  Created by Himanshu on 4/4/18.
//  Copyright © 2018 LetzUnite. All rights reserved.
//

import UIKit

class ProfileView: UIViewController {

    var presenter: ProfilePresenterProtocol?

    @IBOutlet var view_topBgContainer: UIView!
    @IBOutlet var constraint_profileTopBgTop: NSLayoutConstraint!
    @IBOutlet var constraint_profileTopBgBottom: NSLayoutConstraint!
    @IBOutlet var scrollVw_profile: UIScrollView!
    @IBOutlet var view_topBgSubContainer: UIView!
    @IBOutlet var imgVw_topBg: UIImageView!
    @IBOutlet var imgVw_profilePic: UIImageView!
    @IBOutlet var view_profileCompletion: UIView!
    @IBOutlet var view_profileCompletionBar: UIView!
    @IBOutlet var view_aboutMe: UIView!
    @IBOutlet var view_bloodGroup: UIView!
    @IBOutlet var view_bloodDonate: UIView!
    @IBOutlet var view_receive: UIView!
    @IBOutlet var button_name: UIButton!
    @IBOutlet var button_location: UIButton!
    @IBOutlet var button_email: UIButton!
   
    @IBOutlet var imgVw1: UIImageView!
    @IBOutlet var imgVw2: UIImageView!
    @IBOutlet var imgVw3: UIImageView!
    @IBOutlet var imgVw4: UIImageView!
    @IBOutlet var imgVw5: UIImageView!
    
    var animator:UIDynamicAnimator?
    var timer:Timer?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.animator = UIDynamicAnimator(referenceView: self.view_topBgSubContainer)
        self.addDynamicsInImages()
        
        presenter?.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //self.actionUpdateProfile("")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func actionLogout(_ sender: Any) {
        UserDefaults.saveObject(object: false, forKey: UserDefaultsSerializationKey.isLogined.rawValue)
    }
    
    @IBAction func actionEditProfile(_ sender: Any) {
        presenter?.showEditProfileScreen()
    }
    
    @IBAction func actionUpdateProfile(_ sender: Any) {
        
        var user : UserProfileModel  = UserProfileModel.init()
        
        user.username = "Himz"
        user.email = "proyadav@gmail.com"
        user.mobile = "8800465004"
        user.password = "11111"
        user.confirmPassword = "11111"

        /*
         set all values from text field into model
         */
        
        presenter?.updateProfile(with: user)
    }
    
    
    
    //MARK: UIDynamics
    func addDynamicsInImages() {
        let gravityBehaviour = UIGravityBehavior(items: [self.imgVw1,self.imgVw2,self.imgVw3,self.imgVw4,self.imgVw5])
        gravityBehaviour.magnitude = 0
        self.animator?.addBehavior(gravityBehaviour)
        
        let collisionBehaviour = UICollisionBehavior(items: [self.imgVw1,self.imgVw2,self.imgVw3,self.imgVw4,self.imgVw5])

        collisionBehaviour.addBoundary(withIdentifier: "" as NSCopying, from: CGPoint(x: self.view_topBgSubContainer.frame.origin.x, y: self.view_topBgSubContainer.frame.origin.y + self.view_topBgSubContainer.frame.size.height), to: CGPoint(x: self.view_topBgSubContainer.frame.origin.x + self.view_topBgSubContainer.frame.size.width, y: self.view_topBgSubContainer.frame.origin.y + self.view_topBgSubContainer.frame.size.height))
        collisionBehaviour.translatesReferenceBoundsIntoBoundary = true
        collisionBehaviour.collisionMode = .everything
        self.animator?.addBehavior(collisionBehaviour)
        
        let pushBehaviour = UIPushBehavior(items: [self.imgVw1,self.imgVw2,self.imgVw3,self.imgVw4,self.imgVw5], mode: .instantaneous)
        pushBehaviour.magnitude = 0.01
        self.animator?.addBehavior(pushBehaviour)
        
        let dynamicItemBehaviour = UIDynamicItemBehavior(items: [self.imgVw1,self.imgVw2,self.imgVw3,self.imgVw4,self.imgVw5])
        dynamicItemBehaviour.elasticity = 1.0
        dynamicItemBehaviour.density = 0.1
        dynamicItemBehaviour.resistance = 0
        dynamicItemBehaviour.friction = 0
        dynamicItemBehaviour.angularResistance = 0
        dynamicItemBehaviour.allowsRotation = false
        self.animator?.addBehavior(dynamicItemBehaviour)
        
        Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(actionPushAnimation), userInfo: nil, repeats: true)
    }
    
    @objc func actionPushAnimation() {
            DispatchQueue.main.async {
            let pushBehaviour = UIPushBehavior(items: [self.imgVw1], mode: .instantaneous)
            pushBehaviour.magnitude = 0.01
            pushBehaviour.angle = CGFloat(arc4random_uniform(21) + 1)
            self.animator?.addBehavior(pushBehaviour)
        
            let pushBehaviour2 = UIPushBehavior(items: [self.imgVw2], mode: .instantaneous)
            pushBehaviour2.magnitude = 0.01
            pushBehaviour2.angle = CGFloat(arc4random_uniform(21) + 1)
            self.animator?.addBehavior(pushBehaviour2)
        
            let pushBehaviour3 = UIPushBehavior(items: [self.imgVw3], mode: .instantaneous)
            pushBehaviour3.magnitude = 0.01
            pushBehaviour3.angle = CGFloat(arc4random_uniform(21) + 1)
            self.animator?.addBehavior(pushBehaviour3)
        
            let pushBehaviour4 = UIPushBehavior(items: [self.imgVw4], mode: .instantaneous)
            pushBehaviour4.magnitude = 0.01
            pushBehaviour4.angle = CGFloat(arc4random_uniform(21) + 1)
            self.animator?.addBehavior(pushBehaviour4)
        
            let pushBehaviour5 = UIPushBehavior(items: [self.imgVw5], mode: .instantaneous)
            pushBehaviour5.magnitude = 0.01
            pushBehaviour5.angle = CGFloat(arc4random_uniform(21) + 1)
            self.animator?.addBehavior(pushBehaviour5)
        }
    }
    
}


extension ProfileView: ProfileViewProtocol {
    func showError(_ message: String?) {
        Utility.showToast(with: message)
    }
    
    func showMessage(_ message: String?) {
        Utility.showToast(with: message)
    }
    
    func showLoading() {

    }
    
    func hideLoading() {
        
    }
    
    func updateView(With parameters: UserProfileModel) {
        /*
         need to set textfields value using this model
         */
    }
}

extension ProfileView: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        DispatchQueue.main.async {
            if scrollView.contentOffset.y >= 0 {
                // scrolling up
                self.view_topBgContainer.clipsToBounds = true
                self.constraint_profileTopBgBottom?.constant = -scrollView.contentOffset.y / 2
                self.constraint_profileTopBgTop?.constant = scrollView.contentOffset.y / 2
            } else {
                // scrolling down
                self.constraint_profileTopBgTop?.constant = scrollView.contentOffset.y
                self.view_topBgContainer.clipsToBounds = false
            }
        }
        
        //let factor = scrollView.contentOffset.y / self.view.frame.height
    }
    
}



