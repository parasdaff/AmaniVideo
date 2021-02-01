import UIKit
import AmaniVideo

class ViewController: UIViewController {

    @IBOutlet weak var strtBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.strtBtn.layer.cornerRadius = 10
        self.view.backgroundColor = #colorLiteral(red: 0.1450980392, green: 0.2352941176, blue: 0.3490196078, alpha: 1)
        self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.05882352941, green: 0.1411764706, blue: 0.2078431373, alpha: 1)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func startBtn(_ sender: Any) {
        let amaniSDK = AmaniSDK.sharedInstance
        amaniSDK.set(server: "https://demo.amani.ai",userName: "demo@odeabank.com",password: "123456")
        amaniSDK.showSDK(overParent: self)
    }
}
