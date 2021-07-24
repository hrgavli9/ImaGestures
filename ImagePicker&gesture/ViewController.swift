//
//  ViewController.swift
//  ImagePicker&gesture
//
//  Created by Dipak on 02/05/1943 Saka.
//

import UIKit

class ViewController: UIViewController {

    private let myView:UIImageView = {
        let imgview=UIImageView()
        imgview.contentMode = .scaleAspectFill
        imgview.layer.cornerRadius = 40
        imgview.clipsToBounds = true
        imgview.backgroundColor = .gray
        imgview.frame = CGRect(x: 50, y: 200, width: 300, height: 300)
        return imgview
    }()
    
    private let mylabel:UILabel = {
        let lb=UILabel()
//        lb.text="helo"
        lb.backgroundColor = .purple
        lb.textColor = .white
        lb.textAlignment = .center
        lb.font = .boldSystemFont(ofSize: 20.0)
        lb.frame = CGRect(x: 10, y: 80, width: 400, height: 50)
        return lb
    }()

    private var myimagepickerview:UIImagePickerController =
    {
       let imgpicker = UIImagePickerController()
        imgpicker.allowsEditing = false
        return imgpicker
    }();

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(myView)
        view.addSubview(mylabel)
        myimagepickerview.delegate = self
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(TapView))
        tapGesture.numberOfTapsRequired = 1
        tapGesture.numberOfTouchesRequired = 1
        view.addGestureRecognizer(tapGesture)
        
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(PinchView))
        view.addGestureRecognizer(pinchGesture)
        
        let rotationGesture = UIRotationGestureRecognizer(target: self, action: #selector(RotateView))
        view.addGestureRecognizer(rotationGesture)
        
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(SwipeView))
        leftSwipe.direction = .left
        view.addGestureRecognizer(leftSwipe)
        
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(SwipeView))
        rightSwipe.direction = .right
        view.addGestureRecognizer(rightSwipe)
        
        let upSwipe = UISwipeGestureRecognizer(target: self, action: #selector(SwipeView))
        upSwipe.direction = .up
        view.addGestureRecognizer(upSwipe)
        
        let downSwipe = UISwipeGestureRecognizer(target: self, action: #selector(SwipeView))
        downSwipe.direction = .down
        view.addGestureRecognizer(downSwipe)
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(PanView))
        view.addGestureRecognizer(panGesture)
    }
}

extension ViewController:UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    @objc private func TapView(_ gesture:UITapGestureRecognizer) {
//        print("Tapped at location: \(gesture.location(in: view))")
        myimagepickerview.sourceType = .photoLibrary
        DispatchQueue.main.async {
            self.present(self.myimagepickerview, animated: true)
        }
        mylabel.text = "Tap view is using"
        
    }
    
    @objc private func PinchView(_ gesture:UIPinchGestureRecognizer) {
        myView.transform = CGAffineTransform(scaleX: gesture.scale, y: gesture.scale)
        mylabel.text = "Pinch view is using"
    }
    
    @objc private func RotateView(_ gesture:UIRotationGestureRecognizer) {
        myView.transform = CGAffineTransform(rotationAngle: gesture.rotation)
        mylabel.text = "Rotate view is using"
    }
    
    @objc private func SwipeView(_ gesture:UISwipeGestureRecognizer) {
        if gesture.direction == .left {
            UIView.animate(withDuration: 0.2) {
                self.myView.frame = CGRect(x: self.myView.frame.origin.x - 40, y: self.myView.frame.origin.y, width: 200, height: 200)
            }
            mylabel.text = "Swipe left view is using"
        } else if gesture.direction == .right {
            UIView.animate(withDuration: 0.2) {
                self.myView.frame = CGRect(x: self.myView.frame.origin.x + 40, y: self.myView.frame.origin.y, width: 200, height: 200)
            }
            mylabel.text = "Swipe right view is using"
        } else if gesture.direction == .up {
            UIView.animate(withDuration: 0.2) {
                self.myView.frame = CGRect(x: self.myView.frame.origin.x, y: self.myView.frame.origin.y - 40, width: 200, height: 200)
            }
            mylabel.text = "Swipe up view is using"
            
        } else if gesture.direction == .down {
            UIView.animate(withDuration: 0.2) {
                self.myView.frame = CGRect(x: self.myView.frame.origin.x, y: self.myView.frame.origin.y + 40, width: 200, height: 200)
            }
            mylabel.text = "Swipe down view is using"
        } else {
            print("No direction to swipe")
        }
    }
    
    @objc private func PanView(_ gesture:UIPanGestureRecognizer) {
        let x = gesture.location(in: view).x
        let y = gesture.location(in: view).y
        mylabel.text = "Pan view is using"
        myView.center = CGPoint(x: x, y: y)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let selectedimg = info[.originalImage] as? UIImage
        {
            myView.image = selectedimg
        }
        picker.dismiss(animated: true)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}



