//
//  ViewController.swift
//  Online Restaurant
//
//  Created by TIEGO Ouedraogo on 2/5/19.
//  Copyright © 2019 TIEGO Ouedraogo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //Travelling method
        
        tabBarItem.badgeValue = "Kitchen"
    }
        @IBAction func unwindToRed(unwindSegue: UIStoryboardSegue){
            print("unwindToRed(unwindSegue:)");
            if let identifier: String = unwindSegue.identifier {
                print("unwindSegue.identifier = \(identifier)");
            }
            if let title: String = unwindSegue.source.title {
                print("unwindSegue.source.title = \(title)");
            }
            if let title: String = unwindSegue.source.navigationItem.title {
                print("unwindSegue.source.navigationItem.title = \(title)");
            }
            if let title: String = unwindSegue.destination.title {
                print("unwindSegue.destination.title = \(title)");
            }
            if let title: String = unwindSegue.destination.navigationItem.title {
                print("unwindSegue.destination.navigationItem.title = \(title)");
            }
            
        }

}

