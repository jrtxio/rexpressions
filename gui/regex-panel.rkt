#lang racket/gui

;; 导入核心模块
(require "../core/regex-engine.rkt")

;; 导入样式模块
(require "styles.rkt")

;; 正则测试面板
(define regex-panel% 
  (class vertical-panel%
    ;; 类成员变量
    (field [regex-field #f])
    (field [test-text-editor #f])
    (field [test-text-canvas #f])
    (field [status-label #f])
    (field [basic-style #f])
    (field [highlight-style #f])
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
      (define new-regex (send regex-field get-value))
      (set! current-regex new-regex)
      (update-highlights)
      (when on-regex-changed-callback
        (on-regex-changed-callback new-regex)))
    
    ;; 测试文本变化事件
    (define (on-test-text-changed)
      (define new-text (send test-text-editor get-text))
      (set! current-test-text new-text)
      (when on-test-text-changed-callback
        (on-test-text-changed-callback new-text)))
    
    ;; 更新高亮显示
    (define (update-highlights)
      (define regex-str (send regex-field get-value))
      (define text-str (send test-text-editor get-text))
      (define text-len (send test-text-editor last-position))
      
      ;; 开始编辑序列
      (send test-text-editor begin-edit-sequence)
      
      ;; 清除所有样式 - 恢复到基本样式
      (send test-text-editor change-style basic-style 0 text-len)
      
      ;; 尝试匹配正则表达式并高亮
      (with-handlers ([exn:fail? 
                       (lambda (e)
                         (send status-label set-label 
                               (format "错误: ~a" (exn-message e))))])
        (if (and (non-empty-string? regex-str) (> text-len 0))
            (let* ([regex (pregexp regex-str)]
                   [matches (regexp-match-positions* regex text-str)]
                   [match-count (length matches)])
              
              ;; 对每个匹配应用高亮样式
              (for ([match matches])
                (define start (car match))
                (define end (cdr match))
                (send test-text-editor change-style highlight-style start end))
              
              ;; 更新状态
              (send status-label set-label 
                    (format "匹配数: ~a" match-count))
              
              ;; 调用回调
              (on-test-text-changed))
            (send status-label set-label "匹配数: 0")))
      
      ;; 结束编辑序列
      (send test-text-editor end-edit-sequence))
    
    ;; 创建正则表达式输入区域
    (define regex-input-panel (new horizontal-panel% 
                                  [parent this]
                                  [spacing SPACING_COMPONENT]
                                  [stretchable-height #f]
                                  [alignment '(left center)]))
    
    (new message% 
         [parent regex-input-panel] 
         [label "正则表达式:"]
         [stretchable-width #f])
    
    (set! regex-field (new text-field%
                          [parent regex-input-panel]
                          [label #f]
                          [init-value "[0-9]+"]
                          [stretchable-width #t]
                          [font FONT_INPUT]
                          [min-height COMPONENT_HEIGHT]
                          [callback (lambda (field event)
                                      (on-regex-changed))]))
    
    ;; 创建常用示例按钮区域
    (define examples-panel (new horizontal-panel% 
                               [parent this]
                               [spacing SPACING_COMPONENT]
                               [stretchable-height #f]
                               [alignment '(left center)]))
    
    (new message% 
         [parent examples-panel] 
         [label "常用示例:"]
         [stretchable-width #f])
    
    (new button% 
         [parent examples-panel]
         [label "数字"]
         [font FONT_NORMAL]
         [min-height COMPONENT_HEIGHT]
         [callback (lambda (button event)
                     (send regex-field set-value "[0-9]+")
                     (on-regex-changed))])
    
    (new button% 
         [parent examples-panel]
         [label "英文单词"]
         [font FONT_NORMAL]
         [min-height COMPONENT_HEIGHT]
         [callback (lambda (button event)
                     (send regex-field set-value "[a-zA-Z]+")
                     (on-regex-changed))])
    
    (new button% 
         [parent examples-panel]
         [label "中文"]
         [font FONT_NORMAL]
         [min-height COMPONENT_HEIGHT]
         [callback (lambda (button event)
                     (send regex-field set-value "[\\u4e00-\\u9fff]+")
                     (on-regex-changed))])
    
    (new button% 
         [parent examples-panel]
         [label "空格"]
         [font FONT_NORMAL]
         [min-height COMPONENT_HEIGHT]
         [callback (lambda (button event)
                     (send regex-field set-value " ")
                     (on-regex-changed))])
    
    (new button% 
         [parent examples-panel]
         [label "匹配所有"]
         [font FONT_NORMAL]
         [min-height COMPONENT_HEIGHT]
         [callback (lambda (button event)
                     (send regex-field set-value ".")
                     (on-regex-changed))])
    
    ;; 创建测试文本区域
    (new message% 
         [parent this] 
         [label "测试文本:"]
         [stretchable-height #f])
    
    ;; 创建编辑器
    (set! test-text-editor (new text%))
    
    ;; 设置样式
    (define style-list (send test-text-editor get-style-list))
    (set! basic-style (send style-list find-named-style "Basic"))
    
    ;; 创建高亮样式
    (define highlight-delta (new style-delta%))
    (send highlight-delta set-delta-background "yellow")
    (send highlight-delta set-delta-foreground "red")
    (set! highlight-style 
          (send style-list find-or-create-style basic-style highlight-delta))
    
    ;; 插入默认测试文本
    (send test-text-editor insert "Hello World! 这是测试文本 123 包含数字 456 和 789 以及 abc")
    
    ;; 创建编辑器画布
    (set! test-text-canvas (new editor-canvas% 
                              [parent this]
                              [editor test-text-editor]
                              [style '(transparent)]
                              [stretchable-width #t]
                              [stretchable-height #t]
                              [min-height 200]))
    
    ;; 创建状态信息区域
    (define status-panel (new horizontal-panel% 
                             [parent this]
                             [spacing SPACING_COMPONENT]
                             [stretchable-height #f]
                             [alignment '(left center)]))
    
    (set! status-label (new message% 
                           [parent status-panel]
                           [label "匹配数: 0"]
                           [stretchable-width #f]))
    
    ;; 设置编辑器自动匹配 - 使用定时器检查文本变化
    (define last-text "")
    (define text-change-timer (new timer% 
                                  [notify-callback (lambda ()
                                                    (define current-text (send test-text-editor get-text))
                                                    (unless (equal? current-text last-text)
                                                      (set! last-text current-text)
                                                      (on-test-text-changed)
                                                      (update-highlights)))]
                                  [interval 500]))
    
    ;; 初始更新高亮
    (update-highlights)
    
    ;; 设置正则表达式
    (define/public (set-regex regex)
      (set! current-regex regex)
      (send regex-field set-value regex)
      (update-highlights))
    
    ;; 设置测试文本
    (define/public (set-test-text text)
      (set! current-test-text text)
      (send test-text-editor erase)
      (send test-text-editor insert text)
      (on-test-text-changed)
      (update-highlights))
    
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