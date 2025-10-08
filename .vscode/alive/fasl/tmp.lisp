(defun read-file-as-string (path)
  (with-open-file (in path :direction :input) ; 例: SBCLなら :external-format :utf-8
    (let ((s (make-string (file-length in))))
      (read-sequence s in)
      s)))

(defun trim (s) (string-trim '(#\Space #\Tab #\Newline #\Return) s))

(defun split-top-level (s sep)
  (loop with in-str = nil
        with esc = nil
        with token = (make-array 0 :element-type 'character :adjustable t :fill-pointer 0)
        with out = '()
        for ch across s do
          (cond
           (esc (vector-push-extend ch token) (setf esc nil))
           ((char= ch #\\) (vector-push-extend ch token) (setf esc t))
           ((char= ch #\") (setf in-str (not in-str)) (vector-push-extend ch token))
           ((and (not in-str) (char= ch sep))
             (push (trim (coerce token 'string)) out)
             (setf token (make-array 0 :element-type 'character :adjustable t :fill-pointer 0)))
           (t (vector-push-extend ch token)))
        finally (progn
                 (push (trim (coerce token 'string)) out)
                 (return (nreverse out)))))

(defun unquote-json-string (s)
  (labels ((unesc (s)
                  (with-output-to-string (out)
                    (loop with esc = nil
                          for ch across s do
                            (cond
                             (esc
                               (write-char
                                 (case ch
                                   (#\" #\")
                                   (#\\ #\\)
                                   (#\/ #\/)
                                   (#\b #\Backspace)
                                   (#\f #\Page)
                                   (#\n #\Newline)
                                   (#\r #\Return)
                                   (#\t #\Tab)
                                   (t ch)) ; \uXXXX は簡易実装では未対応
                                 out)
                               (setf esc nil))
                             ((char= ch #\\) (setf esc t))
                             (t (write-char ch out)))))))
    (let ((len (length s)))
      (if (and (>= len 2) (char= (char s 0) #\") (char= (char s (1- len)) #\"))
          (unesc (subseq s 1 (1- len)))
          s))))

(defun maybe-json-number (s)
  (let* ((s (trim s))
         (allowed "+-0123456789.eE"))
    (when (and (> (length s) 0)
               (every (lambda (c) (or (digit-char-p c) (find c allowed))) s))
          (handler-case
              (let ((obj (read-from-string s)))
                (when (numberp obj) obj))
            (error () nil)))))

(defun parse-flat-json-object (s)
  (let* ((s (trim s)))
    (unless (and (plusp (length s))
                 (char= (char s 0) #\{)
                 (char= (char s (1- (length s))) #\}))
      (error "JSON object expected (starting with { and ending with })."))
    (let* ((body (subseq s 1 (1- (length s))))
           (pairs (remove "" (split-top-level body #\,) :test #'string=)))
      (mapcar
          (lambda (pair)
            (let* ((kv (split-top-level pair #\:))
                   (raw-k (trim (first kv)))
                   (raw-v (trim (second kv)))
                   (k (unquote-json-string raw-k))
                   (v (cond
                       ((string= raw-v "null") nil)
                       ((string= raw-v "true") t)
                       ((string= raw-v "false") nil)
                       ((and (plusp (length raw-v)) (char= (char raw-v 0) #\"))
                         (unquote-json-string raw-v))
                       ((maybe-json-number raw-v))
                       (t raw-v))))
              (cons k v)))
          pairs))))

(defun print-json-file-as-key-value (path)
  (let* ((text (read-file-as-string path))
         (alist (parse-flat-json-object text)))
    (dolist (kv alist)
      (format t "~A: ~A~%" (car kv) (cdr kv)))))

;;; 使い方:
(print-json-file-as-key-value "link.json")
