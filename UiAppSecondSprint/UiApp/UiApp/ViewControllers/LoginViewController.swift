
import UIKit

class LoginViewController: UIViewController {
    
    private let signUpButton = UIButton(type: .system)
    private let signInButton = UIButton(type: .system)
    private let imageView = UIImageView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setImageView()
        setSignInButton()
        setSignUpButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    private func setSignUpButton() {
        signUpButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(signUpButton)
        signUpButton.heightAnchor.constraint(equalTo: signInButton.heightAnchor, multiplier: 1).isActive = true
        signUpButton.widthAnchor.constraint(equalTo: signInButton.widthAnchor, multiplier: 1).isActive = true
        signUpButton.topAnchor.constraint(equalTo: signInButton.bottomAnchor, constant: 20).isActive = true
        signUpButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        signUpButton.layoutIfNeeded()
        
        signUpButton.addTarget(self, action: #selector(signUpButtonPressed), for: .touchUpInside)
        signUpButton.setTitle("Sign up", for: .normal)
        signUpButton.backgroundColor = #colorLiteral(red: 0.3126351237, green: 0.3320409656, blue: 1, alpha: 0.8470588235)
        signUpButton.tintColor = .white
        signUpButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 28.0)
        signUpButton.layer.cornerRadius = 10
    }
    
    private func setSignInButton() {
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(signInButton)
        signInButton.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.1).isActive = true
        signInButton.widthAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 1.2).isActive = true
        signInButton.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 30).isActive = true
        signInButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        signInButton.layoutIfNeeded()
        
        signInButton.addTarget(self, action: #selector(signInButtonPressed), for: .touchUpInside)
        signInButton.setTitle("Sign in", for: .normal)
        signInButton.backgroundColor = #colorLiteral(red: 0.3126351237, green: 0.3320409656, blue: 1, alpha: 0.8470588235)
        signInButton.tintColor = .white
        signInButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 28.0)
        signInButton.layer.cornerRadius = 10
    }
    
    private func setImageView() {
        imageView.image = UIImage(named: "swiftLogo")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageView)
        imageView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.3).isActive = true
        imageView.widthAnchor.constraint(equalTo: self.imageView.heightAnchor, multiplier: 1).isActive = true
        imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -90).isActive = true
        imageView.layoutIfNeeded()
    }
    
    @objc private func signInButtonPressed() {
        navigationController?.pushViewController(SignInViewController(), animated: true)
    }
    
    @objc private func signUpButtonPressed() {
        navigationController?.pushViewController(SignUpViewController(), animated: true)
    }

}
