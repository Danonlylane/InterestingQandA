# 趣味问答APP开发报告：

### 1.期望页面：

<img src="https://tva1.sinaimg.cn/large/008i3skNgy1guv0tx171wj60gm0ye75b02.jpg" style="zoom:25%;" />



- 页面分析：最上方使用一个Label，中间是两个button，底下是记录答题数量进度Label和得分Label，最下面是一个条形的进度条
- 然后将所有控件都连接到代码区

### 2.功能分析：

- 先定义一个问题类，将其放在Model层

  ```swift
  class Question {
      let answer: Bool
      let questionText: String
      
      init(text: String, corretAnswer: Bool) {
          questionText = text
          answer = corretAnswer
      }
  }
  ```

- 在Controller层对问题类进行实例化并存储在数组里，题目和答案可以随意发挥,例如

  ```swift
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
  ```

  

- 定义一个全局变量`score`，当用户点击正确的答案是得分+1，点击错误答案得分+0

  - 正确和错误弹框先在Github上找到ProgressHUD，下载这个包，将其下的Sources/ProcessHUD.swift拖进项目，点击Copy items if needed，要不然拖进来的只是一个快捷方式。完成之后就可以在项目中使用其功能了

  ```swift
  func checkAnswer(tag:Int) {
          if tag == 1 {
              if questions[questionsNum].answer == true {                
                	ProgressHUD.showSuccess("答对了")
                  score += 1
                  scoreLabel.text = "总得分：\(score)"
                  
              }else {
                  ProgressHUD.showError("答错了")
              }
          }else {
              if questions[questionsNum].answer == false{
                  ProgressHUD.showSuccess("答对了") //正确弹框
                  score += 1
                  scoreLabel.text = "总得分：\(score)"
              }else {
                  ProgressHUD.showError("答错了") //错误弹框
              }
          }
      }
  ```

  

- UI更新：

  - 下一题：

    ```swift
    func nextQuestion() {
            // 还在数组范围之内继续进行下一题
            if questionsNum < questions.endIndex - 1 {
                questionsNum += 1
                questionLabel.text = questions[questionsNum].questionText
            }else {
                // 最后一道题点击之后重置页面和数据
                print("到底了")
                questionsNum = 0
              	
              
              	// 弹框跳出
                let alert = UIAlertController(title: "漂亮！", message: "你已经完成了所有问题，需要再来一遍吗？", preferredStyle: .alert)
                // 点击弹框触发事件
                alert.addAction(UIAlertAction(title: "再来一遍", style: .default, handler: { _ in
                    self.questionLabel.text = self.questions[0].questionText
                    self.score = 0
                    self.scoreLabel.text = "总得分：\(self.score)"
                    
                }))
                
                present(alert, animated: true, completion: nil)
            }
    ```

    

  - 答题数量进度Label用户每点击一次之后分子就要+1，进度条也要按照`当前题目数量/所有题目数量`增加

    ```swift
    func updateUI() {
            progressLabel.text = "\(questionsNum + 1)/\(questions.endIndex)"
            progressBar.frame.size.width = (view.frame.width / CGFloat(questions.endIndex)) * CGFloat(questionsNum + 1)
        }
    ```

    

  
