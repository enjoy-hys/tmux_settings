## 下記内容をホームディレクトリの.bash_profileの最後に追加
#function ssh() {
#    # tmux起動している場合
#    if [ -n "${TMUX}" ]; then

        # 接続先の名前を新しいウィンドの名前にする関数を定義
        tmux_new_ssh() {
            tmux setw -g window-status-format "<#I:#{window_name}>"
            # 引数で実際に実行するコマンドを作成
            ssh_cmd="ssh $@"
            # 引数を別windowの名前にして新規に開く
            tmux new-window -n "$*" "$ssh_cmd"
            tmux setw -g window-status-current-bg colour33
            tmux setw -g window-status-current-fg white
            tmux setw -g window-status-format "<#I:#{window_name}>"
        }

        # 環境変数がscreenであれば、sshコマンドをaliasつけて、tmux_new_ssh関数を実行
        if [ $TERM = "screen" ]; then
            tmux lsw
            # 今は0番目のwindowsであれば sshコマンドをalias付けて実行
            if [ $? -eq 0 ]; then
                alias ssh=tmux_new_ssh
                tmux setw -g window-status-format "<#I:#{window_name}>"
            fi
        fi

    # tmux起動していない場合そのままsshコマンド実行
#    else
#        command ssh $@
#    fi
#}

