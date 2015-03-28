import UIKit


//Code for Favorite Button
class Score: UIButton {
    
    
    //images
    let checkedImage = UIImage(named: "fav_selected")
    let unCheckedImage = UIImage(named: "fav_unselected")
    
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
            }else{
                isChecked = true
            }
        }
    }
}