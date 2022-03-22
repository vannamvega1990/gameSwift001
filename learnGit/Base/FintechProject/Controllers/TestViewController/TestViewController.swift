//
//  TestViewController.swift
//  FinTech
//
//  Created by Tu Dao on 5/10/21.
//  Copyright © 2021 vega. All rights reserved.
//

import UIKit
import GoogleSignIn
import FBSDKLoginKit

import AuthenticationServices

class TestViewController: TPBaseViewController, LoginButtonDelegate {
    
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        let token = result?.token?.tokenString
        let request = FBSDKLoginKit.GraphRequest(graphPath: "me", parameters: ["fields": "email, name"], tokenString: token, version: nil, httpMethod: .get)
        request.start { (connection, result, error) in
            print("\(result)")
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        
    }
    //GIDSignInDelegate
    
    @IBOutlet weak var v: BaseView!
    @IBOutlet weak var textField: UITextField!
    
    @IBAction func btnPressed(_ sender: UIButton) {
        print("123")
    }
    
    init() {
        super.init(nibName: "TestViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @IBAction func btnLogin(_ sender: UIButton) {
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let token = AccessToken.current, !token.isExpired {
            let token = token.tokenString
            let request = FBSDKLoginKit.GraphRequest(graphPath: "me", parameters: ["fields": "email, name"], tokenString: token, version: nil, httpMethod: .get)
            request.start { (connection, result, error) in
                print("\(result)")
            }
            
        }else{
            // add facebook button
            let loginButton = FBLoginButton()
            loginButton.delegate = self
            loginButton.permissions = ["public_profile", "email"]
            loginButton.center = view.center
            //view.addSubview(loginButton)
        }
        
        

    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("-----versionApp \(versionApp)")
        showTPToast(typeToast: .info,
                    sms: "radius:min(v.bounds.width2radius:min(v.bounds.width2") {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                self.showTPToast(typeToast: .nomal,
                                 sms: "radius:min(v.bounds.width2radius:min(v.bounds.width2") {
                    print("123")
                }
            }
        }
        //v.drawAnCircle(radius:min(v.bounds.width/2 - 8, v.bounds.height/2 - 8), centerPoint:CGPoint(x: v.bounds.midX, y: v.bounds.midY), lineWidth:16, fillColor:.red,strokeColor: .yellow, settingMark: true)
        //v.drawARectange(roundedRect:v.bounds, cornerRadius:36, lineWidth:6, fillColor:.red, strokeColor: .green, settingMark:true)
        //v.drawARectange(roundedRect:v.bounds, cornerRadius:36, lineWidth:6, fillColor:.clear, strokeColor: .green, settingMark:false)
        //v.backgroundColor = .clear
        v.createDashLine(color: .gray)
        
        
        
        let points = [CGPoint(x: 16, y: 56),CGPoint(x: 16, y: 76),CGPoint(x: 16, y: 96),
        CGPoint(x: 36, y: 56),CGPoint(x: 56, y: 76),CGPoint(x: 76, y: 196),
        CGPoint(x: 96, y: 156),CGPoint(x: 156, y: 276),CGPoint(x: 376, y: 396)]
        //view.drawPoints(points, .orange)
        let _ = view.drawPathViaPoints(points, lineWidth: 1, lineColor: .green)
        let drawAnCircle = view.drawAnCircle(radius: 96, centerPoint: view.center, lineWidth: 6, fillColor: .clear, strokeColor: .orange)
        let _ = view.drawACorner(radius: 76, centerPoint: view.center, lineWidth: 3, fillColor: .green, strokeColor: .orange, startAngle: CGFloat.pi/2, endAngle: 0)
        let _ = view.drawARectange(roundedRect: CGRect(x: 18, y: 167, width: 156, height: 96), cornerRadius: 0, lineWidth: 3, fillColor: .clear, strokeColor: .red)
        let drawATriangle = view.drawATriangle(poit1: CGPoint(x: 0, y: 78), poit2: CGPoint(x: 296, y: 158), poit3: CGPoint(x: 36, y: 156), lineWidth: 3, fillColor: .clear, strokeColor: .green)
        
        let v = UIView(frame: CGRect(x: 156, y: 158, width: 58, height: 58))
        v.backgroundColor = .clear
        addSubViews([v])
        let _ = v.drawAnCircle(radius: v.bounds.height/2, centerPoint: CGPoint(x: v.bounds.width/2, y: v.bounds.height/2), lineWidth: 1, fillColor: .green, strokeColor: .yellow, settingMark: true)
        let _ = v.drawAnCircle(radius: v.bounds.height/2, centerPoint: CGPoint(x: v.bounds.width/2, y: v.bounds.height/2), lineWidth: 3, fillColor: .clear, strokeColor: .red, settingMark: false)
        //v.addScaleAnimation(time: 1, from: 0, to: 1, key: "key001")
        //v.addScaleAnimationKeyFrame(1, [1], [1], true, 1, key: "key001")
        v.moveViewOnThePath(path: drawAnCircle.1, key: "key001")
        
        let v1 = UIView(frame: CGRect(x: 256, y: 198, width: 18, height: 158))
        v1.backgroundColor = .red
        addSubViews([v1])
        let p = [CGPoint(x: v1.bounds.width/2, y: 0), CGPoint(x: v1.bounds.width, y: v1.bounds.height/3),
        CGPoint(x: v1.bounds.width/2, y: v1.bounds.height), CGPoint(x: 0, y: v1.bounds.height/3)]
        v1.drawShapeViaPointsAndMark(p, lineWidth: 1, lineColor: .red, fillColor: .clear, true)
        let v2 = v1.copyView()
        v2.scale(scaleX: 0.5, scaleY: 0.5)
        addSubViews([v2])
        v2.drawShapeViaPointsAndMark(p, lineWidth: 1, lineColor: .red, fillColor: .clear, true)
        v1.rotateAnimation(time: 60)
        v2.rotateAnimation(time: 60*60)
        
        let btn = FTBaseButton()
        btn.borderWidth = 1
        btn.cornerRadius = 3
        btn.borderColor = UIColor(white: 0, alpha: 0.06)
        btn.frame = CGRect(x: 120, y: 60, width: 156, height: 80)
        btn.addTarget(self, action: #selector(xuly), for: .touchUpInside)
        addSubViews([btn])
        
        
        actionGetPhoto = {
            img in
            print(img)
        }
        
        
        
        //appleCustomLoginButton()
        if #available(iOS 13.0, *) {
            let button = ASAuthorizationAppleIDButton()
            button.center = view.center
            //view.addSubview(button)
            button.addTarget(self, action: #selector(handleAppleIdRequest), for: .touchUpInside)
            button.cornerRadius = 10
        } else {
            // Fallback on earlier versions
        }
    }
    
    @objc func xuly(){
        let popview = TestView()
        popview.backgroundColor = .yellow
        showPopup(popupPosition: .any, popView: popview, isAnimation: true)
        popview.translatesAutoresizingMaskIntoConstraints = false
        popview.widthAnchor.constraint(equalToConstant: 356).isActive = true
        popview.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        popview.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -25).isActive = true
        popview.label.text = "Đó là điều chưa từng có trong lịch sử thị trường chứng khoán (TTCK) Việt Nam, giá trị giao dịch chỉ trong phiên buổi sáng đã vượt 20.000 tỷ đồng. Riêng sáng 1/6, giá trị giao dịch trên sàn HSX đã vượt mức 21.700 tỷ đồng Đó là điều chưa từng có trong lịch sử thị trường chứng khoán (TTCK) Việt Nam, giá trị giao dịch chỉ trong phiên buổi sáng đã vượt 20.000 tỷ đồng. Riêng sáng 1/6, giá trị giao dịch trên sàn HSX đã vượt mức 21.700 tỷ đồng"
    }
    
