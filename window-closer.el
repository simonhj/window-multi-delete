;(dolist (win (window-list) nil)
  

(walk-windows
 (lambda (win)
   (let ((buf (winder-buffer win)))
     (with-current-buffer win
       (setq 
	
