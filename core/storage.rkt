#lang racket

;; 导入上下文模块
(require "context.rkt")
(require racket/file)
(require racket/path)

;; 全局变量：上下文列表
(define current-contexts (make-parameter '()))

;; 获取操作系统特定的存储路径
(define (get-storage-path)
  (define app-name "RExpressions")
  (cond
    [(eq? (system-type) 'windows)
     (build-path (getenv "APPDATA") app-name "contexts.rktd")]
    [(eq? (system-type) 'macosx)
     (build-path (find-system-path 'home-dir) "Library" "Application Support" app-name "contexts.rktd")]
    [else ; linux
     (build-path (find-system-path 'home-dir) ".local" "share" app-name "contexts.rktd")]))

;; 初始化存储
(define (initialize-storage)
  (define path (get-storage-path))
  (define dir (path-only path))
  
  ;; 确保目录存在
  (unless (directory-exists? dir)
    (make-directory* dir))
  
  ;; 如果文件存在，加载上下文
  (when (file-exists? path)
    (current-contexts (call-with-input-file path read))))

;; 保存上下文列表
(define (save-contexts)
  (define path (get-storage-path))
  (call-with-output-file path
    (lambda (out)
      (write (current-contexts) out))
    #:exists 'truncate))

;; 添加上下文
(define (add-context ctx)
  (current-contexts (cons ctx (current-contexts)))
  (save-contexts)
  ctx)

;; 删除上下文
(define (remove-context ctx-id)
  (current-contexts (filter (lambda (ctx) (not (equal? (regex-context-id ctx) ctx-id))) (current-contexts)))
  (save-contexts))

;; 更新上下文
(define (update-context-in-storage ctx)
  (current-contexts (map (lambda (c) 
                           (if (equal? (regex-context-id c) (regex-context-id ctx)) 
                               ctx 
                               c)) 
                         (current-contexts)))
  (save-contexts)
  ctx)

;; 获取上下文列表
(define (get-contexts)
  (current-contexts))

;; 根据 ID 获取上下文
(define (get-context-by-id ctx-id)
  (findf (lambda (ctx) (equal? (regex-context-id ctx) ctx-id)) (current-contexts)))

;; 导出函数
(provide initialize-storage save-contexts add-context remove-context update-context-in-storage get-contexts get-context-by-id)