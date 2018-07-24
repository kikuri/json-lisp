;;;; app.lisp
;;; ningleをロード (ロード状況を出力しない)
(ql:quickload '(:jonathan  ; 追加した
                :ningle)
                :silent t)

;;; ningleのアプリケーションクラスをインスタンス化する
(defparameter *app* (make-instance 'ningle:<app>))

;;; アプリケーションクラスの`/`の戻り値を設定
(setf (ningle:route *app* "/")
      "Hello API!")

;;; clackupするためにアプリケーションインスタンスが返るようにする (後述)
*app*

(defparameter *db*
  '((:id 1 :title "記事1" :date "2017-01-01" :tags ("tag1" "tag2" "tag3")
         :body "本文1本文1本文1本文1")
    (:id 2 :title "記事2" :date "2017-01-02" :tags ("tag2" "tag3")
         :body "本文2本文2本文2本文2")
    (:id 3 :title "記事3" :date "2017-01-03" :tags ("tag1" "tag3")
         :body "本文3本文3本文3本文3")))

(defun to-list (record)
  (list :id (getf record :id)
        :title (getf record :title)
        :date (getf record :date)
        :tags (getf record :tags)))

(setf (ningle:route *app* "/post/list")
      (jonathan:to-json (mapcar #'to-list *db*)))
