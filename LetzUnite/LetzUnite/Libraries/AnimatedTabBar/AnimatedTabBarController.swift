//
//  AnimatedTabBarController.swift
//  LetzUnite
//
//  Created by Himanshu on 4/5/18.
//  Copyright © 2018 LetzUnite. All rights reserved.
//

import UIKit

open class AnimatedTabBarController: UITabBarController {

    //var presenter: TabBarPresenterProtocol?

    fileprivate var containers: [String: UIView] = [:]
    
    open override var viewControllers: [UIViewController]? {
        didSet {
            initializeContainers()
        }
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        initializeContainers()
        //presenter?.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    open override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    fileprivate func initializeContainers() {
        containers.values.forEach { $0.removeFromSuperview() }
        containers = createViewContainers()
        createCustomIcons(containers)
    }
    
    open override func setViewControllers(_ viewControllers: [UIViewController]?, animated: Bool) {
        super.setViewControllers(viewControllers, animated: animated)
        initializeContainers()
    }
    
    // MARK: create methods
    
    fileprivate func createCustomIcons(_ containers: [String: UIView]) {
        
        guard let items = tabBar.items as? [AnimatedTabBarItem] else {
            fatalError("items must inherit AnimatedTabBarItem")
        }
        
        var index = 0
        for item in items {
            
            guard let container = containers["container\(items.count - 1 - index)"] else {
                fatalError()
            }
            container.tag = index
            
            let renderMode = item.iconColor.cgColor.alpha == 0 ? UIImageRenderingMode.alwaysOriginal :
                UIImageRenderingMode.alwaysTemplate
            
            let iconImage = item.image ?? item.iconView?.icon.image
            let icon = UIImageView(image: iconImage?.withRenderingMode(renderMode))
            icon.translatesAutoresizingMaskIntoConstraints = false
            icon.tintColor = item.iconColor
            icon.highlightedImage = item.selectedImage?.withRenderingMode(renderMode)
            
            // text
            let textLabel = UILabel()
            if let title = item.title, !title.isEmpty {
                textLabel.text = title
            } else {
                textLabel.text = item.iconView?.textLabel.text
            }
            textLabel.backgroundColor = UIColor.clear
            textLabel.textColor = item.textColor
            textLabel.font = item.textFont
            textLabel.textAlignment = NSTextAlignment.center
            textLabel.translatesAutoresizingMaskIntoConstraints = false
            
            container.backgroundColor = (items as [AnimatedTabBarItem])[index].bgDefaultColor
            
            container.addSubview(icon)
            var itemSize = item.image?.size ?? CGSize(width: 30, height: 30)
            
            if(index == items.count/2){
                itemSize = CGSize(width: 86, height: 66)
            }
            
            createConstraints(icon, container: container, size: itemSize, yOffset: -5 - item.yOffSet)
            
            container.addSubview(textLabel)
            let textLabelWidth = tabBar.frame.size.width / CGFloat(items.count) - 5.0
            createConstraints(textLabel, container: container, width: textLabelWidth, yOffset: 16 - item.yOffSet)
            
            if item.isEnabled == false {
                icon.alpha = 0.5
                textLabel.alpha = 0.5
            }
            item.iconView = (icon: icon, textLabel: textLabel)
            item.tabBarImage = icon.image
            item.tabBarSelectedImage = item.selectedImage
            
            if 0 == index { // selected first elemet
                item.selectedState()
                container.backgroundColor = (items as [AnimatedTabBarItem])[index].bgSelectedColor
            }
            
            item.image = nil
            item.title = ""
            index += 1
        }
    }
    
    fileprivate func createConstraints(_ view: UIView, container: UIView, size: CGSize, yOffset: CGFloat) {
        createConstraints(view, container: container, width: size.width, height: size.height, yOffset: yOffset)
    }
    
    fileprivate func createConstraints(_ view: UIView, container: UIView, width: CGFloat? = nil, height: CGFloat? = nil, yOffset: CGFloat) {
        
        let constX = NSLayoutConstraint(item: view,
                                        attribute: NSLayoutAttribute.centerX,
                                        relatedBy: NSLayoutRelation.equal,
                                        toItem: container,
                                        attribute: NSLayoutAttribute.centerX,
                                        multiplier: 1,
                                        constant: 0)
        container.addConstraint(constX)
        
        let constY = NSLayoutConstraint(item: view,
                                        attribute: NSLayoutAttribute.centerY,
                                        relatedBy: NSLayoutRelation.equal,
                                        toItem: container,
                                        attribute: NSLayoutAttribute.centerY,
                                        multiplier: 1,
                                        constant: yOffset)
        container.addConstraint(constY)
        
        if let width = width {
            let constW = NSLayoutConstraint(item: view,
                                            attribute: NSLayoutAttribute.width,
                                            relatedBy: NSLayoutRelation.equal,
                                            toItem: nil,
                                            attribute: NSLayoutAttribute.notAnAttribute,
                                            multiplier: 1,
                                            constant: width)
            view.addConstraint(constW)
        }
        
        if let height = height {
            let constH = NSLayoutConstraint(item: view,
                                            attribute: NSLayoutAttribute.height,
                                            relatedBy: NSLayoutRelation.equal,
                                            toItem: nil,
                                            attribute: NSLayoutAttribute.notAnAttribute,
                                            multiplier: 1,
                                            constant: height)
            view.addConstraint(constH)
        }
    }
    
