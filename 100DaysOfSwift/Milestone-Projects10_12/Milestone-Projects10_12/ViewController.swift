//
//  ViewController.swift
//  Milestone-Projects10_12
//
//  Created by Carlos David on 09/05/2020.
//  Copyright © 2020 cdalvaro. All rights reserved.
//

import UIKit

class ViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var images = [CustomImage]()
    
    private var pickerController: UIImagePickerController!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.allowsEditing = true
        
        let defaults = UserDefaults.standard
        if let savedData = defaults.value(forKey: "images") as? Data {
            do {
                images = try JSONDecoder().decode([CustomImage].self, from: savedData)
            } catch {
                debugPrint("Error recovering data from UserDefaults: \(String(describing: error))")
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PictureCell", for: indexPath)
        
        let customImage = images[indexPath.row]
        let image = UIImage(contentsOfFile: getDocumentsDirectory().appendingPathComponent(customImage.name).path)
        
        cell.imageView?.image = image
        cell.textLabel?.text = customImage.caption
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return images.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "DetailedViewController") as? DetailedViewController {
            let selectedImage = images[indexPath.row]
            vc.image = getDocumentsDirectory().appendingPathComponent(selectedImage.name).path
            vc.caption = selectedImage.caption
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else {
            return
        }
        
        let imageName = UUID().uuidString
        let imagePath = getDocumentsDirectory().appendingPathComponent(imageName)
        
        dismiss(animated: true) { [unowned self] in
            let ac = UIAlertController(title: "Set image caption", message: nil, preferredStyle: .alert)
            ac.addTextField()
            
            ac.addAction(UIAlertAction(title: "OK", style: .default, handler: { [unowned self, unowned ac] _ in
                guard let caption = ac.textFields?[0].text else {
                    return
                }
                
                if let jpegData = image.jpegData(compressionQuality: 1.0) {
                    try? jpegData.write(to: imagePath)
                }
                
                self.images.append(.init(name: imageName, caption: caption))
                self.saveData()
                self.tableView.reloadData()
            }))
            
            ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            
            self.present(ac, animated: true)
        }
    }

    @IBAction func addNewImage(_ sender: UIBarButtonItem) {
        let ac = UIAlertController(title: "Add new picture", message: nil, preferredStyle: .actionSheet)
        let sources: [(title: String, source: UIImagePickerController.SourceType)] = [
            ("Take photo", .camera),
            ("Camera roll", .savedPhotosAlbum),
            ("Photo Library", .photoLibrary)
        ]
        
        for source in sources {
            if let action = self.action(for: source.source, title: source.title) {
                ac.addAction(action)
            }
        }
        
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(ac, animated: true)
    }
    
    private func action(for type: UIImagePickerController.SourceType, title: String) -> UIAlertAction? {
        guard UIImagePickerController.isSourceTypeAvailable(type) else {
            return nil
        }
        
        return UIAlertAction(title: title, style: .default) { [unowned self] _ in
            self.pickerController.sourceType = type
            self.present(self.pickerController, animated: true)
        }
    }
    
    private func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths.first!
    }
    
    private func saveData() {
        do {
            let defaults = UserDefaults.standard
            defaults.set(try JSONEncoder().encode(images), forKey: "images")
        } catch {
            debugPrint("Error saving data: \(String(describing: error))")
        }
    }
    
}

