import UIKit

class ViewController: UIViewController {
    
    let questions = [
        Question(text: "马云是中国首富", corretAnswer: true),
        Question(text: "刘强东最早在中关村卖光盘", corretAnswer: true),
        Question(text: "苹果公司是目前世界上最牛逼的科技公司", corretAnswer: true),
        Question(text: "只要坚持下去就能写好代码", corretAnswer: true),
        Question(text: "王思聪是80后", corretAnswer: true),
        Question(text: "在国内可以正常访问谷歌搜索吗", corretAnswer: false),
        Question(text: "敲完一万行代码之后能成为编程高手吗", corretAnswer: true),
        Question(text: "撒贝宁玩过上清华的梗吗", corretAnswer: true),
        Question(text: "你看好吗", corretAnswer: true),
        Question(text: "我帅吗", corretAnswer: true),
        Question(text: "地球比太阳大吗", corretAnswer: false),
        Question(text: "字节跳动改变了世界吗", corretAnswer: true),
        Question(text: "华南师范大学在海南吗", corretAnswer: false),
        Question(text: "人能五天不喝水吗", corretAnswer: false),
        Question(text: "不坚持学习有进步吗", corretAnswer: false)
    ]
    
    
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var progressBar: UIView!
    @IBOutlet weak var progressLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        questionLabel.text = questions[0].questionText
        self.progressLabel.text = "1/\(self.questions.endIndex)"
        
    }
    
    var questionsNum = 0
    var score = 0


    @IBAction func answerPressed(_ sender: UIButton) {
        checkAnswer(tag: sender.tag)
        nextQuestion()
        updateUI()
    }
    
    func updateUI() {
        progressLabel.text = "\(questionsNum + 1)/\(questions.endIndex)"
        progressBar.frame.size.width = (view.frame.width / CGFloat(questions.endIndex)) * CGFloat(questionsNum + 1)
    }
    

    func nextQuestion() {
        // 还在数组范围之内继续进行下一题
        if questionsNum < questions.endIndex - 1 {
            questionsNum += 1
            questionLabel.text = questions[questionsNum].questionText
        }else {
            // 最后一道题点击之后重置页面和数据
            print("到底了")
            questionsNum = 0
            let alert = UIAlertController(title: "漂亮！", message: "你已经完成了所有问题，需要再来一遍吗？", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "再来一遍", style: .default, handler: { _ in
                self.questionLabel.text = self.questions[0].questionText
                self.score = 0
                self.scoreLabel.text = "总得分：\(self.score)"
                
            }))
            
            present(alert, animated: true, completion: nil)
        }
  
    }
    
    
    func checkAnswer(tag:Int) {
        if tag == 1 {
            if questions[questionsNum].answer == true {                ProgressHUD.showSuccess("答对了")
                score += 1
                scoreLabel.text = "总得分：\(score)"
                
            }else {
                ProgressHUD.showError("答错了")
            }
        }else {
            if questions[questionsNum].answer == false{
                ProgressHUD.showSuccess("答对了")
                score += 1
                scoreLabel.text = "总得分：\(score)"
            }else {
                ProgressHUD.showError("答错了")
            }
        }
    }
}
