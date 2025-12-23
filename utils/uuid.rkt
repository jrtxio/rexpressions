#lang racket

;; UUID v4 生成
(require racket/random)

;; 生成随机十六进制字符串
(define (random-hex n)
  (define hex-chars "0123456789abcdef")
  (list->string
   (for/list ([i (in-range n)])
     (string-ref hex-chars (random 16)))))

;; 生成 UUID v4
(define (generate-uuid)
  (string-append
   (random-hex 8) "-"
   (random-hex 4) "-"
   "4" (random-hex 3) "-"  ; UUID v4 版本标识
   (string (string-ref "89ab" (random 4))) (random-hex 3) "-"  ; 变体标识
   (random-hex 12)))

;; 导出函数
(provide generate-uuid)