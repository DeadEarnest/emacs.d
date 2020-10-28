;;; init-python.el --- Python editing -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:


;; See the following note about how I set up python + virtualenv to
;; work seamlessly with Emacs:
;; https://gist.github.com/purcell/81f76c50a42eee710dcfc9a14bfc7240


(setq auto-mode-alist
      (append '(("SConstruct\\'" . python-mode)
                ("SConscript\\'" . python-mode))
              auto-mode-alist))

(setq python-shell-interpreter "python3")

(require-package 'pip-requirements)
(require-package 'elpy)

(elpy-enable)
(setq elpy-rpc-backend "jedi")
(setq elpy-rpc-python-command "python3")
(setq python-shell-buffer-name "python3")
(setq python-shell-interpreter "python3")
;;(setenv "WORKON_HOME" "/home/qwe/code/python/sandbox/")
;;(pyvenv-activate "/home/qwe/code/python/sandbox/venv/")

;;; anaconda completion doesn't work for some reason
;; (when (maybe-require-package 'anaconda-mode)
;;   (after-load 'python
;;     (add-hook 'python-mode-hook 'anaconda-mode)
;;     (add-hook 'python-mode-hook 'anaconda-eldoc-mode))
;;   (after-load 'anaconda-mode
;;     (define-key anaconda-mode-map (kbd "M-?") nil))
;;   (when (maybe-require-package 'company-anaconda)
;;     (after-load 'company
;;       (after-load 'python
;;         (push 'company-anaconda company-backends)))))


(when (maybe-require-package 'anaconda-mode)
  (with-eval-after-load 'python
    ;; Anaconda doesn't work on remote servers without some work, so
    ;; by default we enable it only when working locally.
    (add-hook 'python-mode-hook
              (lambda () (unless (file-remote-p default-directory)
                           (anaconda-mode 1))))
    (add-hook 'anaconda-mode-hook
              (lambda ()
                (anaconda-eldoc-mode (if anaconda-mode 1 0)))))
  (with-eval-after-load 'anaconda-mode
    (define-key anaconda-mode-map (kbd "M-?") nil))
  (when (maybe-require-package 'company-anaconda)
    (with-eval-after-load 'company
      (with-eval-after-load 'python
        (add-to-list 'company-backends 'company-anaconda)))))

(when (maybe-require-package 'toml-mode)
  (add-to-list 'auto-mode-alist '("poetry\\.lock\\'" . toml-mode)))

(when (maybe-require-package 'reformatter)
  (reformatter-define black :program "black"))

(provide 'init-python)
;;; init-python.el ends here
