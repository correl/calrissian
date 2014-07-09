(defmodule state
  (export (behaviour_info 1)))

(defun behaviour_info
  (('callbacks) (list #(run 2)
                      #(get 0)
                      #(put 1)
                      #(modify 1)
                      #(modify-and-return 1)
                      #(exec 2)
                      #(eval 2)))
  ((_) 'undefined))