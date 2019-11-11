import UIKit

class RootViewController: UIViewController {
  
    private var current: UIViewController = SplashViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addChild(current)
        current.view.frame = view.bounds
        view.addSubview(current.view)
        current.didMove(toParent: self)
        view.backgroundColor = .blue
    }
    
    func showLoginScreen() {
        let new = UINavigationController(rootViewController: LoginViewController())
        new.modalPresentationStyle = .fullScreen
        addChild(new)
        new.view.frame = view.bounds
        view.addSubview(new.view)
        new.didMove(toParent: self)
        current.willMove(toParent: nil)
        current.view.removeFromSuperview()
        current.removeFromParent()
        current = new
    }
    
    func showMainScreen() {
        let loginViewController = UINavigationController(rootViewController: LoginViewController())
        let mainVC = MainViewController()
        let settingVC = SettingsViewController()
        let notesVC = NotesViewController()
        let tabBarController = UITabBarController()
        
        tabBarController.viewControllers = [mainVC, notesVC, settingVC]
        mainVC.modalTransitionStyle = .flipHorizontal
        loginViewController.viewControllers = [tabBarController]
        loginViewController.modalPresentationStyle = .fullScreen
        tabBarController.modalPresentationStyle = .fullScreen
        
        addChild(loginViewController)
        loginViewController.view.frame = view.bounds
        view.addSubview(loginViewController.view)
        loginViewController.didMove(toParent: self)
        loginViewController.willMove(toParent: nil)
        current.view.removeFromSuperview()
        current.removeFromParent()
        current = loginViewController
    }

}

