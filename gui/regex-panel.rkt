#lang racket/gui

;; 导入核心模块
(require "../core/regex-engine.rkt")

;; 导入样式模块
(require "styles.rkt")

;; 正则测试面板
(define regex-panel% 
  (class vertical-panel%
    ;; 类成员变量
    (field [regex-text-field #f])
    (field [test-text-editor #f])
    (field [test-text-canvas #f])
    (field [current-regex ""])
    (field [current-test-text ""])
    (field [on-regex-changed-callback #f])
    (field [on-test-text-changed-callback #f])
    
    ;; 初始化
    (super-new 
     [spacing SPACING_COMPONENT]
     [border SPACING_PANEL]
     [stretchable-width #t]
     [stretchable-height #t])
    
    ;; 正则表达式变化事件
    (define (on-regex-changed)
      (define new-regex (send regex-text-field get-value))
      (set! current-regex new-regex)
      (highlight-matches)
      (when on-regex-changed-callback
        (on-regex-changed-callback new-regex)))
    
    ;; 测试文本变化事件 - 简化处理，通过按钮或其他方式触发
    (define (on-test-text-changed)
      (define new-text (send test-text-editor get-text))
      (set! current-test-text new-text)
      (highlight-matches)
      (when on-test-text-changed-callback
        (on-test-text-changed-callback new-text)))
    
    ;; 高亮匹配结果
    (define (highlight-matches)
      (let* ((regex current-regex)
             (text (send test-text-editor get-text)))
        
        ;; 检查正则是否有效
        (if (valid-regex? regex)
            (let* ((match-positions (match-regex-positions regex text))
                   (match-count (length match-positions)))
              
              ;; 输出匹配结果到控制台
              (printf "匹配到 ~a 个结果\n" match-count)
              
              ;; 输出所有匹配结果到控制台
              (for-each (lambda (pos i)
                          (define start (car pos))
                          (define end (cdr pos))
                          (define match (substring text start end))
                          (printf "匹配 ~a: ~a (位置: ~a-~a)\n" i match start end))
                        match-positions
                        (build-list match-count values))
              
              ;; 如果有匹配结果，在编辑器中选择第一个匹配项
              (when (> match-count 0)
                (let ((first-pos (car match-positions)))
                  (let ((start (car first-pos))
                        (end (cdr first-pos)))
                    ;; 使用 set-selection 方法来选择和高亮第一个匹配项
                    (send test-text-editor set-selection start end)
                    ))))
            (printf "无效的正则表达式: ~a\n" regex))))
    
    ;; 创建正则表达式输入区
    (new message% [parent this] [label "正则表达式"] [font FONT_TITLE])
    (set! regex-text-field 
          (new text-field% 
               [parent this]
               [label #f]
               [init-value ""]
               [stretchable-width #t]
               [font FONT_INPUT]
               [min-height COMPONENT_HEIGHT]
               [callback (lambda (widget event) 
                           (on-regex-changed))]))
    
    ;; 创建测试文本区
    (new message% [parent this] [label "测试文本"] [font FONT_TITLE])
    
    ;; 创建编辑器
    (set! test-text-editor (new text%))
    (set! test-text-canvas 
          (new editor-canvas% 
               [parent this]
               [label #f]
               [editor test-text-editor]
               [style '(transparent)]
               [stretchable-width #t]
               [stretchable-height #t]))
    
    ;; 添加一个手动触发匹配的按钮
    (new button% [parent this]
         [label "执行匹配"]
         [font FONT_NORMAL]
         [min-height COMPONENT_HEIGHT]
         [callback (lambda (widget event) 
                     (on-test-text-changed))])
    
    ;; 设置正则表达式
    (define/public (set-regex regex)
      (set! current-regex regex)
      (send regex-text-field set-value regex)
      (highlight-matches))
    
    ;; 设置测试文本
    (define/public (set-test-text text)
      (set! current-test-text text)
      (send test-text-editor erase)
      (send test-text-editor insert text)
      (highlight-matches))
    
    ;; 获取正则表达式
    (define/public (get-regex)
      current-regex)
    
    ;; 获取测试文本
    (define/public (get-test-text)
      current-test-text)
    
    ;; 设置正则变化回调
    (define/public (set-on-regex-changed-callback callback)
      (set! on-regex-changed-callback callback))
    
    ;; 设置测试文本变化回调
    (define/public (set-on-test-text-changed-callback callback)
      (set! on-test-text-changed-callback callback))
    ))

;; 导出类
(provide regex-panel%)