#lang racket

;; 导入 UUID 生成工具
(require "../utils/uuid.rkt")

;; 定义上下文结构体
(struct regex-context (
  id          ; UUID v4
  name        ; 名称，≤8 字中文
  regex       ; 正则表达式
  test-text   ; 测试文本
  created-at  ; 创建时间戳
  updated-at  ; 更新时间戳
  metadata    ; 元数据（哈希表）
) #:prefab)    ; 支持序列化

;; 创建新上下文
(define (create-context [name ""] [regex ""] [test-text ""])
  (define now (current-inexact-milliseconds))
  (regex-context
   (generate-uuid)    ; 生成 UUID
   name               ; 初始名称
   regex              ; 初始正则表达式
   test-text          ; 初始测试文本
   now                ; 创建时间
   now                ; 更新时间
   (hash)))           ; 初始元数据

;; 更新上下文
(define (update-context ctx #:name [name #f] #:regex [regex #f] #:test-text [test-text #f] #:metadata [metadata #f])
  (regex-context
   (regex-context-id ctx)
   (if name name (regex-context-name ctx))
   (if regex regex (regex-context-regex ctx))
   (if test-text test-text (regex-context-test-text ctx))
   (regex-context-created-at ctx)
   (current-inexact-milliseconds)
   (if metadata metadata (regex-context-metadata ctx))))

;; 设置上下文名称
(define (set-context-name ctx name)
  (update-context ctx #:name name))

;; 设置上下文正则表达式
(define (set-context-regex ctx regex)
  (update-context ctx #:regex regex))

;; 设置上下文测试文本
(define (set-context-test-text ctx test-text)
  (update-context ctx #:test-text test-text))

;; 导出结构体和函数
(provide (struct-out regex-context))
(provide create-context update-context set-context-name set-context-regex set-context-test-text)