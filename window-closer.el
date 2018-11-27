;(dolist (win (window-list) nil)
  

(walk-windows
 (lambda (win)
   (let ((buf (window-buffer win)))
     (with-current-buffer buf
       (progn (setq mode-line-front-space "W: 1")
	      (force-mode-line-update 1))))))
	

(defun save-mode-prefix ()
  (mapcar (lambda (win)
	    (with-current-buffer (window-buffer win)
	      `(,win . ,mode-line-front-space)))
	  (window-list)))

(defun append-id (win-list)
  (let ((win-idx 0))
    (dolist (win win-list)
      (with-current-buffer (window-buffer win)
	(setq-local mode-line-front-space  (concat "W: " (number-to-string win-idx)))
	(setq win-idx (+ win-idx 1))
	(force-mode-line-update t)))))

(append-id (window-list))