    @available(iOS 13.0, *)
    @objc func handleAppleIdRequest() {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.performRequests()
    }
    
    func appleCustomLoginButton() {
        if #available(iOS 13.0, *) {
            let customAppleLoginBtn = UIButton()
            customAppleLoginBtn.layer.cornerRadius = 20.0
            customAppleLoginBtn.layer.borderWidth = 2.0
            customAppleLoginBtn.backgroundColor = UIColor.white
            customAppleLoginBtn.layer.borderColor = UIColor.black.cgColor
            customAppleLoginBtn.setTitle("Sign in with Apple", for: .normal)
            customAppleLoginBtn.setTitleColor(UIColor.black, for: .normal)
            customAppleLoginBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
            customAppleLoginBtn.setImage(UIImage(named: "apple"), for: .normal)
            customAppleLoginBtn.imageEdgeInsets = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 12)
            customAppleLoginBtn.addTarget(self, action: #selector(handleAppleIdRequest), for: .touchUpInside)
            self.view.addSubview(customAppleLoginBtn)
            // Setup Layout Constraints to be in the center of the screen
            customAppleLoginBtn.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                customAppleLoginBtn.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                customAppleLoginBtn.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 87),
                customAppleLoginBtn.widthAnchor.constraint(equalToConstant: 200),
                customAppleLoginBtn.heightAnchor.constraint(equalToConstant: 40)
                ])
        }
    }
            
}










@IBDesignable
class GradientArcView: UIView {
    @IBInspectable var startColor: UIColor = .white { didSet { setNeedsLayout() } }
    @IBInspectable var endColor:   UIColor = .blue  { didSet { setNeedsLayout() } }
    @IBInspectable var lineWidth:  CGFloat = 3      { didSet { setNeedsLayout() } }

    private let gradientLayer: CAGradientLayer = {
        let gradientLayer = CAGradientLayer()
        gradientLayer.type = .axial
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        return gradientLayer
    }()

    override init(frame: CGRect = .zero) {
        super.init(frame: frame)

        configure()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        configure()
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        updateGradient()
    }
}

private extension GradientArcView {
    func configure() {
        layer.addSublayer(gradientLayer)
    }

    func updateGradient() {
        gradientLayer.frame = bounds
        gradientLayer.colors = [startColor, endColor].map { $0.cgColor }

        let center = CGPoint(x: bounds.midX, y: bounds.midY)
        let radius = (min(bounds.width, bounds.height) - lineWidth) / 2
        let path = UIBezierPath(arcCenter: center, radius: radius, startAngle: 0, endAngle: 2 * .pi, clockwise: true)
        let mask = CAShapeLayer()
        mask.fillColor = UIColor.clear.cgColor
        mask.strokeColor = UIColor.white.cgColor
        mask.lineWidth = lineWidth
        mask.path = path.cgPath
        gradientLayer.mask = mask
    }
}
