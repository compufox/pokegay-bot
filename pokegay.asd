;;;; pokegay.asd

(asdf:defsystem #:pokegay
  :description "Describe pokegay here"
  :author "ava fox"
  :license  "NPLv1+"
  :version "0.0.1"
  :serial t
  :depends-on (#:textery #:glacier #:with-user-abort)
  :components ((:file "package")
               (:file "pokegay"))
  :entry-point "pokegay:main"
  :build-operation "program-op"
  :build-pathname "bin/pokegay-bot")
