etcdctl --user="user_dumps:Zcf6jqn533vcmB" get /service/nestjs/dumps/json/connections

etcdctl --user="user_dumps:Zcf6jqn533vcmB" put /service/nestjs/dumps/json/connections '[{"name": "mysql","type": "mysql","host": localhost","port": 3306,"user": "root","password": "jZNCsJGUo3ch2a","database": "mysql"}]'

etcdctl --user="user_dumps:Zcf6jqn533vcmB" get /service/nestjs/dumps/mongodb/uri

etcdctl --user="user_dumps:Zcf6jqn533vcmB" put /service/nestjs/dumps/mongodb/uri "mongodb://user_dumps:bq0Qctz46uhF2Y@localhost:27017/db_dumps"

etcdctl --user="user_dumps:Zcf6jqn533vcmB" get /service/nestjs/dumps/rabbitmq/uri

etcdctl --user="user_dumps:Zcf6jqn533vcmB" put /service/nestjs/dumps/rabbitmq/uri amqp://guest:guest@localhost:5672

etcdctl --user="user_dumps:Zcf6jqn533vcmB" del /minhachave

etcdctl --user="admin:TfsnXvh6Df84Lb9c" put /global/kumo/frontend-hostname "kumo.example.com"

etcdctl --user="admin:TfsnXvh6Df84Lb9c" put /global/kumo/frontend-hostname

etcdctl --user admin:TfsnXvh6Df84Lb9c user add user_dumps
etcdctl --user admin:TfsnXvh6Df84Lb9c role add role_user_dumps
etcdctl --user admin:TfsnXvh6Df84Lb9c role grant-permission role_user_dumps --prefix=true readwrite /service/nestjs/dumps
etcdctl --user admin:TfsnXvh6Df84Lb9c user grant-role user_dumps role_user_dumps
etcdctl --user admin:TfsnXvh6Df84Lb9c role add role_global_r
etcdctl --user admin:TfsnXvh6Df84Lb9c role grant-permission role_global_r --prefix=true readwrite /globals
etcdctl --user admin:TfsnXvh6Df84Lb9c user grant-role user_dumps role_global_r

etcdctl --user admin:TfsnXvh6Df84Lb9c role delete role_user_dumps
