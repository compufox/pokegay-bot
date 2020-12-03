;;;; pokegay.lisp

(in-package #:pokegay)

(defun prepare-pokemon-name (text)
  "convert pokemon's name to emojo format"
  (string-downcase
   (str:replace-all "-" "_"
     (str:replace-all "♂" "_m"
       (str:replace-all "♀" "_f"
         (str:replace-all "." ""
           (str:replace-all " " "_" text)))))))

(defun first-run-p ()
  "is this the first time we've ran?"
  (not (probe-file #P".first-run")))

(defun create-first-run-file ()
  "create the first run file so we dont run again"
  (with-open-file (out ".first-run" :direction :output
                                    :if-does-not-exist :create)
    (format out "bwamp bwomp")))

(defun main ()
  "binary entry point"
  (handler-case
      (with-user-abort

        ;; if we can't load the json, error out
        (unless (load-grammar "pokemon.json")
          (error "could not find pokemon names file"))

        ;; run the bot
        (run-bot ((make-instance 'mastodon-bot :config-file "config.file") :with-websocket nil)
          ;; run every 2 hours, but start NOW
          (after-every (2 :hours :run-immediately t)
            (if (first-run-p)
                (progn
                  (create-first-run-file)
                  ;; fulfill the prophecy:
                  ;; https://twitter.com/_compufox/status/1333200391593455618
                  (post (expand (format nil "#alert#~%:quagsire: gay"))))

                ;; post about a random pokemon
                (post (expand (format nil "#alert#~%:#names.prepare-pokemon-name#: gay")))))))

    ;; if the user aborts (Ctrl-C's) use then we catch it gracefully
    (user-abort ()
      (format t "quitting~%"))
    (error (e)
      (format t "~A~%" e))))
