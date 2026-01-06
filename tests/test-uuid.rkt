#lang racket

;; 导入测试框架
(require rackunit)

;; 导入要测试的模块
(require "../utils/uuid.rkt")

;; 测试UUID生成功能
(define uuid-tests
  (test-suite
   "UUID生成测试"
   
   ;; 测试UUID格式是否符合要求
   (test-case "UUID格式验证"
     (define uuid (generate-uuid))
     ;; 简单验证UUID格式：8-4-4-4-12，不区分大小写
     (check-regexp-match #px"^[0-9a-f-]{36}$" uuid)
     ;; 验证第13位是4（UUID v4版本标识）
     (check-equal? (string-ref uuid 14) #\4))
   
   ;; 测试生成多个UUID的唯一性
   (test-case "UUID唯一性验证"
     (define uuid-list (for/list ([i (in-range 100)]) (generate-uuid)))
     ;; 使用set去重后长度应与原列表相同
     (check-equal? (length uuid-list) (length (remove-duplicates uuid-list))))
   
   ;; 测试UUID字符长度
   (test-case "UUID字符长度验证"
     (define uuid (generate-uuid))
     ;; UUID v4标准长度为36个字符
     (check-equal? (string-length uuid) 36))
   
   ;; 测试UUID版本标识
   (test-case "UUID版本标识验证"
     (define uuid (generate-uuid))
     ;; 第13位必须是4，表示UUID v4
     (check-equal? (string-ref uuid 14) #\4))
   
   ;; 测试UUID变体标识
   (test-case "UUID变体标识验证"
     (define uuid (generate-uuid))
     ;; 第17位必须是8、9、a或b
     (define variant-char (string-ref uuid 19))
     (check-pred (lambda (c) (member c '(#\8 #\9 #\a #\b))) variant-char))
   ))

;; 导出测试套件
(provide uuid-tests)
