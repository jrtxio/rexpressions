#lang racket

;; AI 通信协议处理

;; 解析用户消息中的命令
(define (parse-user-message message)
  (define commands '())
  
  ;; 检查是否包含 @input
  (when (regexp-match? #rx"@input" message)
    (set! commands (cons 'input commands)))
  
  ;; 检查是否包含 @current-regex
  (when (regexp-match? #rx"@current-regex" message)
    (set! commands (cons 'current-regex commands)))
  
  commands)

;; 从 AI 响应中提取正则表达式
(define (extract-regex-from-ai-response response)
  ;; 使用贪婪匹配，匹配到最后一个 }，处理正则表达式中的花括号
  (define regex-pattern #rx"@regex{(.*)}")
  (define match (regexp-match regex-pattern response))
  (if match
      (cadr match)
      #f))

;; 构建 AI 请求上下文
(define (build-ai-request-context message input-text current-regex)
  (define commands (parse-user-message message))
  (define context "")
  
  ;; 添加测试文本
  (when (member 'input commands)
    (set! context (string-append context "测试文本：" input-text "\n")))
  
  ;; 添加当前正则
  (when (member 'current-regex commands)
    (set! context (string-append context "当前正则：" current-regex "\n")))
  
  ;; 如果没有上下文，使用默认提示
  (if (non-empty-string? context)
      (string-append context "\n" message)
      message))

;; 导出函数
(provide parse-user-message extract-regex-from-ai-response build-ai-request-context)