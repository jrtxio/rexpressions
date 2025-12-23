#lang racket
(require racket/gui/base)

;; 样式定义模块
;; 统一管理所有界面样式，包括颜色、字体、间距等

;; ==========================
;; 颜色方案
;; ==========================

;; 主色调
(define COLOR_PRIMARY "#1a73e8")
(define COLOR_PRIMARY_LIGHT "#4285f4")
(define COLOR_PRIMARY_DARK "#0d47a1")

;; 辅助色
(define COLOR_SECONDARY "#34a853")
(define COLOR_SECONDARY_LIGHT "#34a853")
(define COLOR_SECONDARY_DARK "#0f9d58")

;; 背景色
(define COLOR_BACKGROUND "#f5f5f5")
(define COLOR_PANEL_BG "#ffffff")
(define COLOR_INPUT_BG "#ffffff")
(define COLOR_LIST_BG "#ffffff")

;; 文本色
(define COLOR_TEXT "#202124")
(define COLOR_TEXT_LIGHT "#5f6368")
(define COLOR_TEXT_DISABLED "#9aa0a6")

;; 边框色
(define COLOR_BORDER "#e0e0e0")
(define COLOR_BORDER_FOCUS "#1a73e8")

;; 高亮色
(define COLOR_HIGHLIGHT "#fff3cd")
(define COLOR_SELECTION "#e8f0fe")

;; 状态色
(define COLOR_SUCCESS "#34a853")
(define COLOR_WARNING "#fbbc05")
(define COLOR_ERROR "#ea4335")

;; ==========================
;; 字体方案
;; ==========================

;; 标题字体
(define FONT_TITLE
  (make-font #:family 'default
             #:size 12
             #:weight 'bold
             #:style 'normal))

;; 正文字体
(define FONT_NORMAL
  (make-font #:family 'default
             #:size 11
             #:weight 'normal
             #:style 'normal))

;; 输入框字体
(define FONT_INPUT
  (make-font #:family 'default
             #:size 11
             #:weight 'normal
             #:style 'normal))

;; 编辑器字体
(define FONT_EDITOR
  (make-font #:family 'modern
             #:size 11
             #:weight 'normal
             #:style 'normal))

;; ==========================
;; 间距规范
;; ==========================

;; 基础间距单位
(define SPACING_BASE 8)

;; 面板间距
(define SPACING_PANEL SPACING_BASE)

;; 组件间距
(define SPACING_COMPONENT (/ SPACING_BASE 2))

;; 边框圆角
(define BORDER_RADIUS 2)

;; 组件高度
(define COMPONENT_HEIGHT 24)

;; 滚动条宽度
(define SCROLLBAR_WIDTH 12)

;; ==========================
;; 组件样式定义
;; ==========================

;; 按钮样式
(define BUTTON_STYLE
  `(background: ,COLOR_PANEL_BG
    border: 1px solid ,COLOR_BORDER
    border-radius: ,BORDER_RADIUS
    padding: 4px 8px
    font: ,FONT_NORMAL))

(define BUTTON_HOVER_STYLE
  `(background: ,COLOR_PRIMARY_LIGHT
    border: 1px solid ,COLOR_PRIMARY
    color: white
    border-radius: ,BORDER_RADIUS
    padding: 4px 8px
    font: ,FONT_NORMAL))

(define BUTTON_CLICKED_STYLE
  `(background: ,COLOR_PRIMARY_DARK
    border: 1px solid ,COLOR_PRIMARY_DARK
    color: white
    border-radius: ,BORDER_RADIUS
    padding: 4px 8px
    font: ,FONT_NORMAL))

;; 输入框样式
(define INPUT_STYLE
  `(background: ,COLOR_INPUT_BG
    border: 1px solid ,COLOR_BORDER
    border-radius: ,BORDER_RADIUS
    padding: 4px 8px
    font: ,FONT_INPUT))

(define INPUT_FOCUS_STYLE
  `(background: ,COLOR_INPUT_BG
    border: 2px solid ,COLOR_BORDER_FOCUS
    border-radius: ,BORDER_RADIUS
    padding: 3px 7px
    font: ,FONT_INPUT
    box-shadow: 0 0 0 2px rgba(26, 115, 232, 0.2))) ;; 轻微阴影

;; 列表框样式
(define LISTBOX_STYLE
  `(background: ,COLOR_LIST_BG
    border: 1px solid ,COLOR_BORDER
    border-radius: ,BORDER_RADIUS
    font: ,FONT_NORMAL))

(define LISTBOX_ITEM_STYLE
  `(background: ,COLOR_LIST_BG
    color: ,COLOR_TEXT
    padding: 4px 8px
    font: ,FONT_NORMAL))

(define LISTBOX_ITEM_HOVER_STYLE
  `(background: ,COLOR_BACKGROUND
    color: ,COLOR_TEXT
    padding: 4px 8px
    font: ,FONT_NORMAL))

(define LISTBOX_ITEM_SELECTED_STYLE
  `(background: ,COLOR_SELECTION
    color: ,COLOR_PRIMARY
    padding: 4px 8px
    font: ,FONT_NORMAL
    font-weight: bold))

;; 编辑器样式
(define EDITOR_STYLE
  `(background: ,COLOR_INPUT_BG
    border: 1px solid ,COLOR_BORDER
    border-radius: ,BORDER_RADIUS
    font: ,FONT_EDITOR))

;; 高亮样式
(define HIGHLIGHT_STYLE
  `(background: ,COLOR_HIGHLIGHT))

;; 默认样式
(define DEFAULT_STYLE
  `())

;; ==========================
;; 面板样式
;; ==========================

(define PANEL_STYLE
  `(background: ,COLOR_PANEL_BG
    border: 1px solid ,COLOR_BORDER
    border-radius: ,BORDER_RADIUS
    padding: ,SPACING_PANEL))

;; ==========================
;; 导出样式定义
;; ==========================

(provide COLOR_PRIMARY COLOR_PRIMARY_LIGHT COLOR_PRIMARY_DARK
         COLOR_SECONDARY COLOR_SECONDARY_LIGHT COLOR_SECONDARY_DARK
         COLOR_BACKGROUND COLOR_PANEL_BG COLOR_INPUT_BG COLOR_LIST_BG
         COLOR_TEXT COLOR_TEXT_LIGHT COLOR_TEXT_DISABLED
         COLOR_BORDER COLOR_BORDER_FOCUS
         COLOR_HIGHLIGHT COLOR_SELECTION
         COLOR_SUCCESS COLOR_WARNING COLOR_ERROR
         
         FONT_TITLE FONT_NORMAL FONT_INPUT FONT_EDITOR
         
         SPACING_BASE SPACING_PANEL SPACING_COMPONENT
         BORDER_RADIUS COMPONENT_HEIGHT SCROLLBAR_WIDTH
         
         BUTTON_STYLE BUTTON_HOVER_STYLE BUTTON_CLICKED_STYLE
         INPUT_STYLE INPUT_FOCUS_STYLE
         LISTBOX_STYLE LISTBOX_ITEM_STYLE LISTBOX_ITEM_HOVER_STYLE LISTBOX_ITEM_SELECTED_STYLE
         EDITOR_STYLE
         HIGHLIGHT_STYLE
         DEFAULT_STYLE
         PANEL_STYLE)
