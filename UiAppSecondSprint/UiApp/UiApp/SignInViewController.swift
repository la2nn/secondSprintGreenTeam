
import UIKit

class SignInViewController: UIViewController {
    
    
    let registerButtom = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        title = "Регистрация"
        setButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.topItem?.hidesBackButton = true
        
        
    }
    
    func setButton() {
        
        registerButtom.frame = CGRect(x: 105, y: 416, width: 204, height: 84)
        registerButtom.addTarget(self, action: #selector(registerButtonPressed), for: .touchUpInside)
        registerButtom.center = view.center
        registerButtom.setTitle("Нажмите на кнопку", for: .normal)
        registerButtom.backgroundColor = #colorLiteral(red: 0.3126351237, green: 0.3320409656, blue: 1, alpha: 0.8470588235)
        registerButtom.tintColor = .white
        registerButtom.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14.0)
        registerButtom.layer.cornerRadius = 10
        view.addSubview(registerButtom)
    }
    
    @objc func registerButtonPressed() {
        
        
        let mainVC = MainViewController()
        let settingVC = SettingsViewController()
        let notesVc = NotesViewController()
        let tapbarController = UITabBarController()
        let loginViewController = UINavigationController()
        

        tapbarController.viewControllers = [mainVC,notesVc,settingVC]
        mainVC.modalTransitionStyle = .flipHorizontal

        loginViewController.viewControllers = [tapbarController]
        navigationController?.pushViewController(tapbarController, animated: true)
    }
   
    

}
