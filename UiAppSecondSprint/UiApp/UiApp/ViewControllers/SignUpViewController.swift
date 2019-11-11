
import UIKit

class SignUpViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        let backButton = UIBarButtonItem()
        backButton.title = "Назад"
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
      
        let regretingLabel = UILabel()
        regretingLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(regretingLabel)
        regretingLabel.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.1).isActive = true
        regretingLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9).isActive = true
        regretingLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -80).isActive = true
        regretingLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        regretingLabel.layoutIfNeeded()
        
        regretingLabel.font = UIFont.systemFont(ofSize: 27.0)
        regretingLabel.textAlignment = .center
        regretingLabel.lineBreakMode = .byWordWrapping
        regretingLabel.numberOfLines = 2
        regretingLabel.text = "Извините данная функция сейчас недоступна."
        
        let registerLabel = UILabel()
        registerLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(registerLabel)
        registerLabel.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.1).isActive = true
        registerLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.65).isActive = true
        registerLabel.topAnchor.constraint(equalTo: regretingLabel.bottomAnchor, constant: 20).isActive = true
        registerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        registerLabel.layoutIfNeeded()
        
        registerLabel.font = UIFont.systemFont(ofSize: 27.0)
        registerLabel.textAlignment = .center
        registerLabel.lineBreakMode = .byWordWrapping
        registerLabel.numberOfLines = 2
        registerLabel.text = "Зарегистрируйтесь через сайт."
        view.addSubview(registerLabel)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
}
