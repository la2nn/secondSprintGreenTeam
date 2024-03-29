
import UIKit

class SignInViewController: UIViewController {
    
    let registerButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Регистрация"
        setButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.topItem?.hidesBackButton = true
    }
    
    func setButton() {
        registerButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(registerButton)
        registerButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.15).isActive = true
        registerButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7).isActive = true
        registerButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        registerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        registerButton.layoutIfNeeded()
        
        registerButton.addTarget(self, action: #selector(registerButtonPressed), for: .touchUpInside)
        registerButton.setTitle("Нажмите на кнопку", for: .normal)
        registerButton.backgroundColor = #colorLiteral(red: 0.3126351237, green: 0.3320409656, blue: 1, alpha: 0.8470588235)
        registerButton.tintColor = .white
        registerButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 21.0)
        registerButton.layer.cornerRadius = 10
    }
    
    @objc private func registerButtonPressed() {
        let mainVC = MainViewController()
        let settingVC = SettingsViewController()
        let notesVC = NotesViewController()
        let tabBarController = UITabBarController()
       
        tabBarController.modalPresentationStyle = .fullScreen
        tabBarController.viewControllers = [mainVC, notesVC, settingVC]
        mainVC.modalTransitionStyle = .flipHorizontal
        
        /* тут должна быть анимация загрузки */
        
        let loadingIndicator = UIActivityIndicatorView(style: .gray)
        view.addSubview(loadingIndicator)
        loadingIndicator.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        loadingIndicator.center = view.center
        loadingIndicator.startAnimating()
    }
}
