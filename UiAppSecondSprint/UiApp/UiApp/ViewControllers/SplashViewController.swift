
import UIKit

class SplashViewController: UIViewController {
    
    private let loginButton = UIButton(type: .system)
    private let greetingsLabel = UILabel()
    let shapeLayer = CAShapeLayer()
    let trackLayer = CAShapeLayer()
    var pulstingLayer: CAShapeLayer!
  
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setLoginButton()
        setGreetingsLabel()
        setStandartCircle()
        pulstingLayer.isHidden = true
        shapeLayer.isHidden = true
        trackLayer.isHidden = true
        
        
       
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
    
    private func setStandartCircle() {
        
        
        
        let circlePath = UIBezierPath(arcCenter: view.center , radius: 100, startAngle: -CGFloat.pi/2, endAngle: 2 * CGFloat.pi, clockwise: true)
        
        
        let size = CGFloat(1)
        let frame = CGRect(x: view.center.x, y: view.center.y, width: size, height: size)
        pulstingLayer = CAShapeLayer()
        pulstingLayer.path = circlePath.cgPath
        pulstingLayer.bounds = frame
        pulstingLayer.strokeColor = UIColor.clear.cgColor
        pulstingLayer.lineWidth = 10
        pulstingLayer.fillColor = UIColor.pulsatingFillColor.cgColor
        pulstingLayer.frame = CGRect(x: view.center.x - size/2, y: view.center.y - size/2, width: size, height: size)
        pulstingLayer.lineCap = .round
        view.layer.addSublayer(pulstingLayer)
        
        
        trackLayer.path = circlePath.cgPath
        trackLayer.lineWidth = 20
        trackLayer.strokeColor = UIColor.trackStrokeColor.cgColor
        trackLayer.fillColor = UIColor.backGroundColor.cgColor
        trackLayer.frame.origin.x = 1
        trackLayer.frame.origin.y = 1
        view.layer.addSublayer(trackLayer)
        

        animatingLayer()
     
        

        shapeLayer.path = circlePath.cgPath
        view.layer.addSublayer(shapeLayer)
        
        shapeLayer.strokeColor = UIColor.outlineStrokeColor.cgColor
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.frame.origin.x = 1
        shapeLayer.frame.origin.y = 1
        shapeLayer.lineWidth = 20
        shapeLayer.lineCap = .round
        shapeLayer.strokeEnd = 0
        
        
        
    }
    
    private func animatingLayer () {
        let animation = CABasicAnimation(keyPath: "transform.scale")
        animation.duration = 0.8
        animation.repeatCount = Float.infinity
        animation.timingFunction  = CAMediaTimingFunction(name: .easeOut)
        animation.autoreverses = true
        animation.fromValue = 1
        animation.toValue = 1.3
        pulstingLayer.add(animation, forKey: "scale")
    }
    
    private  func startAnimeted() {
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        basicAnimation.toValue = 1
        basicAnimation.duration = 2
        basicAnimation.fillMode = .forwards
        basicAnimation.isRemovedOnCompletion  = false
        shapeLayer.add(basicAnimation, forKey: "urSoBasic")
    }
    
    @objc private func loginButtonPressed() {
        loginButton.isHidden = true
        loginButton.isHidden = true
        greetingsLabel.isHidden = true
        view.backgroundColor = UIColor.backGroundColor
        shapeLayer.isHidden = false
        trackLayer.isHidden = false
        pulstingLayer.isHidden = false
        
        startAnimeted()
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(3)) {
            UserDefaults.standard.set(false, forKey: "LOGGED_IN")
            self.makeServiceCall()
           
        }
//        UserDefaults.standard.set(false, forKey: "LOGGED_IN")
//        makeServiceCall()
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

extension UIColor {
    static func rgb(r: CGFloat, g: CGFloat, b: CGFloat) -> UIColor {
        return UIColor(red: r/255, green: g/255, blue: b/255, alpha: 1)
    }
    
    static let backGroundColor = UIColor.rgb(r: 21, g: 22, b: 33)
    static let outlineStrokeColor = UIColor.rgb(r: 234, g: 46, b: 111)
    static let trackStrokeColor = UIColor.rgb(r: 56, g: 25, b: 49)
    static let pulsatingFillColor = UIColor.rgb(r: 86, g: 30, b: 63)
}
