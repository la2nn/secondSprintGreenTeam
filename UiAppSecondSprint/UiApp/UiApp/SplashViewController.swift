
import UIKit

class SplashViewController: UIViewController {
    
    private let activityIndecator = UIActivityIndicatorView(style: .whiteLarge)
    let loginButton = UIButton(type: .system)
    let lable = UILabel(frame: CGRect(x: 60 , y: 198, width: 295, height: 188))

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(activityIndecator)
        activityIndecator.frame = view.bounds
        activityIndecator.backgroundColor = UIColor(white: 0, alpha: 0.4)
        
        setButton()
        setLable()
    }
    
    func setButton() {
        
        loginButton.frame = CGRect(x: 105, y: 416, width: 204, height: 84)
        loginButton.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
        loginButton.center = CGPoint(x: view.center.x, y: view.center.y + 50)
        loginButton.setTitle("Начать", for: .normal)
        loginButton.backgroundColor = #colorLiteral(red: 0.3126351237, green: 0.3320409656, blue: 1, alpha: 0.8470588235)
        loginButton.tintColor = .white
        loginButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 28.0)
        loginButton.layer.cornerRadius = 10
        view.addSubview(loginButton)
    }
    
    func setLable() {
        
        lable.font = UIFont.systemFont(ofSize: 35.0)
        lable.textAlignment = .center
        lable.lineBreakMode = .byWordWrapping
        lable.numberOfLines = 2
        lable.text = "Добро\nпожаловать!"
        lable.center = CGPoint(x: loginButton.center.x , y: loginButton.center.y - 150)
        view.addSubview(lable)
    }
    
    
    
    @objc func loginButtonPressed () {
         UserDefaults.standard.set(true, forKey: "LOGGED_IN")
         makeServiceCall()
        
    }
    
    
    private func makeServiceCall() {
        activityIndecator.startAnimating()
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(1)) {
            self.activityIndecator.stopAnimating()
            
            if !UserDefaults.standard.bool(forKey: "LOGGED_IN") {
                let rootVc =  AppDelegate.shared.rootVC
                rootVc.showLoginScreen()
            } else {
                let rootVc =  AppDelegate.shared.rootVC
                rootVc.showMainScreen()
                self.navigationController?.pushViewController(NotesViewController(), animated: true)
                
            }
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
