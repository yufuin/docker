# mkdir path/to/mysql_dir_some_task # mysqlのデータ保存用ディレクトリの用意
# docker run -d --name mysql_optuna_for_some_task --rm -p 12345:3306 -v path/to/mysql_dir_some_task:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=some_password mysql_optuna # mysqlサーバの用意
# mysql --host 127.0.0.1 --port 12345 -p -u root
# mysql> CREATE DATABASE optuna_table_some_task; # optuna用のデータベース作成
# mysql> ^D
# optuna create-study --study-name "study_some_task" --storage "mysql://root:some_password@127.0.0.1:12345/optuna_table_some_task" --direction "maximize" # optunaのデータベースの初期化
