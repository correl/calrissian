(defmodule calrissian-util
  (export (module-info 1)
          (module-info 2)
          (implements? 2)
          (exports? 2)))

(defun module-info
  (((tuple module _args))
   ;; Report exported function arities as (arity - 1) to account for
   ;; the extra argument supplied to tuple modules
   (let ((fix-info (lambda (info-plist)
                     (let* ((exports (proplists:get_value 'exports info-plist))
                            (fix-arity (match-lambda
                                         ;; module_info is added by the compiler and therefore remains as-is
                                         (((tuple 'module_info arity)) (tuple 'module_info arity))
                                         (((tuple fun arity)) (tuple fun (- arity 1)))))
                            (info-dict (dict:from_list info-plist))
                            (new-dict (dict:store 'exports (lists:map fix-arity exports) info-dict))
                            (new-plist (dict:to_list new-dict)))
                       new-plist))))
     (funcall fix-info (module-info module))))
  ((module)
   (call module 'module_info)))

(defun module-info (module key)
  (proplists:get_value key (module-info module)))

(defun implements? (behaviour module)
  (let* ((exports (module-info module 'exports))
         (exported? (lambda (definition) (lists:member definition exports))))
    (lists:all exported?
      (call behaviour 'behaviour_info 'callbacks))))

(defun exports? (definition module)
  (lists:member definition
    (module-info module 'exports)))
