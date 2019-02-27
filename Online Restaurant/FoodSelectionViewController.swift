//
//  FoodSelectionViewController.swift
//  Online Restaurant
//
//  Created by TIEGO Ouedraogo on 2/8/19.
//  Copyright © 2019 TIEGO Ouedraogo. All rights reserved.
//

import UIKit
class FoodSelectionViewController: UIViewController {
    
    var foodArray:[String] = [
        "Asparagus",
        "Burger",
        "Beacon",
        "MeatBall",
        "Salmon",
        "VegieChicken"
    ]
    var foodIndex : Int = 0
    var total: Double = 0.0;
    var foodName: String = "";
    var drinkName: String = "";
    var saladName: String = "";
    var dessertName: String = "";
    var count: Double = 0;
    var FoodsChoices: [ String: (stock: Int, foodPrices: Double)] = [
        
        "Asparagus": (5,12.0),
        "Burger": (5,19.2),
        "Salmon": (5,16.4),
        "MeatBalls":(5,23.1),
        "bacon": (5,2.4),
        "Chicken": (5,13.6)
        
    ]
    var shoppingCart: [String: (numberAlreadyPurchased: Int, price: Double)]? = nil;
    
    @IBOutlet weak var foodImageView: UIImageView!
    
    @IBOutlet var foodButton: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        tabBarItem.badgeValue = "FOOD"
    }
    
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        //segue.destination.navigationItem.title = foodPriceLabel.text
        if let foodPrice : PricesViewController = segue.destination as? PricesViewController{
            foodPrice.total += total;
            foodPrice.count += count;
            foodPrice.foodName = foodName;
            foodPrice.shoppingCart = shoppingCart;
            //print("line 42");
        }else{
            if let drinksPrices: PricesViewController = segue.destination as? PricesViewController {
                drinksPrices.total += total;
                drinksPrices.count += count;
                drinksPrices.drinkName = drinkName;
                drinksPrices.shoppingCart = shoppingCart;
            }else if let saladPrices: PricesViewController = segue.destination as? PricesViewController{
                saladPrices.total += total;
                saladPrices.count += count;
                saladPrices.saladName = saladName;
                saladPrices.shoppingCart = shoppingCart;
            }else if let dessertPrice: PricesViewController = segue.destination as? PricesViewController{
                dessertPrice.total += total;
                dessertPrice.count += count;
                dessertPrice.saladName = saladName;
                dessertPrice.shoppingCart = shoppingCart;
            }
        }
    }
    @IBAction func foodMenuButton(_ sender: UIButton) {
        foodIndex = Int.random(in: 0 ..< foodArray.count)
        foodImageView.image = UIImage(named: foodArray[foodIndex])
    }
    
    @IBAction func foodsButtonPressed(_ sender: UIButton) {
        
        if let itemString = sender.title(for: .normal){
            let foods: String = String(itemString.lowercased());
            
            guard let c: Double = cost(of: foods) else{
                print("\(foods) not in stock.");
                return;
            }
            print(String(format: "cost of %@ is $%.2f", foods, c));
            total += c;
            count += 1;
            
            if shoppingCart == nil {
                shoppingCart = [String: (numberAlreadyPurchased: Int, price: Double)]();
            }
            
            if var tuple: (numberAlreadyPurchased: Int, price: Double) = shoppingCart?[foods] {
                tuple.numberAlreadyPurchased += 1;
                shoppingCart?[foods] = (tuple.numberAlreadyPurchased, tuple.price);
            } else {
                shoppingCart?[foods] = (1, c); //first time I am buying this food
            }
            
            foodName = foods;
        }
    }
    
    func cost (of article: String)-> Double?{
        if let tuple:(stock: Int, foodPrices: Double) = FoodsChoices[article],
            tuple.stock > 0 {
            return tuple.foodPrices
        }
        return nil;
    }
    
    
    
}
