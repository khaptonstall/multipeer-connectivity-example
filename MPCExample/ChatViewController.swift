//
//  ChatViewController.swift
//  MPCExample
//
//  Created by Kyle Haptonstall on 2/24/16.
//  Copyright © 2016 Kyle Haptonstall. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource{
    
    let chatService = ChatManager()
    var messages = [[String:String]]()
    
    
    @IBOutlet weak var tableView: UITableView!
    
    
    
    @IBOutlet weak var connectionLabel: UILabel!
    
    
    
    @IBOutlet weak var messageTextField: UITextField!
    
    
    @IBAction func onSendMessage(sender: AnyObject) {
        if messageTextField.text != nil{
            chatService.sendText(messageTextField.text!)
            let messageData:[String:String] = ["Sender": "You", "Message": messageTextField.text!]
            messages.append(messageData)
            tableView.reloadData()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        chatService.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 44.0
        tableView.rowHeight = UITableViewAutomaticDimension
        
        // Set up keyboard dismissal
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)

    }
    
    func changeColor(color : UIColor) {
        UIView.animateWithDuration(0.2) {
            self.view.backgroundColor = color
        }
    }
    
    // MARK: TableView Methods
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ChatCell") as! ChatCell
        let messageData = messages[indexPath.row]
        
        let sender = messageData["Sender"]
        if sender == "You"{
            cell.sender.textAlignment = NSTextAlignment.Right
            cell.message.textAlignment = NSTextAlignment.Right
        }
        cell.sender.text = sender
        cell.message.text = messageData["Message"]
        return cell
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    

    
}

extension ChatViewController : ChatServiceDelegate {
    
    func connectedDevicesChanged(manager: ChatManager, connectedDevices: [String]) {
        NSOperationQueue.mainQueue().addOperationWithBlock {
            self.connectionLabel.text = "Connections: \(connectedDevices)"
        }
    }
    
    func messageChanged(manager: ChatManager, message: String, sender: String){
        NSOperationQueue.mainQueue().addOperationWithBlock {
            let messageData:[String:String] = ["Sender": sender, "Message": message]
            self.messages.append(messageData)
            self.tableView.reloadData()
        }
    }
    
}