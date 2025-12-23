#lang racket

;; 正则表达式匹配引擎

;; 测试正则表达式是否有效
(define (valid-regex? regex)
  (with-handlers ([exn:fail? (lambda (e) #f)])
    ;; 使用 pregexp 函数编译正则表达式，支持扩展语法
    (pregexp regex)
    #t))

;; 执行正则匹配，返回匹配结果列表
(define (match-regex regex text)
  (cond
    [(not (valid-regex? regex)) '()]
    [else
     ;; 使用 pregexp 函数编译正则表达式，然后进行匹配
     (regexp-match* (pregexp regex) text #:match-select values)]))

;; 执行正则匹配，返回匹配位置信息
(define (match-regex-positions regex text)
  (cond
    [(not (valid-regex? regex)) '()]
    [else
     ;; 使用 pregexp 函数编译正则表达式，然后获取匹配位置
     (regexp-match-positions* (pregexp regex) text)]))

;; 获取正则表达式错误信息
(define (get-regex-error regex)
  (with-handlers ([exn:fail? (lambda (e) (exn-message e))])
    ;; 使用 pregexp 函数编译正则表达式，捕获错误信息
    (pregexp regex)
    #f))

;; 导出函数
(provide valid-regex? match-regex match-regex-positions get-regex-error)