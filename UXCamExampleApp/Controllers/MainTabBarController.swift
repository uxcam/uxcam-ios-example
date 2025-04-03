import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewControllers()
    }
    
    private func setupViewControllers() {
        // First tab - Welcome View with Navigation
        let welcomeVC = WelcomeViewController()
        let welcomeNav = UINavigationController(rootViewController: welcomeVC)
        welcomeNav.tabBarItem = UITabBarItem(title: "Welcome", image: UIImage(systemName: "house.fill"), selectedImage: UIImage(systemName: "house.fill"))
        
        // Second tab - Bottom Sheet Demo
        let bottomSheetVC = BottomSheetDemoViewController()
        bottomSheetVC.tabBarItem = UITabBarItem(title: "Bottom Sheet", image: UIImage(systemName: "rectangle.split.2x1"), selectedImage: UIImage(systemName: "rectangle.split.2x1"))
        
        viewControllers = [welcomeNav, bottomSheetVC]
    }
} 
