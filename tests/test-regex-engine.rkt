#lang racket

;; 导入测试框架
(require rackunit)

;; 导入要测试的模块
(require "../core/regex-engine.rkt")

;; 测试正则表达式引擎功能
(define regex-engine-tests
  (test-suite
   "正则表达式引擎测试"
   
   ;; 测试有效正则表达式
   (test-case "有效正则表达式验证"
     (check-true (valid-regex? "^\\d+$"))
     (check-true (valid-regex? "[a-zA-Z0-9]+"))
     (check-true (valid-regex? "^\\w+@[a-zA-Z0-9]+\\.[a-zA-Z]{2,}$"))
     (check-true (valid-regex? "^\\d{4}-\\d{2}-\\d{2}$")))
   
   ;; 测试无效正则表达式
   (test-case "无效正则表达式验证"
     (check-false (valid-regex? "[")) ; 缺少闭合括号
     (check-false (valid-regex? "(a|b|c")) ; 缺少闭合括号
     (check-false (valid-regex? "*abc")) ; 量词开头
     (check-false (valid-regex? "+abc")) ; 量词开头
     (check-false (valid-regex? "?abc")) ; 量词开头
     (check-false (valid-regex? "[a-z")) ; 字符类未闭合
     (check-false (valid-regex? "[\\\\")) ; 无效的转义
     )
   
   ;; 测试正则匹配功能
   (test-case "正则匹配功能测试"
     ;; 匹配数字
     (check-equal? (match-regex "\\d+" "abc123def456ghi") '("123" "456"))
     ;; 匹配邮箱
     (check-equal? (match-regex "[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}" 
                    "Email: user@example.com, Support: support@test.org") 
                   '("user@example.com" "support@test.org"))
     ;; 匹配日期
     (check-equal? (match-regex "\\d{4}-\\d{2}-\\d{2}" 
                    "今天是2023-10-05，明天是2023-10-06") 
                   '("2023-10-05" "2023-10-06"))
     ;; 匹配空字符串 - 正则表达式匹配每两个字符之间的空字符串
     (check-not-false (member "" (match-regex "" "test text")))
     ;; 匹配整个字符串
     (check-equal? (match-regex "^test text$" "test text") '("test text"))
     ;; 不匹配
     (check-equal? (match-regex "^\\d+$" "abc") '()))
   
   ;; 测试匹配位置功能
   (test-case "匹配位置功能测试"
     ;; 匹配数字位置
     (check-equal? (match-regex-positions "\\d+" "abc123def456ghi") 
                   '((3 . 6) (9 . 12)))
     ;; 匹配邮箱位置
     (check-equal? (length (match-regex-positions "[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}" 
                    "Email: user@example.com, Support: support@test.org")) 
                   2)
     ;; 匹配整个字符串位置
     (check-equal? (match-regex-positions "^test text$" "test text") 
                   '((0 . 9)))
     ;; 不匹配
     (check-equal? (match-regex-positions "^\\d+$" "abc") '()))
   
   ;; 测试获取错误信息功能
   (test-case "获取正则错误信息测试"
     ;; 无效正则应返回错误信息
     (check-not-false (get-regex-error "["))
     (check-not-false (get-regex-error "(a|b|c"))
     (check-not-false (get-regex-error "[a-z"))
     ;; 有效正则应返回#f
     (check-false (get-regex-error "^\\d+$"))
     (check-false (get-regex-error "[a-zA-Z]+")))
   
   ;; 测试大小写敏感匹配
   (test-case "大小写敏感匹配测试"
     (check-equal? (match-regex "[a-z]+" "abcDEF") '("abc"))
     (check-equal? (match-regex "[A-Z]+" "abcDEF") '("DEF")))
   
   ;; 测试多行模式匹配
   (test-case "多行模式匹配测试"
     (define multi-line-text "123\n456\n789")
     (check-equal? (match-regex "\\d+" multi-line-text) '("123" "456" "789")))
   
   ;; 测试量词功能
   (test-case "量词功能测试"
     ;; 精确匹配
     (check-equal? (match-regex "a{3}" "aaaabbaaaa") '("aaa" "aaa"))
     ;; 范围匹配
     (check-equal? (match-regex "a{2,4}" "aaaabbaaaa") '("aaaa" "aaaa"))
     ;; 至少匹配
     (check-equal? (match-regex "a{2,}" "aaaabbaaaa") '("aaaa" "aaaa"))
     ;; 0或1次匹配
     (check-equal? (match-regex "a?" "aaa") '("a" "a" "a" ""))
     ;; 0或多次匹配
     (check-equal? (match-regex "a*" "aaabbaaa") '("aaa" "" "" "aaa" ""))
     ;; 1或多次匹配
     (check-equal? (match-regex "a+" "aaabbaaa") '("aaa" "aaa"))
     )
   ))

;; 导出测试套件
(provide regex-engine-tests)