    fileprivate func createViewContainers() -> [String: UIView] {
        
        guard let items = tabBar.items else {
            fatalError("add items in tabBar")
        }
        
        var containersDict: [String: UIView] = [:]
        
        for index in 0 ..< items.count {
            let viewContainer = createViewContainer()
            containersDict["container\(index)"] = viewContainer
        }
        
        var formatString = "H:|-(0)-[container0]"
        for index in 1 ..< items.count {
            formatString += "-(0)-[container\(index)(==container0)]"
        }
        formatString += "-(0)-|"
        let constranints = NSLayoutConstraint.constraints(withVisualFormat: formatString,
                                                          options: NSLayoutFormatOptions.directionRightToLeft,
                                                          metrics: nil,
                                                          views: (containersDict as [String: AnyObject]))
        view.addConstraints(constranints)
        
        return containersDict
    }
    
    fileprivate func createViewContainer() -> UIView {
        let viewContainer = UIView()
        viewContainer.backgroundColor = UIColor.clear // for test
        viewContainer.translatesAutoresizingMaskIntoConstraints = false
        viewContainer.isExclusiveTouch = true
        view.addSubview(viewContainer)
        
        // add gesture
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(AnimatedTabBarController.tapHandler(_:)))
        tapGesture.numberOfTouchesRequired = 1
        viewContainer.addGestureRecognizer(tapGesture)
        
        // add constrains
        viewContainer.bottomAnchor.constraint(equalTo: bottomLayoutGuide.topAnchor).isActive = true
        
        let constH = NSLayoutConstraint(item: viewContainer,
                                        attribute: NSLayoutAttribute.height,
                                        relatedBy: NSLayoutRelation.equal,
                                        toItem: nil,
                                        attribute: NSLayoutAttribute.notAnAttribute,
                                        multiplier: 1,
                                        constant: 49)
        viewContainer.addConstraint(constH)
        
        return viewContainer
    }
    
    // MARK: actions
    
    @objc open func tapHandler(_ gesture: UIGestureRecognizer) {
        
        guard let items = tabBar.items as? [AnimatedTabBarItem],
            let gestureView = gesture.view else {
                fatalError("items must inherit AnimatedTabBarItem")
        }
        
        let currentIndex = gestureView.tag
        
        if items[currentIndex].isEnabled == false { return }
        
        let controller = childViewControllers[currentIndex]
        
        if let shouldSelect = delegate?.tabBarController?(self, shouldSelect: controller)
            , !shouldSelect {
            return
        }
        
        if selectedIndex != currentIndex {
            let animationItem: AnimatedTabBarItem = items[currentIndex]
            animationItem.playAnimation()
            
            let deselectItem = items[selectedIndex]
            
            let containerPrevious: UIView = deselectItem.iconView!.icon.superview!
            containerPrevious.backgroundColor = items[currentIndex].bgDefaultColor
            
            deselectItem.deselectAnimation()
            
            let container: UIView = animationItem.iconView!.icon.superview!
            container.backgroundColor = items[currentIndex].bgSelectedColor
            
            selectedIndex = gestureView.tag
            
        } else if selectedIndex == currentIndex {
            
            if let navVC = self.viewControllers![selectedIndex] as? UINavigationController {
                navVC.popToRootViewController(animated: true)
            }
        }
        delegate?.tabBarController?(self, didSelect: controller)
    }

}


extension AnimatedTabBarController {
    
    open func changeSelectedColor(_ textSelectedColor: UIColor, iconSelectedColor: UIColor) {
        
        let items = tabBar.items as! [AnimatedTabBarItem]
        for index in 0 ..< items.count {
            let item = items[index]
            
            item.animation.textSelectedColor = textSelectedColor
            item.animation.iconSelectedColor = iconSelectedColor
            
            if item == tabBar.selectedItem {
                item.selectedState()
            }
        }
    }
    
    open func animationTabBarHidden(_ isHidden: Bool) {
        guard let items = tabBar.items as? [AnimatedTabBarItem] else {
            fatalError("items must inherit AnimatedTabBarItem")
        }
        for item in items {
            if let iconView = item.iconView {
                iconView.icon.superview?.isHidden = isHidden
            }
        }
        tabBar.isHidden = isHidden
    }
    
    //Selected UITabBarItem with animaton
    open func setSelectIndex(from: Int, to: Int) {
        selectedIndex = to
        guard let items = tabBar.items as? [AnimatedTabBarItem] else {
            fatalError("items must inherit AnimatedTabBarItem")
        }
        
        let containerFrom = items[from].iconView?.icon.superview
        containerFrom?.backgroundColor = items[from].bgDefaultColor
        items[from].deselectAnimation()
        
        let containerTo = items[to].iconView?.icon.superview
        containerTo?.backgroundColor = items[to].bgSelectedColor
        items[to].playAnimation()
    }
}

//extension AnimatedTabBarController: TabBarViewProtocol {
//    func styleTabBarView() {
//        
//    }
//    
//    func showError() {
//        
//    }
//    
//    func showLoading() {
//        
//    }
//    
//    func hideLoading() {
//        
//    }
//}



