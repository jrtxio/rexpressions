#lang racket

;; 导入测试框架
(require rackunit)

;; 导入要测试的模块
(require "../core/context.rkt")

;; 测试上下文管理功能
(define context-tests
  (test-suite
   "上下文管理测试"
   
   ;; 测试创建上下文
   (test-case "创建空上下文"
     (define ctx (create-context))
     (check-not-false (regex-context-id ctx))
     (check-equal? (regex-context-name ctx) "")
     (check-equal? (regex-context-regex ctx) "")
     (check-equal? (regex-context-test-text ctx) "")
     (check-not-false (regex-context-created-at ctx))
     (check-not-false (regex-context-updated-at ctx))
     (check-equal? (regex-context-metadata ctx) (hash)))
   
   ;; 测试创建带初始值的上下文
   (test-case "创建带初始值的上下文"
     (define ctx (create-context "测试上下文" "^\\d+$" "12345"))
     (check-not-false (regex-context-id ctx))
     (check-equal? (regex-context-name ctx) "测试上下文")
     (check-equal? (regex-context-regex ctx) "^\\d+$")
     (check-equal? (regex-context-test-text ctx) "12345"))
   
   ;; 测试更新上下文
   (test-case "更新上下文属性"
     (define ctx (create-context "旧名称" "旧正则" "旧文本"))
     (define updated-ctx (update-context ctx #:name "新名称" #:regex "新正则" #:test-text "新文本"))
     (check-equal? (regex-context-name updated-ctx) "新名称")
     (check-equal? (regex-context-regex updated-ctx) "新正则")
     (check-equal? (regex-context-test-text updated-ctx) "新文本"))
   
   ;; 测试部分更新上下文
   (test-case "部分更新上下文属性"
     (define ctx (create-context "旧名称" "旧正则" "旧文本"))
     (define updated-ctx (update-context ctx #:name "新名称"))
     (check-equal? (regex-context-name updated-ctx) "新名称")
     (check-equal? (regex-context-regex updated-ctx) "旧正则")
     (check-equal? (regex-context-test-text updated-ctx) "旧文本"))
   
   ;; 测试设置上下文名称
   (test-case "设置上下文名称"
     (define ctx (create-context))
     (define updated-ctx (set-context-name ctx "新名称"))
     (check-equal? (regex-context-name updated-ctx) "新名称"))
   
   ;; 测试设置上下文正则表达式
   (test-case "设置上下文正则表达式"
     (define ctx (create-context))
     (define updated-ctx (set-context-regex ctx "\\d+"))
     (check-equal? (regex-context-regex updated-ctx) "\\d+"))
   
   ;; 测试设置上下文测试文本
   (test-case "设置上下文测试文本"
     (define ctx (create-context))
     (define updated-ctx (set-context-test-text ctx "测试文本"))
     (check-equal? (regex-context-test-text updated-ctx) "测试文本"))
   
   ;; 测试更新时间戳
   (test-case "更新上下文时更新时间戳"
     (define ctx (create-context))
     (sleep 0.1) ; 等待100毫秒
     (define updated-ctx (update-context ctx #:name "新名称"))
     (check-true (> (regex-context-updated-at updated-ctx) (regex-context-created-at ctx))))
   ))

;; 导出测试套件
(provide context-tests)
