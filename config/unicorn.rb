worker_processes 4
timeout 30

APP_PATH = "/home/ddao/git/muzik/"
working_directory APP_PATH

stderr_path APP_PATH + "/log/unicorn.stderr.log"
stdout_path APP_PATH + "/log/unicorn.stderr.log"

pid APP_PATH + "/tmp/pids/unicorn.pid"
