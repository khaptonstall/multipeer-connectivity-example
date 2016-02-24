//
//  ChatViewController.swift
//  MPCExample
//
//  Created by Kyle Haptonstall on 2/24/16.
//  Copyright © 2016 Kyle Haptonstall. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController{
    
    let chatService = ChatManager()
    @IBOutlet weak var connectionLabel: UILabel!
    
    
    
    @IBOutlet weak var messageTextField: UITextField!
    @IBOutlet weak var messageLable: UILabel!
    
    
    @IBAction func onSendMessage(sender: AnyObject) {
        if messageTextField.text != nil{
            chatService.sendText(messageTextField.text!)
        }
    }
    
    
      
    override func viewDidLoad() {
        super.viewDidLoad()
        chatService.delegate = self
    }
    
    func changeColor(color : UIColor) {
        UIView.animateWithDuration(0.2) {
            self.view.backgroundColor = color
        }
    }
    
    
}

extension ChatViewController : ChatServiceDelegate {
    
    func connectedDevicesChanged(manager: ChatManager, connectedDevices: [String]) {
        NSOperationQueue.mainQueue().addOperationWithBlock {
            self.connectionLabel.text = "Connections: \(connectedDevices)"
        }
    }
    
    func messageChanged(manager: ChatManager, message: String){
        NSOperationQueue.mainQueue().addOperationWithBlock {
            self.messageLable.text = message
        }
    }
    
}