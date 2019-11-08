
import UIKit

class SettingsViewController: UIViewController {
    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let signOutButton = UIButton(type: .system)
        view.backgroundColor = .white
        signOutButton.frame = CGRect(x: 105, y: 416, width: 204, height: 84)
        signOutButton.addTarget(self, action: #selector(signOutButtonPressed), for: .touchUpInside)
        signOutButton.center = view.center
        signOutButton.setTitle("Sign out", for: .normal)
        signOutButton.backgroundColor = #colorLiteral(red: 0.3126351237, green: 0.3320409656, blue: 1, alpha: 0.8470588235)
        signOutButton.tintColor = .white
        signOutButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 28.0)
        signOutButton.layer.cornerRadius = 10
        view.addSubview(signOutButton)
    }
    
    
    
    init() {
        super.init(nibName: nil, bundle: nil)
        self.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "settings"), tag: 2)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func signOutButtonPressed () {
        let rootVC = AppDelegate.shared.rootVC
        rootVC.showLoginScreen()
        navigationController?.pushViewController(LoginViewController(), animated: true)
        Singleton.shared.value = 0
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }

}
