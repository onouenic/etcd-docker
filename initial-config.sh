#!/bin/sh
set -e

echo "--- [INÍCIO] Setup inicial do etcd (root + auth) ---"

# Valida se a senha root foi fornecida
if [ -z "${ETCD_ROOT_PASSWORD}" ]; then
    echo "!!! ERRO: A variável ETCD_ROOT_PASSWORD deve ser definida."
    exit 1
fi

echo "Verificando se o usuário root já existe..."
if ! etcdctl user get root > /dev/null 2>&1; then
  echo "=> Criando usuário root..."
  echo "${ETCD_ROOT_PASSWORD}" | etcdctl user add root --interactive=false
else
  echo "Usuário root já existe."
fi

# Criação do usuário admin com permissões amplas
echo "Verificando se o usuário sisweb já existe..."
if ! etcdctl user get sisweb > /dev/null 2>&1; then
    echo "Criando usuário admin..."
    echo "${ETCD_ADMIN_PASSWORD}" | etcdctl user add sisweb --interactive=false

    # Cria role admin
    etcdctl role add role_admin

    # Permissão readwrite para todo prefixo "/"
    etcdctl role grant-permission role_admin --prefix=true readwrite /

    # Importante: para permitir o usuário admin gerenciar usuários e roles,
    # associe também a role root (que tem todos os privilégios administrativos)
    etcdctl user grant-role sisweb root

    # Também associe a role admin (controle de dados)
    etcdctl user grant-role sisweb role_admin

    echo "Usuário admin e role_admin criados e configurados."
else
    echo "Usuário sisweb já existe. Pulando criação."
fi

echo "Ativando autenticação..."
etcdctl auth enable || echo "Autenticação já ativada."

echo "--- [FIM] Setup inicial ---"

###############################################################################
# EXEMPLOS – execute manualmente depois que o etcd estiver rodando e autenticado
#
# 1) Criar um usuário de aplicação:
#
#   etcdctl --user root:<senha> user add user_dumps
#
# 2) Criar uma role com acesso a um prefixo:
#
#   etcdctl --user root:<senha> role add role_user_dumps
#   etcdctl --user root:<senha> role grant-permission role_user_dumps \
#       --prefix=true readwrite /dumps/
#
# 3) Associar usuário à role:
#
#   etcdctl --user root:<senha> user grant-role user_dumps role_user_dumps
#
# 4) Criar role global com acesso a /globals/:
#
#   etcdctl --user root:<senha> role add role_global_rw
#   etcdctl --user root:<senha> role grant-permission role_global_rw \
#       --prefix=true readwrite /globals/
#
#   # Atribuir a qualquer usuário:
#   etcdctl --user root:<senha> user grant-role user_dumps role_global_rw
#
###############################################################################
