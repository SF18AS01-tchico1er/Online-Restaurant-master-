//
//  DessertViewController.swift
//  Online Restaurant
//
//  Created by TIEGO Ouedraogo on 2/8/19.
//  Copyright © 2019 TIEGO Ouedraogo. All rights reserved.
//

import UIKit

class DessertViewController: UIViewController {
    @IBOutlet weak var dessertImageView: UIImageView!
    var dessertArray: [String] = [
        "BoudonCake",
        "CheeseCake",
        "ChocolateCake",
        "Cookies",
        "MartinCake"
    ]
    var dessertIndex: Int = 0
    var total: Double = 0.0;   // price
    var count: Double = 0;       // quantity
    var dessertName: String = "";     // name
    
    var shoppingCart: [String: (numberAlreadyPurchased: Int, prices: Double)]? = nil;
    
    var dessertChoices: [String: (stock: Int, dessertPrices: Double)] = [
        "BoudonCake": (10, 44.0),
        "CheeseCake": (10, 28.0),
        "ChocolateCake": (10, 12.0),
        "Cookies": (10, 19.99),
        "MartinCake": (10, 23.0)
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarItem.badgeValue = "Dessert"
        // Do any additional setup after loading the view.
    }
    
    @IBAction func dessertButton(_ sender: UIButton) {
        dessertIndex = Int.random(in: 0 ..< dessertArray.count)
        dessertImageView.image = UIImage(named: dessertArray[dessertIndex ])
    }
    
    @IBAction func dessertMenuButtons(_ sender: UIButton) {
        
        if let itemString = sender.title(for: .normal){
            let dessert = String(itemString.lowercased());
            
            guard let c: Double = cost(of: dessert) else{
                print("\(dessert) not in stock.");
                return;
            }
            print(String(format: "cost of %@ is $%.2f", dessert, c));
            total += c;
            count += 1;
            dessertName = dessert;
            
            if shoppingCart == nil {
                shoppingCart = [String: (numberAlreadyPurchased: Int, prices: Double)]();
            }
            
            if var tuple: (numberAlreadyPurchased: Int, prices: Double) = shoppingCart?[dessert] {
                tuple.numberAlreadyPurchased += 1;
                shoppingCart?[dessert] = (tuple.numberAlreadyPurchased, tuple.prices);
            } else {
                shoppingCart?[dessert] = (1, c); //first time I am buying this food
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
    }
    func cost (of article: String)-> Double?{
        if let tuple:(stock: Int, dessertPrices: Double) = dessertChoices[article],
            tuple.stock > 0 {
            return tuple.dessertPrices
        }
        return nil;
    }
    
    @IBAction func desserPrices(_ sender: UIButton) {
        performSegue(withIdentifier: "price", sender: nil)
    }
    
}

