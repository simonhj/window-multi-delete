;(dolist (win (window-list) nil)
  

(walk-windows
 (lambda (win)
   (let ((buf (window-buffer win)))
     (with-current-buffer buf
       (progn (setq mode-line-front-space "W: 1")
	      (force-mode-line-update 1))))))
	

(defun save-mode-prefix (win-list)
  (mapcar (lambda (win)
	    (with-current-buffer (window-buffer win)
	      `(,win . ,mode-line-front-space)))
	  win-list))

(defvar oldies (save-mode-prefix (window-list)))

(defun append-id (win-list)
  (let ((win-idx 0))
    (dolist (win win-list)
      (with-current-buffer (window-buffer win)
	(setq-local mode-line-front-space  (concat "W: " (number-to-string win-idx)))
	(setq win-idx (+ win-idx 1))
	(force-mode-line-update t)))))
(append-id (window-list))

(defun restore-prefs (old-vals)
  (dolist (ac old-vals)
    (let ((buf (window-buffer (car ac)))
	  (old (cdr ac)))
      (with-current-buffer buf
	(setq-local mode-line-front-space old)
	(force-mode-line-update)))))

(defun keystroke-to-int (ks)
  (let ((val (- ks 48)))
    (if (and (>= val 0) (<= val 9))
	val
      nil)))

(defun read-window ()
  (keystroke-to-int (read-char "id of window to delete?")))

(defun kill-loop (win-list)
  (let ((save-mode-prefix win-list))
    (append-id win-list)
    (let ((win
    (while 
  


(defun window-multi-kill ()
  (let* ((windows (window-list))
	 (to-restore (save-mode-prefix windows)))
    (append-id windows)
    

    (read-char)
