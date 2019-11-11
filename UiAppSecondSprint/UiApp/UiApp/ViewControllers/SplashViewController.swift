
import UIKit

class SplashViewController: UIViewController {
    
    private let loginButton = UIButton(type: .system)
    private let greetingsLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setLoginButton()
        setGreetingsLabel()
    }
    
    private func setLoginButton() {
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loginButton)
        loginButton.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.1).isActive = true
        loginButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.7).isActive = true
        loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 30).isActive = true
        loginButton.layoutIfNeeded()

        loginButton.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
        loginButton.setTitle("Начать", for: .normal)
        loginButton.backgroundColor = #colorLiteral(red: 0.3126351237, green: 0.3320409656, blue: 1, alpha: 0.8470588235)
        loginButton.tintColor = .white
        loginButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 28.0)
        loginButton.layer.cornerRadius = loginButton.frame.height / 5
        view.addSubview(loginButton)
    }
    
    private func setGreetingsLabel() {
        greetingsLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(greetingsLabel)
        greetingsLabel.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.1).isActive = true
        greetingsLabel.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.9).isActive = true
        greetingsLabel.bottomAnchor.constraint(equalTo: loginButton.topAnchor, constant: -20).isActive = true
        greetingsLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        greetingsLabel.layoutIfNeeded()
        
        greetingsLabel.textColor = .black
        greetingsLabel.font = UIFont.systemFont(ofSize: 35.0)
        greetingsLabel.adjustsFontSizeToFitWidth = true
        greetingsLabel.textAlignment = .center
        greetingsLabel.lineBreakMode = .byTruncatingTail
        greetingsLabel.numberOfLines = 0
        greetingsLabel.text = "Добро пожаловать!"
    }
    
    @objc private func loginButtonPressed() {
        UserDefaults.standard.set(false, forKey: "LOGGED_IN")
        makeServiceCall()
    }
    
    
    private func makeServiceCall() {
        if let appDelegaete = UIApplication.shared.delegate as? AppDelegate {
            if UserDefaults.standard.bool(forKey: "LOGGED_IN") {
                appDelegaete.rootVC.showMainScreen()
            } else {
                appDelegaete.rootVC.showLoginScreen()
            }
        }
    }
}
