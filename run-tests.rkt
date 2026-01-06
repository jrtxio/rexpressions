#lang racket

;; 导入测试框架
(require rackunit)
(require rackunit/text-ui)

;; 导入所有测试套件
(require "tests/test-context.rkt")
(require "tests/test-uuid.rkt")
(require "tests/test-regex-engine.rkt")
(require "tests/test-storage.rkt")

;; 组合所有测试套件
(define all-tests
  (test-suite
   "所有测试套件"
   context-tests
   uuid-tests
   regex-engine-tests
   storage-tests))

;; 运行所有测试
(displayln "=== 开始运行测试套件 ===")
(displayln "")

;; 使用 rackunit/text-ui 运行测试
(define test-results (run-tests all-tests))

(displayln "")
(displayln "=== 测试套件运行结束 ===")
(displayln (format "总测试数: ~a" (if (number? test-results) test-results (car test-results))))
(displayln (format "通过测试: ~a" (if (number? test-results) test-results (cadr test-results))))
(displayln (format "失败测试: ~a" (if (number? test-results) 0 (caddr test-results))))
(displayln (format "错误测试: ~a" (if (number? test-results) 0 (cadddr test-results))))

;; 根据测试结果返回不同的退出码
(if (or (number? test-results) (= 0 (caddr test-results) (cadddr test-results)))
    (exit 0)  ; 所有测试通过
    (exit 1))  ; 有测试失败或错误
