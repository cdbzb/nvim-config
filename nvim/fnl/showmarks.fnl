(require :my-fennel)

(fn []
  (let [marks  (vim.fn.getmarklist "%" )]
    (print (vim.inspect marks) )))

 
