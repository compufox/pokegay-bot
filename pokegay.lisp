;;;; pokegay.lisp

(in-package #:pokegay)

;; bug in textery passes a second argument into a function call that doesnt need it
(defun cl-user::prepare-pokemon-name (text _)
  (declare (ignore _))
  (string-downcase
   (str:replace-all "♂" "_m"
                    (str:replace-all "♀" "_f"
                                     (str:replace-all "." ""
                                                      (str:replace-all " " "_" text))))))

(defun first-run-p ()
  (probe-file #P".first-run"))

(defun create-first-run-file ()
  (with-open-file (out ".first-run" :direction :output
                                    :if-does-not-exist :create)
    (format out "bwamp bwomp")))

(defun main ()
  (handler-case
      (with-user-abort
        (unless (load-grammar "pokemon.json")
          (error "could not find pokemon names file"))
        (run-bot ((make-instance 'mastodon-bot :config-file "config.file") :with-websocket nil)
          (after-every (2 :hours :run-immediately t)
            (if (first-run-p)
                (post (expand (format nil "#alert#~%:#names.prepare-pokemon-name#: gay")))
                (progn
                  (create-first-run-file)
                  (post (expand (format nil "#alert#~%:quagsire: gay"))))))))
    (user-abort ())
    (error (e)
      (format t "~A~%" e))))
