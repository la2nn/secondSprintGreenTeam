
import UIKit

class SettingsViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        let signOutButton = UIButton(type: .system)
        view.addSubview(signOutButton)

        signOutButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(signOutButton)
        signOutButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.15).isActive = true
        signOutButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7).isActive = true
        signOutButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        signOutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        signOutButton.layoutIfNeeded()
        
        signOutButton.addTarget(self, action: #selector(signOutButtonPressed), for: .touchUpInside)
        signOutButton.setTitle("Sign out", for: .normal)
        signOutButton.backgroundColor = #colorLiteral(red: 0.3126351237, green: 0.3320409656, blue: 1, alpha: 0.8470588235)
        signOutButton.tintColor = .white
        signOutButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 28.0)
        signOutButton.layer.cornerRadius = 10
    }
    
    @objc private func signOutButtonPressed() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let rootVC = appDelegate.rootVC
        rootVC.showLoginScreen()
        Singleton.shared.value = 0
        navigationController?.pushViewController(LoginViewController(), animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
        self.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "settings"), tag: 2)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
