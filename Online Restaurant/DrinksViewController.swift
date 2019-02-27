//
//  DrinksViewController.swift
//  Online Restaurant
//
//  Created by TIEGO Ouedraogo on 2/8/19.
//  Copyright © 2019 TIEGO Ouedraogo. All rights reserved.
//

import UIKit

class DrinksViewController: UIViewController {
    
    var drinksArray: [String] = [
        "1792",
        "Baileys",
        "Boudon",
        "Classics",
        "FireBall",
        "GrandMarinier",
        "KnobGreek",
        "Rumble",
        "Scotch"
    ]
    var drinksIndex: Int = 0
    var total: Double = 0.0;
    var count: Double = 0;
    var drinkName: String = "";
    
    var shoppingCart: [String: (numberAlreadyPurchased: Int, prices: Double)]? = nil;

    var drinksChoices: [String: (stock: Int, drinksPrices: Double)] = [
        "1792": (10, 44.0),
        "Baileys": (10, 28.0),
        "Boudon": (10, 12.0),
        "Classics": (10, 19.99),
        "FireBall": (10, 23.0),
        "GrandMarinier": (10, 18.0),
        "KnobGreek": (10, 32.0),
        "Rumble": (10, 21.99),
        "Scotch": (10, 43.99)
        ]
    @IBOutlet weak var drinksImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarItem.badgeValue = "Drinks"

        // Do any additional setup after loading the view.
    }
    
    @IBAction func drinkButton(_ sender: UIButton) {
        drinksIndex = Int.random(in: 0 ..< drinksArray.count)
        drinksImageView.image = UIImage(named: drinksArray[drinksIndex])
    }
    
     @IBAction func drinksChoicesButtons(_ sender: UIButton) {
        
        if let itemString = sender.title(for: .normal){
            let drinks = String(itemString.lowercased());
            
            guard let c: Double = cost(of: drinks) else{
                print("\(drinks) not in stock.");
                return;
            }
            print(String(format: "cost of %@ is $%.2f", drinks, c));
            total += c;
            count += 1;
            drinkName = drinks;
            
            if shoppingCart == nil {
                shoppingCart = [String: (numberAlreadyPurchased: Int, prices: Double)]();
            }
            
            if var tuple: (numberAlreadyPurchased: Int, prices: Double) = shoppingCart?[drinks] {
                tuple.numberAlreadyPurchased += 1;
                shoppingCart?[drinks] = (tuple.numberAlreadyPurchased, tuple.prices);
            } else {
                shoppingCart?[drinks] = (1, c); //first time I am buying this food
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        
    }
    func cost (of article: String)-> Double?{
        if let tuple:(stock: Int, drinksPrices: Double) = drinksChoices[article],
            tuple.stock > 0 {
            return tuple.drinksPrices
        }
        return nil;
    }

}
