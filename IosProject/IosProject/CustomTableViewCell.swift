import UIKit

class CustomTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var deadlineLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.setupCell()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 8.0, left: 5, bottom: 8, right: 20))
    }
    
    private func setupCell() {
        // 셀의 테두리를 둥글게 설정
        self.contentView.layer.cornerRadius = 10
        self.contentView.layer.masksToBounds = true
        
        // 셀의 배경 색 설정
        //self.contentView.backgroundColor = UIColor.
        
        // 선택 시 강조 효과 제거
        self.selectionStyle = .none
    }
}
