import UIKit

// Define your Car struct to model the JSON data
struct Car: Codable {
    let imageJpgUrl: String
    let price: Int
    let make: String
    let model: String
    
    enum CodingKeys: String, CodingKey {
        case imageJpgUrl = "image_jpg_url"
        case price
        case make
        case model
    }
}

class HOMEViewController: UIViewController, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    var cars = [Car]()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        // Assuming that you have set the prototype cell in the storyboard,
        // you don't need to register the cell class here programmatically if you are using storyboard prototype cells.
        loadJsonData()
    }

    private func loadJsonData() {
        guard let path = Bundle.main.path(forResource: "car_data", ofType: "json"),
              let data = try? Data(contentsOf: URL(fileURLWithPath: path)) else {
            fatalError("car_data.json not found")
        }

        do {
            cars = try JSONDecoder().decode([Car].self, from: data)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        } catch {
            print("Error parsing JSON: \(error)")
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cars.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CarCell", for: indexPath)

        // Find an image view and a label by their tags or create them if they don't exist
        let imageView: UIImageView
        let priceLabel: UILabel
        let priceTextView: UILabel
        let makeLabel: UILabel
        let modeLabel: UILabel
        
        if let imgView = cell.viewWithTag(1) as? UIImageView, let lb2 = cell.viewWithTag(2) as? UILabel, let lbl = cell.viewWithTag(3) as? UILabel, let lb3 = cell.viewWithTag(4) as? UILabel, let lb4 = cell.viewWithTag(5) as? UILabel{
            imageView = imgView
            priceLabel = lbl
            priceTextView = lb2
            makeLabel = lb3
            modeLabel = lb4
            
        } else {
            imageView = UIImageView(frame: CGRect(x: 10, y: 10, width: 150, height: 150))
            imageView.contentMode = .scaleAspectFit
            imageView.tag = 1
            cell.contentView.addSubview(imageView)
            
            priceTextView = UILabel(frame: CGRect(x: 200, y: 40, width: cell.contentView.bounds.width - 130, height: 20))
            priceTextView.tag = 2
            cell.contentView.addSubview(priceTextView)
            
            priceLabel = UILabel(frame: CGRect(x: 250, y: 40, width: cell.contentView.bounds.width - 130, height: 20))
            priceLabel.tag = 3
            cell.contentView.addSubview(priceLabel)
            
            makeLabel = UILabel(frame: CGRect(x: 200, y: 70, width: cell.contentView.bounds.width - 130, height: 20))
            makeLabel.tag = 4
            cell.contentView.addSubview(makeLabel)
            
            modeLabel = UILabel(frame: CGRect(x: 200, y: 100, width:
                cell.contentView.bounds.width - 130, height: 20))
            modeLabel.tag = 5
            cell.contentView.addSubview(modeLabel)
        }

        // Configure the cell with the car data
        let car = cars[indexPath.row]
        priceLabel.text = " $\(car.price)"  // Set the price label
        
        priceTextView.text = "Price" // Set the label in front of Price
        makeLabel.text = "Make    \(car.make)"
        modeLabel.text = "Model   \(car.model)"
        
        makeLabel.textColor = .red
        modeLabel.textColor = .blue
        let imageUrl = URL(string: car.imageJpgUrl)  // Directly create a URL from the string
        if let imageUrl = imageUrl {
            loadImage(for: imageView, with: imageUrl)  // Load the image
        }

        
        return cell
    }


    private func loadImage(for imageView: UIImageView?, with url: URL) {
    URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, let image = UIImage(data: data) else {
                print("Error loading image: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            DispatchQueue.main.async {
                imageView?.image = image
            }
        }.resume()
    }
}
