//
//  AppBaseView.swift
//  LetzUnite
//
//  Created by Himanshu on 4/1/18.
//  Copyright © 2018 LetzUnite. All rights reserved.
//

import UIKit
import ZCAnimatedLabel

class AppBaseView: UIViewController {

    var presenter: AppBasePresenterProtocol?
    
    //var welcomeAnimatedLabel:ZCAnimatedLabel?
    
    @IBOutlet var viewWelcome: ZCAnimatedLabel!
    @IBOutlet var welcomeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func showNextScreen() {
        presenter?.showNextScreen()
    }
    
    func makeWelcomeMessage(with name:String) -> NSAttributedString  {
        self.viewWelcome?.animationDuration = 0.3
        self.viewWelcome?.animationDelay = 0.04
        self.viewWelcome?.text = "Hi, \(name) \n\n\n\n Welcome."
        
        let style = NSMutableParagraphStyle()
        style.lineSpacing = 5
        style.alignment = NSTextAlignment.left
    
        let mutableString = NSMutableAttributedString(string: (self.viewWelcome?.text)!, attributes: [NSAttributedStringKey.font : UIFont(
            name: "Georgia",
            size: 30)!, NSAttributedStringKey.foregroundColor:UIColor.black, NSAttributedStringKey.paragraphStyle:style])
        mutableString.addAttribute(NSAttributedStringKey.foregroundColor, value: appThemeColor, range: NSRange(location: 4, length: name.count))
        
        mutableString.addAttribute(NSAttributedStringKey.font, value: UIFont(
            name: "Georgia",
            size: 40.0)!, range: NSRange(location: 4, length: name.count))
        
        return mutableString
    }
}

extension AppBaseView: AppBaseViewProtocol {
    
    func showWelcomeView(with name:String) {
        self.viewWelcome?.backgroundColor = appThemeColor
        self.viewWelcome?.onlyDrawDirtyArea = true
        self.viewWelcome?.layerBased = false
        object_setClass(self.viewWelcome, ZCSpinLabel.classForCoder())
        self.viewWelcome?.backgroundColor = UIColor.clear
        self.viewWelcome?.attributedString = self.makeWelcomeMessage(with: name)
        
        self.viewWelcome?.setNeedsDisplay()
        
        DispatchQueue.global(qos: .userInteractive).async {
            DispatchQueue.main.async {
                self.viewWelcome?.attributedString = self.makeWelcomeMessage(with: name)
                self.viewWelcome?.startAppearAnimation()
            }
        }

        presenter?.hideWelcomeView()
    }
    
    func hideWelcomeView() {
        self.perform(#selector(showNextScreen), with: nil, afterDelay: TimeInterval(0.5 + self.viewWelcome.totoalAnimationDuration))
    }
    
    func showError() {
        
    }
    
    func showLoading() {
        
    }
    
    func hideLoading() {
        
    }

}


