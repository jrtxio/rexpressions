#lang racket/gui

;; 导入核心模块
(require "../core/context.rkt")
(require "../core/storage.rkt")
(require "../core/regex-engine.rkt")

;; 导入AI协议模块
(require "../utils/ai-protocol.rkt")

;; 导入面板类
(require "context-panel.rkt")
(require "regex-panel.rkt")
(require "ai-panel.rkt")

;; 导入样式模块
(require "styles.rkt")

;; 主窗口类
(define main-window% 
  (class frame%
    ;; 类成员变量
    (field [context-panel #f])
    (field [regex-panel #f])
    (field [ai-panel #f])
    (field [current-context #f])
    
    ;; 初始化
    (super-new [label "RExpressions"]
               [width 1200]
               [height 600]
               [alignment '(left top)])
    
    ;; 创建三栏布局
    (define h-panel (new horizontal-panel% 
                         [parent this]
                         [spacing SPACING_PANEL]
                         [border SPACING_PANEL]
                         [stretchable-width #t]
                         [stretchable-height #t]
                         [alignment '(left top)]))
    
    ;; === 左侧上下文面板 ===
    ;; 左侧面板：固定宽度，不可拉伸
    (define left-panel (new vertical-panel% 
                          [parent h-panel]
                          [min-width 200]
                          [stretchable-width #f]
                          [stretchable-height #t]
                          [alignment '(left top)]))
    (set! context-panel (new context-panel% 
                            [parent left-panel]))
    
    ;; === 中间正则测试区 ===
    ;; 中间面板：可拉伸，占据大部分空间
    (define center-panel (new vertical-panel% 
                            [parent h-panel]
                            [stretchable-width #t]
                            [stretchable-height #t]
                            [alignment '(left top)]))
    (set! regex-panel (new regex-panel% 
                          [parent center-panel]))
    
    ;; === 右侧 AI 对话窗口 ===
    ;; 右侧面板：固定宽度，不可拉伸
    (define right-panel (new vertical-panel% 
                         [parent h-panel]
                         [min-width 300]
                         [stretchable-width #f]
                         [stretchable-height #t]
                         [alignment '(left top)]))
    (set! ai-panel (new ai-panel% 
                       [parent right-panel]))
    
    ;; 设置上下文选择回调
    (send context-panel set-on-context-selected-callback
          (lambda (ctx)
            (set! current-context ctx)
            (send regex-panel set-regex (regex-context-regex ctx))
            (send regex-panel set-test-text (regex-context-test-text ctx))))
    
    ;; 设置正则变化回调
    (send regex-panel set-on-regex-changed-callback
          (lambda (new-regex)
            (when current-context
              (define updated-ctx (set-context-regex current-context new-regex))
              (update-context-in-storage updated-ctx)
              (set! current-context updated-ctx))))
    
    ;; 设置测试文本变化回调
    (send regex-panel set-on-test-text-changed-callback
          (lambda (new-test-text)
            (when current-context
              (define updated-ctx (set-context-test-text current-context new-test-text))
              (update-context-in-storage updated-ctx)
              (set! current-context updated-ctx))))
    
    ;; 设置AI消息发送回调
    (send ai-panel set-on-send-message-callback
          (lambda (message)
            (handle-ai-message message)))
    
    ;; 处理AI消息
    (define (handle-ai-message message)
      (define input-text (send regex-panel get-test-text))
      (define current-regex (send regex-panel get-regex))
      
      ;; 构建AI请求上下文
      (define ai-context (build-ai-request-context message input-text current-regex))
      
      ;; 这里模拟AI响应，实际项目中会调用真实的AI API
      (define simulated-ai-response (simulate-ai-response message))
      
      ;; 提取正则表达式
      (define extracted-regex (extract-regex-from-ai-response simulated-ai-response))
      
      ;; 如果提取到正则，更新到正则面板
      (when extracted-regex
        (send regex-panel set-regex extracted-regex)
        ;; 如果有当前上下文，也更新到上下文中
        (when current-context
          (define updated-ctx (set-context-regex current-context extracted-regex))
          (update-context-in-storage updated-ctx)
          (set! current-context updated-ctx)))
      
      ;; 显示AI响应
      (send ai-panel append-message "AI" simulated-ai-response))
    
    ;; 模拟AI响应（实际项目中替换为真实AI API调用）
    (define (simulate-ai-response message)
      (cond
        [(regexp-match? #rx"邮箱" message)
         "我为您生成了一个匹配邮箱的正则表达式：@regex{[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}}"]
        [(regexp-match? #rx"手机号" message)
         "我为您生成了一个匹配中国手机号的正则表达式：@regex{1[3-9]\\d{9}}"]
        [(regexp-match? #rx"日期" message)
         "我为您生成了一个匹配YYYY-MM-DD格式日期的正则表达式：@regex{\\d{4}-\\d{2}-\\d{2}}"]
        [(regexp-match? #rx"@input" message)
         (string-append "我已获取到您的测试文本。" 
                       "如果需要我生成正则表达式，请告诉我您想要匹配的内容。")]
        [(regexp-match? #rx"@current-regex" message)
         (string-append "我已获取到您当前的正则表达式。" 
                       "如果需要我优化或修改，请告诉我您的需求。")]
        [else
         "请告诉我您想要匹配的内容，例如邮箱、手机号、日期等，我将为您生成相应的正则表达式。"]))
    ))

;; 导出主窗口类
(provide main-window%)