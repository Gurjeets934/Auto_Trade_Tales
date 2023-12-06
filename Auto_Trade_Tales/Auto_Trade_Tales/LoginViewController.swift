import UIKit

class LoginViewController: UIViewController {
    
    // Assuming you have text fields and buttons connected to these outlets
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Any additional setup after loading the view.
    }
    
    // Action for the Sign In button
    @IBAction func signInButtonTapped(_ sender: UIButton) {
        // Get the text from the email and password fields
        guard let email = emailTextField.text, !email.isEmpty,
              let password = passwordTextField.text, !password.isEmpty else {
            // Handle empty fields, alert the user
            showAlert(message: "Please enter both email and password.")
            return
        }
        
        // Perform the mock login check
        if mockLogin(email: email, password: password) {
            // If login is successful, transition to the home view controller
            transitionToHome()
        } else {
            // If login fails, alert the user
            showAlert(message: "Incorrect email or password.")
        }
    }
    
    // Mock login function
    func mockLogin(email: String, password: String) -> Bool {
        // Replace this with your actual authentication logic
        // Here we're just checking if the password is "password" for the example
        var flag = false
        
        if(email == "user@email.com" && password == "password")
        {
           flag = true
        }
        return flag
        
    }
    
    // Function to transition to the home screen
    func transitionToHome() {
        // Replace 'HomeViewController' with the actual class name of your home view controller
        let homeViewController = storyboard?.instantiateViewController(identifier: "HomeViewController") as! HomeViewController
        view.window?.rootViewController = homeViewController
        view.window?.makeKeyAndVisible()
    }
    
    // Helper function to show alerts
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

