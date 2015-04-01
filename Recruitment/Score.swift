import UIKit
var favorite = ""


//Code for Favorite Button
class Score: UIButton {
    
    
    //images
    let checkedImage = UIImage(named: "starChecked")
    let unCheckedImage = UIImage(named: "star")
    
    //bool property
    var isChecked:Bool = false{
        didSet{
            if isChecked == true{
                self.setImage(checkedImage, forState: .Normal)
            }else{
                self.setImage(unCheckedImage, forState: .Normal)
            }
        }
    }
    
    override func awakeFromNib() {
        self.addTarget(self, action: "buttonClicked:", forControlEvents: UIControlEvents.TouchUpInside)
        self.isChecked = false
    }
    
    func buttonClicked(sender:UIButton) {
        if(sender == self){
            if isChecked == true {
                isChecked = false
                favorite = "false"
                println(favorite)
            }else{
                isChecked = true
                favorite = "true"
                println(favorite)
            }
        }
    }
}