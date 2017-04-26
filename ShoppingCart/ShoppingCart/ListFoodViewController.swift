//
//  ListFoodViewController.swift
//  EcomercyApp
//
//  Created by Thinh Le Phuc on 4/20/17.
//  Copyright © 2017 Thinh Le Phuc. All rights reserved.
//

import UIKit

class ListFoodViewController: UIViewController {
    @IBOutlet weak var foodTableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var searchBar: UISearchBar!

    var foodList: [Food] = []
    var filterList: [Food] = []
    var isSearched = false
    var numberFoodToShow = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadDataFromAPI()
        configureTableView()
        configureNavigation()
        configureSearch()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Load data from API and load to table view
    func loadDataFromAPI() {
        Util.showActivityIndicator(activityIndicator)
        ProductAPI.getFoodList() {
            result, error in
            guard error == nil, let result = result else {
                // Hidden acitivity indicator when errors occur
                DispatchQueue.main.async {
                    Util.hiddenActivityIndicator(self.activityIndicator)
                }
                return
            }
            // Stored food in list and reload table view to show data
            self.foodList = result
            self.reloadData()
        }
        
    }
    
    // MARK: - Configure table view
    func configureTableView() {
        self.automaticallyAdjustsScrollViewInsets = false
        foodTableView.dataSource = self
        foodTableView.delegate = self
    }
    
    
    // MARK: - Configure navtigation
    func configureNavigation() {
        self.navigationItem.title = "Food"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Profile", style: .done, target: self, action: #selector(self.showProfile))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Your cart", style: .done, target: self, action: #selector(self.showYourCart))
    }
    
    // MARK: - Configure search controller
    func configureSearch() {
        self.searchBar.placeholder = "Search food here..."
        self.searchBar.sizeToFit()
        self.searchBar.delegate = self
        self.searchBar.barTintColor = Constant.Color.main
        self.searchBar.tintColor = UIColor.white
        foodTableView.tableHeaderView = self.searchBar
    }
    
    // MARK: - Reload table view
    func reloadData() {
        DispatchQueue.main.async {
            Util.hiddenActivityIndicator(self.activityIndicator)
            self.foodTableView.reloadData()
        }
    }
    
    // MARK: - Load more data
    func refreshTableView() {
        if numberFoodToShow + 2 > foodList.count {
            return
        }
        numberFoodToShow += 2
        self.foodTableView.reloadData()
       
    }
    
    // MARK: - Lazy load
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y + scrollView.frame.size.height > scrollView.contentSize.height {
            refreshTableView()
        }
    }
    
    
    // MARK: - Push to Show Profile View
    func showProfile() {
        let destination = self.storyboard?.instantiateViewController(withIdentifier: Constant.Identifier.profileViewController)
        self.navigationController?.pushViewController(destination!, animated: true)
    }
    
    // MARK: - Push to Show Profile View
    func showYourCart() {
        let destination = self.storyboard?.instantiateViewController(withIdentifier: Constant.Identifier.cartViewController) as! CartViewController
        destination.foodList = foodList
        self.navigationController?.pushViewController(destination, animated: true)
    }

}

// MARK: - Process for TableViewDataSource
extension ListFoodViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isSearched ? filterList.count : (numberFoodToShow < foodList.count ? numberFoodToShow : foodList.count)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constant.Identifier.foodTableViewCell, for: indexPath) as! FoodTableViewCell
        cell.dataSource = isSearched ? filterList[indexPath.row] : foodList[indexPath.row]
        cell.delegate = self
        return cell
    }
    
}

// MARK: - Process for TableViewDataSource
extension ListFoodViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let destination = self.storyboard?.instantiateViewController(withIdentifier: Constant.Identifier.foodDetailViewController) as! FoodDetailViewController
        let product = isSearched ? filterList[indexPath.row] : foodList[indexPath.row]
        destination.productID = product.productId
        self.navigationController?.pushViewController(destination, animated: true)
        // Deselect row
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - Process for SearchBarDelegate

extension ListFoodViewController: UISearchBarDelegate {
    // MARK: - Process when begin typing something to search
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.searchBar.showsCancelButton = true
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            isSearched = false
        } else {
            isSearched = true
            filterList = foodList.filter({ (food: Food) -> Bool in
                return food.productName.lowercased().range(of: searchText.lowercased()) != nil
            })
        }
        foodTableView.reloadData()
    }
    
    // MARK: - Process when click Cancel button
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearched = false
        searchBar.showsCancelButton = false
        searchBar.text = ""
        searchBar.resignFirstResponder()
        foodTableView.reloadData()
    }
    
  
}

// MARK: - Process for FoodTableViewCell Delegate
extension ListFoodViewController: FoodTableViewCellDelegate {
    func addToCart(productId: Int) {
        // Add item to cart by using its id
        CartItem.addToCart(productId: productId)
        // Show alert
        let alertController = UIAlertController(title: "Message", message: "Add to cart successfully", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
}

