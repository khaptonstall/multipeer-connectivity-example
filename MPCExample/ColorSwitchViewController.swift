//
//  ColorSwitchViewController.swift
//  MPCExample
//
//  Created by Kyle Haptonstall on 2/23/16.
//  Copyright © 2016 Kyle Haptonstall. All rights reserved.
//

import Foundation
import UIKit

class ColorSwitchViewController: UIViewController{
    
    @IBOutlet weak var imageHolder: UIImageView!
    let colorService = ColorManager()
    @IBOutlet weak var connectionLabel: UILabel!
    
    @IBOutlet weak var urlField: UITextField!
    
    @IBAction func onSendUrl(sender: AnyObject) {
        if urlField.text != nil{
            colorService.sendPic(fromUrl: urlField.text!)
        }
    }
    
    
    @IBAction func onRed(sender: AnyObject) {
        self.changeColor(UIColor.redColor())
        colorService.sendColor("red")
    }
    
    @IBAction func onYellow(sender: AnyObject) {
        self.changeColor(UIColor.yellowColor())
        colorService.sendColor("yellow")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        colorService.delegate = self
    }
    
    func changeColor(color : UIColor) {
        UIView.animateWithDuration(0.2) {
            self.view.backgroundColor = color
        }
    }
}

extension ColorSwitchViewController : ColorServiceDelegate {
    
    func connectedDevicesChanged(manager: ColorManager, connectedDevices: [String]) {
        NSOperationQueue.mainQueue().addOperationWithBlock {
            self.connectionLabel.text = "Connections: \(connectedDevices)"
        }
    }
    
    func colorChanged(manager: ColorManager, colorString: String) {
        NSOperationQueue.mainQueue().addOperationWithBlock {
            let image =  UIImage(data: NSData(contentsOfURL: NSURL(string: colorString)!)!)
            self.imageHolder.image = image
            switch colorString {
            case "red":
                self.changeColor(UIColor.redColor())
            case "yellow":
                self.changeColor(UIColor.yellowColor())
            default:
                NSLog("%@", "Unknown color value received: \(colorString)")
            }
        }
    }
    
}