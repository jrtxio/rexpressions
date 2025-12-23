#lang racket/gui

(require racket/date)

;; 导入样式模块
(require "styles.rkt")

;; AI 对话面板
(define ai-panel% (class vertical-panel%
  ;; 类成员变量
  (field [chat-text-editor #f])
  (field [chat-text-canvas #f])
  (field [user-input-field #f])
  (field [on-send-message-callback #f])
  
  ;; 初始化
  (super-new [spacing SPACING_COMPONENT]
             [border SPACING_PANEL]
             [stretchable-width #t]
             [stretchable-height #t])
  
  ;; 创建标题
  (new message% [parent this] [label "AI 对话窗口"] [font FONT_TITLE])
  
  ;; 发送消息事件
  (define (on-send-message)
    (define message (send user-input-field get-value))
    (when (non-empty-string? message)
      ;; 清空输入框
      (send user-input-field set-value "")
      
      ;; 添加用户消息
      (append-message "用户" message)
      
      ;; 调用回调
      (when on-send-message-callback
        (on-send-message-callback message))))
  
  ;; 追加消息到对话
  (define/public (append-message sender content)
    (define timestamp (date->string (current-date) "%H:%M:%S"))
    (define formatted-message (format "[~a] ~a: ~a\n\n" timestamp sender content))
    
    ;; 追加到编辑器
    (send chat-text-editor insert formatted-message)
    
    ;; 滚动到底部
    (send chat-text-editor set-position (send chat-text-editor last-position)))
  
  ;; 创建对话消息流编辑器
  (set! chat-text-editor (new text% [auto-wrap #t]))
  (set! chat-text-canvas (new editor-canvas% 
                             [parent this]
                             [label #f]
                             [editor chat-text-editor]
                             [style '(transparent no-hscroll)]
                             [stretchable-width #t]
                             [stretchable-height #t]))
  
  ;; 设置编辑器为只读 - text% 类没有 set-editable 方法，使用其他方式
  (send chat-text-editor set-max-undo-history 0)
  
  ;; 初始欢迎消息
  (append-message "AI" "你好，我可以帮助你编写正则表达式。使用 @input 提供测试文本，或 @current-regex 获取当前正则。")
  
  ;; 创建用户输入区
  (define input-panel (new horizontal-panel% 
                          [parent this]
                          [spacing SPACING_COMPONENT]
                          [stretchable-width #t]
                          [alignment '(center center)]))
  
  ;; 创建用户输入框
  (set! user-input-field (new text-field% 
                             [parent input-panel]
                             [label #f]
                             [init-value ""]
                             [stretchable-width #t]
                             [min-height COMPONENT_HEIGHT]
                             [callback (lambda (widget event) 
                                         (when (eq? (send event get-event-type) 'text-field-enter)
                                           (on-send-message)))]))
  
  ;; 创建发送按钮
  (new button% [parent input-panel]
       [label "发送"]
       [min-width 60]
       [min-height COMPONENT_HEIGHT]
       [callback (lambda (widget event) 
                   (on-send-message))])
  
  ;; 设置发送消息回调
  (define/public (set-on-send-message-callback callback)
    (set! on-send-message-callback callback))
  ))

;; 导出类
(provide ai-panel%)