#lang racket

;; 导入测试框架
(require rackunit)

;; 导入要测试的模块
(require "../core/context.rkt")
(require "../core/storage.rkt")

;; 测试存储功能
(define storage-tests
  (test-suite
   "存储功能测试"
   
   ;; 保存原始上下文，用于测试后恢复
   (let ([original-contexts #f])
     
     ;; 在所有测试开始前保存原始上下文
     (test-case "保存原始上下文" 
       (set! original-contexts (get-contexts))
       ;; 清空上下文列表，准备测试
       (current-contexts '())
       (save-contexts))
     
     ;; 测试初始化存储
     (test-case "初始化存储" 
       (define ctx1 (create-context "测试1" "\\d+" "123"))
       (define ctx2 (create-context "测试2" "[a-z]+" "abc"))
       (current-contexts (list ctx1 ctx2))
       (save-contexts)
       ;; 重新初始化存储
       (initialize-storage)
       (check-equal? (length (get-contexts)) 2))
     
     ;; 测试添加上下文
     (test-case "添加上下文" 
       ;; 清空上下文列表
       (current-contexts '())
       (save-contexts)
       (define ctx (create-context "新增上下文" "^test$" "test"))
       (define added-ctx (add-context ctx))
       (check-equal? (length (get-contexts)) 1)
       (check-equal? (regex-context-id added-ctx) (regex-context-id ctx))
       ;; 验证持久化
       (current-contexts '())
       (initialize-storage)
       (check-equal? (length (get-contexts)) 1))
     
     ;; 测试删除上下文
     (test-case "删除上下文" 
       ;; 清空上下文列表
       (current-contexts '())
       (save-contexts)
       (define ctx1 (create-context "上下文1" "\\d+" "123"))
       (define ctx2 (create-context "上下文2" "[a-z]+" "abc"))
       (add-context ctx1)
       (add-context ctx2)
       (check-equal? (length (get-contexts)) 2)
       ;; 删除第一个上下文
       (remove-context (regex-context-id ctx1))
       (check-equal? (length (get-contexts)) 1)
       (check-equal? (regex-context-id (car (get-contexts))) (regex-context-id ctx2))
       ;; 验证持久化
       (current-contexts '())
       (initialize-storage)
       (check-equal? (length (get-contexts)) 1))
     
     ;; 测试更新上下文
     (test-case "更新上下文" 
       ;; 清空上下文列表
       (current-contexts '())
       (save-contexts)
       (define ctx (create-context "旧名称" "旧正则" "旧文本"))
       (add-context ctx)
       (define updated-ctx (update-context ctx #:name "新名称" #:regex "新正则" #:test-text "新文本"))
       (update-context-in-storage updated-ctx)
       (check-equal? (length (get-contexts)) 1)
       (check-equal? (regex-context-name (car (get-contexts))) "新名称")
       (check-equal? (regex-context-regex (car (get-contexts))) "新正则")
       (check-equal? (regex-context-test-text (car (get-contexts))) "新文本")
       ;; 验证持久化
       (current-contexts '())
       (initialize-storage)
       (check-equal? (regex-context-name (car (get-contexts))) "新名称"))
     
     ;; 测试获取上下文列表
     (test-case "获取上下文列表" 
       ;; 清空上下文列表
       (current-contexts '())
       (save-contexts)
       (define ctx1 (create-context "上下文1" "\\d+" "123"))
       (define ctx2 (create-context "上下文2" "[a-z]+" "abc"))
       (define ctx3 (create-context "上下文3" "[A-Z]+" "ABC"))
       (add-context ctx1)
       (add-context ctx2)
       (add-context ctx3)
       (check-equal? (length (get-contexts)) 3)
       ;; 验证顺序：最新添加的在前面
       (check-equal? (regex-context-id (car (get-contexts))) (regex-context-id ctx3))
       (check-equal? (regex-context-id (cadr (get-contexts))) (regex-context-id ctx2))
       (check-equal? (regex-context-id (caddr (get-contexts))) (regex-context-id ctx1)))
     
     ;; 测试根据ID获取上下文
     (test-case "根据ID获取上下文" 
       ;; 清空上下文列表
       (current-contexts '())
       (save-contexts)
       (define ctx1 (create-context "上下文1" "\\d+" "123"))
       (define ctx2 (create-context "上下文2" "[a-z]+" "abc"))
       (add-context ctx1)
       (add-context ctx2)
       (define found-ctx (get-context-by-id (regex-context-id ctx1)))
       (check-not-false found-ctx)
       (check-equal? (regex-context-id found-ctx) (regex-context-id ctx1))
       ;; 测试获取不存在的上下文
       (check-false (get-context-by-id "不存在的ID")))
     
     ;; 测试多次添加和删除
     (test-case "多次添加和删除上下文" 
       ;; 清空上下文列表
       (current-contexts '())
       (save-contexts)
       (define ctx-list (for/list ([i (in-range 10)]) 
                          (create-context (format "上下文~a" i) "\\d+" (number->string i))))
       ;; 批量添加
       (for-each add-context ctx-list)
       (check-equal? (length (get-contexts)) 10)
       ;; 批量删除
       (for-each (lambda (ctx) (remove-context (regex-context-id ctx))) 
                 (take ctx-list 5))
       (check-equal? (length (get-contexts)) 5))
     
     ;; 在所有测试结束后恢复原始上下文
     (test-case "恢复原始上下文" 
       (current-contexts original-contexts)
       (save-contexts)
       (check-equal? (length (get-contexts)) (length original-contexts)))
     )
   ))

;; 导出测试套件
(provide storage-tests)
