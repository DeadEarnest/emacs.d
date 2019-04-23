;;; init-python.el --- Python editing -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

(setq auto-mode-alist
      (append '(("SConstruct\\'" . python-mode)
                ("SConscript\\'" . python-mode))
              auto-mode-alist))

(require-package 'pip-requirements)
(require-package 'elpy)

(elpy-enable)
(setq elpy-rpc-backend "jedi")
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




(provide 'init-python)
;;; init-python.el ends here
