#lang racket/gui

;; 导入核心模块
(require "core/storage.rkt")

;; 导入 GUI 模块
(require "gui/main-window.rkt")

;; 主程序入口
(define (main)
  ;; 初始化存储
  (initialize-storage)
  
  ;; 创建主窗口
  (define main-window (new main-window%))

  ;; 居中显示主窗口
  (send main-window center)
  
  ;; 显示主窗口
  (send main-window show #t))

;; 启动程序
(main)