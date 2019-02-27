//
//  SaladViewController.swift
//  Online Restaurant
//
//  Created by TIEGO Ouedraogo on 2/8/19.
//  Copyright © 2019 TIEGO Ouedraogo. All rights reserved.
//

import UIKit

class SaladViewController: UIViewController {
    
    var saladArray: [String] = [
        "Arugula",
        "CesarSalad",
        "PastaSalad",
        "Tomato",
        "MixGreen"
    ]
    var saladIndex: Int = 0
    
    var total: Double = 0.0;
    var count: Double = 0;
    var saladName: String = "";  
    
    var shoppingCart: [String: (numberAlreadyPurchased: Int, prices: Double)]? = nil;
    
    var saladChoices: [String: (stock: Int, drinksPrices: Double)] = [
        "Arugula": (10, 44.0),
        "Tomato": (10, 28.0),
        "PastaSalad": (10, 12.0),
        "CesarSalad": (10, 19.99),
        "MixGreen": (10, 23.0),
    ]

    @IBOutlet weak var saladImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarItem.badgeValue = "Salad"

        // Do any additional setup after loading the view.
    }
    
    @IBAction func saladButton(_ sender: UIButton) {
        saladIndex = Int.random(in: 0 ..< saladArray.count)
        saladImageView.image = UIImage(named: saladArray[saladIndex ])
    }
    
    @IBAction func saladMenuButtons(_ sender: UIButton) {
        
        if let itemString = sender.title(for: .normal){
            let salads = String(itemString.lowercased());
            
            guard let c: Double = cost(of: salads) else{
                print("\(salads) not in stock.");
                return;
            }
            print(String(format: "cost of %@ is $%.2f", salads, c));
            total += c;
            count += 1;
            saladName = salads;
            
            if shoppingCart == nil {
                shoppingCart = [String: (numberAlreadyPurchased: Int, prices: Double)]();
            }
            
            if var tuple: (numberAlreadyPurchased: Int, prices: Double) = shoppingCart?[salads] {
                tuple.numberAlreadyPurchased += 1;
                shoppingCart?[salads] = (tuple.numberAlreadyPurchased, tuple.prices);
            } else {
                shoppingCart?[salads] = (1, c); //first time I am buying this food
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
    }
    func cost (of article: String)-> Double?{
        if let tuple:(stock: Int, drinksPrices: Double) = saladChoices[article],
            tuple.stock > 0 {
            return tuple.drinksPrices
        }
        return nil;
    }
    
    @IBAction func pricesButton(_ sender: UIButton) {
        performSegue(withIdentifier: "price", sender: nil)
    }
    
}
