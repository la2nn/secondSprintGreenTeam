

import UIKit

class LoginViewController: UIViewController {
    
    let signUpButton = UIButton(type: .system)
    let signInButton = UIButton(type: .system)
    var imageView = UIImageView(frame: CGRect(x: 111, y: 178, width: 204, height: 189))

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setSignInButton()
        setSignUpButton()
        setImageView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }
    
    func setSignUpButton() {
        
        signUpButton.frame = CGRect(x: 111, y: 436, width: 204, height: 63)
        signUpButton.addTarget(self, action: #selector(signUpButtonPressed), for: .touchUpInside)
        signUpButton.center = CGPoint(x: signInButton.center.x, y: signInButton.center.y + 100)
        signUpButton.setTitle("Sign up", for: .normal)
        signUpButton.backgroundColor = #colorLiteral(red: 0.3126351237, green: 0.3320409656, blue: 1, alpha: 0.8470588235)
        signUpButton.tintColor = .white
        signUpButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 28.0)
        signUpButton.layer.cornerRadius = 10
        view.addSubview(signUpButton)
    }
    
    func setSignInButton() {
        
        signInButton.frame = CGRect(x: 111, y: 436, width: 204, height: 63)
        signInButton.addTarget(self, action: #selector(signInButtonPressed), for: .touchUpInside)
        signInButton.center = CGPoint(x: view.center.x, y: view.center.y + 100)
        signInButton.setTitle("Sign in", for: .normal)
        signInButton.backgroundColor = #colorLiteral(red: 0.3126351237, green: 0.3320409656, blue: 1, alpha: 0.8470588235)
        signInButton.tintColor = .white
        signInButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 28.0)
        signInButton.layer.cornerRadius = 10
        view.addSubview(signInButton)
    }
    
    func setImageView() {
        let image = UIImage(named: "swiftLogo")
        imageView.image = image
        imageView.center = CGPoint(x: signInButton.center.x, y: signInButton.center.y - 200)
        view.addSubview(imageView)
        
    }
    
    @objc func signInButtonPressed() {
        navigationController?.pushViewController(SignInViewController(), animated: true)
    }
    
    @objc func signUpButtonPressed() {
        navigationController?.pushViewController(SIgnUpViewController(), animated: true)
        
    }
    
    
    

}
