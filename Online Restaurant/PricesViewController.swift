//
//  PricesViewController.swift
//  Online Restaurant
//
//  Created by TIEGO Ouedraogo on 2/8/19.
//  Copyright © 2019 TIEGO Ouedraogo. All rights reserved.
//

import UIKit

class PricesViewController: UIViewController {
  
    
    var total: Double = 0.0
    var count: Double = 0.0
    var foodName: String = ""
    var drinkName: String = "";
    var saladName: String = ""
    var dessertName: String = "";
    var shoppingCart: [String: (numberAlreadyPurchased: Int, price: Double)]? = nil;

    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarItem.badgeValue = "$"

    label.text = String(format: "Your total is $%.2f for %d items\n\n", total, count);
    if shoppingCart == nil {
    return;
    }
    
    print(total)
    for (key, value) in shoppingCart! {
    print(key, value);
    let unitPrice: Double = value.price;
    let totalPrice = unitPrice * Double(value.numberAlreadyPurchased);
    label.text! += "\(key) \(value.numberAlreadyPurchased) \(totalPrice)\n";
    }
    
}
}
