//
//  ChatView.swift
//  LetzUnite
//
//  Created by B0081006 on 6/24/18.
//  Copyright © 2018 Airtel. All rights reserved.
//

import UIKit

class ChatView: UIViewController {
    var presenter: ChatPresenterProtocol?
    var navView:NavigationBarView?
    
    @IBOutlet var tableViewMessageList: UITableView!
    @IBOutlet var viewSendMessage: UIView!
    @IBOutlet var textViewInputMessage: UITextView!
    @IBOutlet var layoutConstraintContentViewBottomWithSendMessageViewBottom: NSLayoutConstraint!
    var messageList:Array<Message>?
   
    @IBOutlet var label_Chat: UILabel!
    @IBOutlet var label_ChatTitle: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.addKeyboardObserver()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.removeKeyboardObserver()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addKeyboardObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(_:)), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
    }
    
    @objc private func keyboardWillChange(_ notification: NSNotification) {
        guard
            let info = notification.userInfo,
            let kbFrame = (info[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
                return
        }
        
        let kb = view.convert(kbFrame, from: view.window!.screen.coordinateSpace)
        let fromBottom = max(0, view.frame.size.height - 50 - kb.origin.y)
        
        let oldYContentOffset = self.tableViewMessageList.contentOffset.y
        let oldTableViewHeight = self.tableViewMessageList.bounds.size.height
        
        UIView.animate(withDuration: 0) {
        self.layoutConstraintContentViewBottomWithSendMessageViewBottom.constant = fromBottom;
            self.view.layoutIfNeeded()

            let newTableViewHeight = self.tableViewMessageList.bounds.size.height
            let contentSizeHeight = self.tableViewMessageList.contentSize.height
            var newYContentOffset = oldYContentOffset - newTableViewHeight + oldTableViewHeight
            
            let possibleBottommostYContentOffset = contentSizeHeight - newTableViewHeight
            
            newYContentOffset = min(newYContentOffset, possibleBottommostYContentOffset)

            let possibleTopmostYContentOffset = 0
            newYContentOffset = CGFloat(max(possibleTopmostYContentOffset, Int(newYContentOffset)))
            
            let newTableViewContentOffset = CGPoint(x: self.tableViewMessageList.contentOffset.x, y: newYContentOffset)
            self.tableViewMessageList.contentOffset = newTableViewContentOffset

        }
        
    }
    
    func removeKeyboardObserver() {
        NotificationCenter.default.removeObserver(self, name: Notification.Name.UIKeyboardWillChangeFrame, object: nil)
    }
    
    @IBAction func actionBack(_ sender: Any) {
        presenter?.popToPreviousScreen()
    }
    
    func setupNavigationBar() {
        navView = NavigationBarView.init(navType: .kDetailNav, frame: CGRect(x: 0, y: UIApplication.shared.statusBarFrame.height, width: self.view.bounds.size.width, height: 56))
        navView?.delegate = self
        navView?.label_detailTitle.alpha = 0
        navView?.label_detailTitle.text = "Chat"
        navView?.label_detailTitle.isHidden = true
        navView?.layoutIfNeeded()
        self.navView?.backgroundColor = UIColor.white
        self.view.addSubview(navView!)
        //self.view.bringSubview(toFront: self.label_ChatTitle)
    }
    
    @IBAction func buttonSend(_ sender: Any) {
        var text = self.textViewInputMessage.text
        text = text?.trimmingCharacters(in: .whitespacesAndNewlines)
        if text?.count == 0 {
            return
        }

        let message = Message.init(content: text!, isOutgoing: false)
        self.messageList?.append(message)
        self.tableViewMessageList.reloadData()
        self.textViewInputMessage.text = ""
        
        if ((self.messageList?.count)! > 0) {
            self.tableViewMessageList.scrollToRow(at: IndexPath(row: (self.messageList?.count)! - 1, section: 0), at: .bottom, animated: true)
        }
    }
    
    func createDummyMessageList() -> NSArray {
        var array = NSArray()
        array.adding("Hi!")
        array.adding("Yo")
        array.adding("Whatsup")
        return array
    }
}

extension ChatView: ChatViewProtocol {
    
    func prepareForAnimation() {
        
    }
    
    func styleChatView() {
        self.setupNavigationBar()
        self.messageList = self.createDummyMessageList() as? Array<Message>
        self.tableViewMessageList.rowHeight = UITableViewAutomaticDimension
        self.tableViewMessageList.estimatedRowHeight = 50.0

        self.textViewInputMessage.layer.borderColor = UIColor.lightGray.cgColor;
        self.textViewInputMessage.layer.borderWidth = 1
        self.textViewInputMessage.layer.cornerRadius = 5
        self.tableViewMessageList.reloadData()
    }
    
    func animateChatView() {
        
    }
    
    func showMessage(_ message:String?) {
        Utility.showToast(with: message)
    }
    
    func showError(_ message: String?) {
        Utility.showToast(with: message)
    }
    
    func showLoading() {
        
    }
    
    func hideLoading() {

    }
    
    func updateView(With parameters: UserProfileModel) {

    }
}

extension ChatView: NavigationBarProtocol {
    func didPressBackButton() {
        presenter?.popToPreviousScreen()
    }
}

extension ChatView: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.messageList?.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let message:Message = self.messageList![indexPath.row]
        
        if (message.isOutgoing) {
            let cell: ChatOutgoingMessageTableCell = tableView.dequeueReusableCell(withIdentifier: CellIDs.chatOutgoingMessageTableCell.rawValue) as! ChatOutgoingMessageTableCell
            cell.selectionStyle = .none
            cell.setMessage(self.messageList![indexPath.row])
            return cell;
        } else {
            let cell: ChatIncomingMessageTableCell = tableView.dequeueReusableCell(withIdentifier: CellIDs.chatIncomingMessageTableCell.rawValue) as! ChatIncomingMessageTableCell
            cell.selectionStyle = .none
            cell.setMessage(self.messageList![indexPath.row])
            return cell;
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}

extension ChatView: UIScrollViewDelegate {
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let yVelocity = self.tableViewMessageList.panGestureRecognizer.velocity(in: self.tableViewMessageList).y
        if (yVelocity < 0) {
            print("Up \(yVelocity)")
        } else if (yVelocity > 1000) {
            print("Down \(yVelocity)")
            //hide keyboard here
            self.textViewInputMessage.resignFirstResponder()
        } else {
            print("Don't 9")
        }
    }
}

