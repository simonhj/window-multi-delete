;;; window-closer.el --- quickly close multiple windows.

;; Once invoked `window-multi-delete' will number all open windows and
;; allow the user to close them by just hitting the corresponding key.

;; TODO for publishing:
;;  - Deal with multiple windows showing same buffer 
;;  - Support more than 9 windows
;;  - Apply more noticable face to added ids. 

(defun save-mode-prefix (win-list)
  (mapcar (lambda (win)
	    (with-current-buffer (window-buffer win)
	      `(,win . ,mode-line-front-space)))
	  win-list))

(defun append-id (win-list)
  (let ((win-idx 0))
    (dolist (win win-list)
      (with-current-buffer (window-buffer win)
	(setq-local mode-line-front-space  (concat "W: " (number-to-string win-idx)))
	(setq win-idx (+ win-idx 1))
	(force-mode-line-update)))))

(defun restore-prefs (old-vals)
  (dolist (ac old-vals)
    (when (window-live-p (car ac))
      (let ((buf (window-buffer (car ac)))
	    (old (cdr ac)))
	(with-current-buffer buf
	  (setq-local mode-line-front-space (if (equal old nil) "" old))
	  (force-mode-line-update))))))

(defun keystroke-to-int (ks)
  (let ((val (- ks 48)))
    (if (and (>= val 0) (<= val 9))
	val
      nil)))

(defun read-window ()
  (keystroke-to-int (read-char "id of window to delete or q to quit?")))

(defun kill-loop (win-list)
  (let ((old (save-mode-prefix win-list)))
    (append-id win-list)
    (let ((win-key (read-window)))
      (while (not (equal win-key nil))
	(let ((win (nth win-key win-list)))
	  (when (window-live-p win)
	    (delete-window win))
	  (setq win-key (read-window)))))
    (restore-prefs old)))
	
(defun window-multi-kill ()
  (interactive)
  (kill-loop (window-list)))

(let ((count 0))
  (dolist (win (window-list))
    (set-window-parameter win 'ret count)
    (setq count (+ 1 count))
    (message (number-to-string count))
    (with-current-buffer (window-buffer win)
      (setq-local mode-line-front-spac
		  '(:eval (number-to-string (window-parameter (selected-window) 'ret)))))))


(window-parameters)
