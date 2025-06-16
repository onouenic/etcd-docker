# Etcd Docker - Ambiente com Autenticação e Controle de Acesso

Este repositório fornece um ambiente Docker para subir uma instância do [etcd](https://etcd.io/) já configurada com autenticação, usuário root, um usuário administrativo (`sisweb`) e roles de acesso. O objetivo é facilitar o provisionamento de um etcd seguro, pronto para uso em ambientes de desenvolvimento ou produção.

## Finalidade

- Subir rapidamente um servidor etcd com autenticação ativada.
- Criar usuários e roles iniciais para controle de acesso.
- Permitir fácil customização de usuários e permissões via exemplos e scripts.

## Pré-requisitos

- [Docker](https://docs.docker.com/get-docker/)
- [Docker Compose](https://docs.docker.com/compose/)

## Como usar

1. **Clone o repositório:**

   ```sh
   git clone <URL_DO_REPOSITORIO>
   cd etcd-docker
   ```

2. **Edite as variáveis de ambiente:**

   Abra o arquivo [`docker-compose.yml`](docker-compose.yml) e altere os valores das variáveis `ETCD_ROOT_PASSWORD` e `ETCD_ADMIN_PASSWORD` conforme desejado:

   ```yaml
   environment:
     ETCD_ROOT_PASSWORD: sua_senha_root
     ETCD_ADMIN_PASSWORD: sua_senha_admin
   ```

3. **Suba o ambiente:**

   Execute o comando abaixo para buildar a imagem e iniciar o container:

   ```sh
   docker-compose up -d
   ```

   O processo irá:
   - Construir a imagem Docker customizada.
   - Subir o container do etcd.
   - Executar o script [`initial-config.sh`](initial-config.sh) para criar usuários, roles e ativar a autenticação.

4. **Acessando o etcd:**

   Use o comando `etcdctl` para interagir com o etcd. Exemplos de comandos e gerenciamento de usuários estão comentados no final do arquivo [`initial-config.sh`](initial-config.sh).

## Estrutura do Projeto

- [`docker-compose.yml`](docker-compose.yml): Orquestração dos serviços e definição das variáveis de ambiente.
- [`Dockerfile`](Dockerfile): Criação da imagem customizada do etcd com script de configuração.
- [`initial-config.sh`](initial-config.sh): Script que realiza a configuração inicial de usuários, roles e autenticação.

## Observações

- A rede Docker `internal` deve existir previamente ou ser criada manualmente.
- O volume `etcd-data-prod` é utilizado para persistência dos dados do etcd.

## Exemplos de uso

Veja exemplos de comandos para criar usuários, roles e permissões no final do arquivo [`initial-config.sh`](initial-config.sh).

---

Qualquer dúvida, consulte a documentação oficial do [etcd](https://etcd.io/docs/).