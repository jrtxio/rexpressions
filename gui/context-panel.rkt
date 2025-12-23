#lang racket/gui

;; 导入核心模块
(require "../core/context.rkt")
(require "../core/storage.rkt")

;; 导入样式模块
(require "styles.rkt")

;; 上下文列表面板
(define context-panel% (class vertical-panel%
  ;; 类成员变量
  (field [context-list-box #f])
  (field [name-edit-dialog #f])
  (field [name-edit-text-field #f])
  (field [current-selected-ctx #f])
  (field [on-context-selected-callback #f])
  
  ;; 初始化
  (super-new [spacing SPACING_COMPONENT]
             [border SPACING_PANEL]
             [stretchable-width #t]
             [stretchable-height #t])
    
    ;; 创建标题
    (new message% [parent this] [label "上下文列表"] [font FONT_TITLE])
    
    ;; 创建列表框
    (set! context-list-box (new list-box% 
                               [parent this]
                               [label #f]
                               [choices (map (lambda (ctx) 
                                              (if (non-empty-string? (regex-context-name ctx))
                                                  (regex-context-name ctx)
                                                  "(未命名)"))
                                            (get-contexts))]
                               [style '(single vertical-label)]
                               [stretchable-width #t]
                               [stretchable-height #t]
                               [min-height 400]
                               [callback (lambda (widget event) 
                                           (cond
                                             [(eq? (send event get-event-type) 'list-box-dclick)
                                              (on-context-double-click)]
                                             [else
                                              (on-context-selected)]))]))
    
    ;; 创建按钮面板
    (define button-panel (new horizontal-panel% 
                             [parent this]
                             [spacing SPACING_COMPONENT]
                             [alignment '(left center)]
                             [stretchable-width #t]))
    
    ;; 上下文中选择事件
    (define (on-context-selected)
      (define index (send context-list-box get-selection))
      (when (>= index 0)
        (define ctx (list-ref (get-contexts) index))
        (set! current-selected-ctx ctx)
        (when on-context-selected-callback
          (on-context-selected-callback ctx))))
    
    ;; 上下文双击事件（编辑名称）
    (define (on-context-double-click)
      (define index (send context-list-box get-selection))
      (when (>= index 0)
        (define ctx (list-ref (get-contexts) index))
        (show-name-edit-dialog ctx)))
    
    ;; 显示名称编辑对话框
    (define (show-name-edit-dialog ctx)
      ;; 创建对话框
      (set! name-edit-dialog (new dialog% 
                                 [parent this]
                                 [label "编辑上下文名称"]
                                 [width 300]
                                 [height 150]))
      
      ;; 创建垂直面板
      (define dialog-panel (new vertical-panel% 
                               [parent name-edit-dialog]
                               [spacing SPACING_PANEL]
                               [border SPACING_PANEL]))
      
      ;; 创建标签
      (new message% [parent dialog-panel] [label "名称（最多8个汉字）："] [font FONT_NORMAL])
      
      ;; 创建文本输入框
      (set! name-edit-text-field (new text-field% 
                                     [parent dialog-panel]
                                     [label #f]
                                     [init-value (regex-context-name ctx)]
                                     [stretchable-width #t]
                                     [font FONT_INPUT]
                                     [callback (lambda (widget event)
                                                 (when (eq? (send event get-event-type) 'text-field-enter)
                                                   (on-name-edit-ok ctx)))]))
      
      ;; 创建按钮面板
      (define button-panel (new horizontal-panel% 
                               [parent dialog-panel]
                               [spacing SPACING_COMPONENT]
                               [alignment '(right center)]
                               [stretchable-width #t]))
      
      ;; 创建确定按钮
      (new button% [parent button-panel]
           [label "确定"]
           [font FONT_NORMAL]
           [min-width 60]
           [callback (lambda (widget event) 
                       (on-name-edit-ok ctx))])
      
      ;; 创建取消按钮
      (new button% [parent button-panel]
           [label "取消"]
           [font FONT_NORMAL]
           [min-width 60]
           [callback (lambda (widget event) 
                       (send name-edit-dialog show #f))])
      
      ;; 显示对话框
      (send name-edit-dialog show #t))
    
    ;; 名称编辑确定事件
    (define (on-name-edit-ok ctx)
      (define new-name (send name-edit-text-field get-value))
      ;; 限制名称长度为8个汉字
      (define trimmed-name (if (> (string-length new-name) 8) 
                              (substring new-name 0 8) 
                              new-name))
      
      ;; 更新上下文
      (define updated-ctx (set-context-name ctx trimmed-name))
      (update-context-in-storage updated-ctx)
      
      ;; 刷新列表
      (refresh-list)
      
      ;; 关闭对话框
      (send name-edit-dialog show #f)
      
      ;; 更新当前选中的上下文
      (set! current-selected-ctx updated-ctx)
      
      ;; 通知回调
      (when on-context-selected-callback
        (on-context-selected-callback updated-ctx)))
    
    ;; 新增上下文事件
    (define (on-add-context)
      (define new-ctx (create-context))
      (add-context new-ctx)
      (refresh-list)
      ;; 选中新创建的上下文
      (send context-list-box set-selection 0)
      (on-context-selected))
    
    ;; 删除上下文事件
    (define (on-delete-context)
      (define index (send context-list-box get-selection))
      (when (>= index 0)
        (define ctx (list-ref (get-contexts) index))
        (remove-context (regex-context-id ctx))
        (refresh-list)
        ;; 选中新的上下文
        (define new-index (max 0 (- index 1)))
        (when (< new-index (length (get-contexts)))
          (send context-list-box set-selection new-index)
          (on-context-selected))))
    
    ;; 刷新列表
    (define/public (refresh-list)
      (send context-list-box set (map (lambda (ctx) 
                                       (if (non-empty-string? (regex-context-name ctx))
                                           (regex-context-name ctx)
                                           "(未命名)"))
                                     (get-contexts))))
    
    ;; 创建新增按钮
    (new button% [parent button-panel]
         [label "+ 新建"]
         [font FONT_NORMAL]
         [min-width 60]
         [callback (lambda (widget event) 
                     (on-add-context))])
    
    ;; 创建删除按钮
    (new button% [parent button-panel]
         [label "- 删除"]
         [font FONT_NORMAL]
         [min-width 60]
         [callback (lambda (widget event) 
                     (on-delete-context))])
    
    ;; 如果有上下文，默认选中第一个
    (when (>= (length (get-contexts)) 1)
      (send context-list-box set-selection 0)
      (on-context-selected))
    
    ;; 设置上下文选择回调
    (define/public (set-on-context-selected-callback callback)
      (set! on-context-selected-callback callback))
    
    ;; 获取当前选中的上下文
    (define/public (get-current-context)
      current-selected-ctx)
  ))

;; 导出类
(provide context-panel%)