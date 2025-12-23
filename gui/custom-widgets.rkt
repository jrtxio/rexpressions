#lang racket/gui

;; 导入样式模块
(require "styles.rkt")

;; ==========================
;; 自定义按钮类
;; 实现悬停效果和点击反馈
;; ==========================

(define custom-button% 
  (class button%
    (inherit set-label get-label set-background get-background set-font get-font)
    (inherit enabled?)
    
    ;; 初始化
    (super-new)
    
    ;; 保存原始样式
    (field [original-background COLOR_PANEL_BG])
    (field [original-font (get-font)])
    
    ;; 鼠标进入事件 - 悬停效果
    (define/override (on-enter)
      (super on-enter)
      (when (enabled?)
        (send this set-field-background COLOR_PRIMARY_LIGHT)
        (send this set-field-font (make-font #:family 'default
                                             #:size 11
                                             #:weight 'bold
                                             #:style 'normal))))
    
    ;; 鼠标离开事件 - 恢复原始样式
    (define/override (on-leave)
      (super on-leave)
      (when (enabled?)
        (send this set-field-background COLOR_PANEL_BG)
        (send this set-field-font original-font)))
    
    ;; 鼠标按下事件 - 点击效果
    (define/override (on-down)
      (super on-down)
      (when (enabled?)
        (send this set-field-background COLOR_PRIMARY_DARK)
        (send this set-field-font (make-font #:family 'default
                                             #:size 11
                                             #:weight 'bold
                                             #:style 'normal))))
    
    ;; 鼠标释放事件 - 恢复悬停样式
    (define/override (on-up)
      (super on-up)
      (when (enabled?)
        (send this set-field-background COLOR_PRIMARY_LIGHT)
        (send this set-field-font (make-font #:family 'default
                                             #:size 11
                                             #:weight 'bold
                                             #:style 'normal))))
    
    ;; 设置字段背景色
    (define/public (set-field-background color)
      (set-background color))
    
    ;; 设置字段字体
    (define/public (set-field-font font)
      (set-font font))
    
    ;; 重写enable方法，确保样式正确
    (define/override (enable [enable? #t])
      (super enable enable?)
      (if enable?
          (begin
            (set-field-background COLOR_PANEL_BG)
            (set-field-font original-font))
          (begin
            (set-field-background COLOR_BACKGROUND)
            (set-field-font (make-font #:family 'default
                                       #:size 11
                                       #:weight 'normal
                                       #:style 'normal)))))
    ))

;; ==========================
;; 自定义列表框类
;; 实现悬停效果和选中效果
;; ==========================

(define custom-list-box% 
  (class list-box%
    (inherit get-selection get-item-count)
    
    ;; 初始化
    (super-new)
    
    ;; 鼠标移动事件 - 实现悬停效果
    (define/override (on-event event)
      (super on-event event)
      ;; 这里可以添加鼠标移动事件处理，实现悬停效果
      )
    ))

;; ==========================
;; 状态提示类
;; 用于显示临时状态信息
;; ==========================

(define status-bar% 
  (class message%
    ;; 初始化
    (super-new [label "就绪"]
               [font (make-font #:size 10
                              #:weight 'normal
                              #:style 'normal)]
               [auto-resize #t])
    
    ;; 显示状态信息
    (define/public (show-status message [duration 2000])
      (send this set-label message)
      ;; 2秒后恢复就绪状态
      (sleep/yield duration)
      (send this set-label "就绪"))
    
    ;; 显示成功信息
    (define/public (show-success message [duration 2000])
      (send this set-label (format "✓ ~a" message))
      (sleep/yield duration)
      (send this set-label "就绪"))
    
    ;; 显示错误信息
    (define/public (show-error message [duration 3000])
      (send this set-label (format "✗ ~a" message))
      (sleep/yield duration)
      (send this set-label "就绪"))
    ))

;; ==========================
;; 导出自定义组件
;; ==========================

(provide custom-button% custom-list-box% status-bar%)
