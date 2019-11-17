
import UIKit

class SignInViewController: UIViewController {
    
    private let registerButtom = UIButton(type: .system)
    
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
    
    private func setButton() {
        registerButtom.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(registerButtom)
        registerButtom.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.15).isActive = true
        registerButtom.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7).isActive = true
        registerButtom.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        registerButtom.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        registerButtom.layoutIfNeeded()
        
        registerButtom.addTarget(self, action: #selector(registerButtonPressed), for: .touchUpInside)
        registerButtom.setTitle("Нажмите на кнопку", for: .normal)
        registerButtom.backgroundColor = #colorLiteral(red: 0.3126351237, green: 0.3320409656, blue: 1, alpha: 0.8470588235)
        registerButtom.tintColor = .white
        registerButtom.titleLabel?.font = UIFont.boldSystemFont(ofSize: 21.0)
        registerButtom.layer.cornerRadius = 10
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
        
        TrelloNetworking.shared.get { (result) in
            if result == true {
                DispatchQueue.main.async {
                    loadingIndicator.stopAnimating()
                    self.navigationController?.pushViewController(tabBarController, animated: true)
                }
            } else {
                print("bad news")
                DispatchQueue.main.async {
                    loadingIndicator.color = .red
                }
            }
        }
    
        
    }
    
}
