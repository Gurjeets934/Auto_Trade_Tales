import UIKit

class SignupViewController: UIViewController {
    
    // Outlets for the text fields
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var reEnterPasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Additional setup after loading the view.
    }
    
    // Action for the Sign Up button
    @IBAction func signUpButtonTapped(_ sender: UIButton) {
        // Validate the fields are not empty and passwords match
        guard let name = nameTextField.text, !name.isEmpty,
              let lastName = lastNameTextField.text, !lastName.isEmpty,
              let email = emailTextField.text, !email.isEmpty,
              let password = passwordTextField.text, !password.isEmpty,
              let reEnteredPassword = reEnterPasswordTextField.text, !reEnteredPassword.isEmpty else {
            showAlert(message: "Please fill in all fields.")
            return
        }
        
        guard password == reEnteredPassword else {
            showAlert(message: "Passwords do not match.")
            return
        }
        
        // Mock signup logic
        performMockSignup(name: name, lastName: lastName, email: email, password: password)
    }
    
    // Mock signup function
    func performMockSignup(name: String, lastName: String, email: String, password: String) {
        // Here we just print to the console, but you could replace this with actual network request logic.
        print("Mock signup successful for user: \(name) \(lastName)")
        
        // For now, we just dismiss the view controller after 'signing up'
        dismiss(animated: true, completion: nil)
    }
    
    // Helper function to show alerts
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true)
    }
}
