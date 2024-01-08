//
//  HomeViewController.swift
//  BiteSight
//
//  Created by Jacqueline Guo on 11/20/23.
//

import UIKit

class LandingViewController: UITabBarController, UITabBarControllerDelegate {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Logout", // You can set your desired title
            style: .plain,
            target: self,
            action: #selector(leftBarButtonItemTapped)
        )
        self.navigationItem.setHidesBackButton(true, animated: true)
    }
    
    @objc func leftBarButtonItemTapped() {
        let logoutAlert = UIAlertController(title: "Logging out!", message: "Are you sure want to log out?", preferredStyle: .actionSheet)
        logoutAlert.addAction(UIAlertAction(title: "Yes, log out!", style: .default, handler: {(_) in
                do{
                    Validation.defaults.removeObject(forKey: "auth")
                    self.navigationController?.popViewController(animated: true)
                }catch{
                    print("Error occured!")
                }
            })
        )
        logoutAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        self.present(logoutAlert, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //MARK: setting up red tab bar...
        let tabHome = UINavigationController(rootViewController: HomeViewController())
        let tabHomeBarItem = UITabBarItem(
            title: "Home",
            image: UIImage(systemName: "house"),
            selectedImage: UIImage(systemName: "house.fill")
        )
        tabHome.tabBarItem = tabHomeBarItem
        
        //MARK: setting up green tab bar...
        let tabExplore = UINavigationController(rootViewController: ExploreViewController())
        let tabExploreBarItem = UITabBarItem(
            title: "Restaurants Near By",
            image: UIImage(systemName: "safari"),
            selectedImage: UIImage(systemName: "safari.fill")
        )
        tabExplore.tabBarItem = tabExploreBarItem
        
        //MARK: setting up blue tab bar...
        let tabFavorite = UINavigationController(rootViewController: FavoriteViewController())
        let tabFavoriteBarItem = UITabBarItem(
            title: "Favorite",
            image: UIImage(systemName: "heart"),
            selectedImage: UIImage(systemName: "heart.fill")
        )
        tabFavorite.tabBarItem = tabFavoriteBarItem
        
        let tabProfile = UINavigationController(rootViewController: ProfileViewController())
        let tabProfileBarItem = UITabBarItem(
            title: "Me",
            image: UIImage(systemName: "person"),
            selectedImage: UIImage(systemName: "person.circle")
        )
        tabProfile.tabBarItem = tabProfileBarItem
        
        //MARK: setting up this view controller as the Tab Bar Controller...
        self.viewControllers = [tabHome, tabExplore, tabFavorite, tabProfile]
    }
}
