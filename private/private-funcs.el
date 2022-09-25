(defun private/mu4e-setup ()
  (let ((mu4e-dir
         (when private-user-directory
           (expand-file-name (concat private-user-directory "mu4e")))))
    (if (and mu4e-dir (file-exists-p mu4e-dir))
        (progn
          (setq
           mu4e-attachment-dir "~/Downloads"
           mu4e-enable-notifications t
           mu4e-enable-mode-line t
           mu4e-enable-async-operations t

           mu4e-get-mail-command
           (concat "cd " mu4e-dir " && offlineimap -c offlineimaprc")
           mu4e-view-show-addresses t
           mu4e-update-interval 300
           auth-sources '((:source "~/.doom.d/mu4e/authinfo.gpg"))
           smtpmail-debug-info t
           message-send-mail-function 'smtpmail-send-it)

          ;; Multiple email
          ;; Function to encrypt ~/.authinfo:
          ;; M-x epa-encrypt-file (generate ~/.authinfo.gpg and remove original).
          (with-eval-after-load 'mu4e
            (setq
             mu4e-contexts
             `(,(make-mu4e-context
                 :name "Gmail"
                 :enter-func (lambda () (mu4e-message
                                         "Switch to the Gmail context"))
                 ;; leave-func not defined
                 :match-func (lambda (msg)
                               (when msg
                                 (mu4e-message-contact-field-matches
                                  msg
                                  :to "wastrawan@gmail.com")))
                 :vars '((user-mail-address . "wastrawan@gmail.com")
                         (user-full-name . "Astrawan Wayan")
                         (smtpmail-smtp-user . "wastrawan@gmail.com")
                         (smtpmail-default-smtp-server . "smtp.gmail.com")
                         (smtpmail-smtp-server . "smtp.gmail.com")
                         (smtpmail-smtp-service . 465)
                         (smtpmail-stream-type . ssl)
                         (mu4e-sent-folder . "/wastrawan@gmail.com/Sent")
                         (mu4e-drafts-folder . "/wastrawan@gmail.com/Drafts")
                         (mu4e-trash-folder . "/wastrawan@gmail.com/Trash")
                         (mu4e-refile-folder . "/wastrawan@gmail.com/Archive")))
               ,(make-mu4e-context
                 :name "Outlook"
                 :enter-func (lambda () (mu4e-message
                                         "Switch to the Outlook context"))
                 ;; leave-func not defined
                 :match-func (lambda (msg)
                               (when msg
                                 (mu4e-message-contact-field-matches
                                  msg
                                  :to "astrawan@outlook.com")))
                 :vars '((user-mail-address . "astrawan@outlook.com")
                         (user-full-name . "Astrawan Wayan")
                         (smtpmail-smtp-user . "astrawan@outlook.com")
                         (smtpmail-default-smtp-server . "smtp.office365.com")
                         (smtpmail-smtp-server . "smtp.office365.com")
                         (smtpmail-smtp-service . 587)
                         (smtpmail-stream-type . starttls)
                         (mu4e-sent-folder . "/astrawan@outlook.com/Sent")
                         (mu4e-drafts-folder . "/astrawan@outlook.com/Drafts")
                         (mu4e-trash-folder
                          . "/astrawan@outlook.com/Deleted Messages")
                         (mu4e-refile-folder . "/astrawan@outlook.com/Archive")))
               ,(make-mu4e-context
                 :name "Icloud"
                 :enter-func (lambda () (mu4e-message
                                         "Switch to the Icloud context"))
                 ;; leave-func not defined
                 :match-func (lambda (msg)
                               (when msg
                                 (mu4e-message-contact-field-matches
                                  msg
                                  :to "astrawan@icloud.com")))
                 :vars '((user-mail-address . "astrawan@icloud.com")
                         (user-full-name . "Astrawan Wayan")
                         (smtpmail-smtp-user . "astrawan@icloud.com")
                         (smtpmail-default-smtp-server . "smtp.mail.me.com")
                         (smtpmail-smtp-server . "smtp.mail.me.com")
                         (smtpmail-smtp-service . 587)
                         (smtpmail-stream-type . starttls)
                         (mu4e-sent-folder . "/astrawan@icloud.com/Sent")
                         (mu4e-drafts-folder . "/astrawan@icloud.com/Drafts")
                         (mu4e-trash-folder
                          . "/astrawan@icloud.com/Deleted Messages")
                         (mu4e-refile-folder
                          . "/astrawan@icloud.com/Archive"))))))
          ))))

(provide 'private-funcs)
