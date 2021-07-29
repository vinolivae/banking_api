# Banking API


An Umbrella project developed with the purpose of studying elixir and phoenix.

A banking API where all users have an account and each account has a balance of 1,000.00.

## Necessary Tools.

    Docker
    Docker-compose
    Elixir
    Erlang

## First run.

### Run these commands

    1 ~ mix deps.get
    2 ~ mix compile
    3 ~ docker-compose up -d
    4 ~ mix ecto.create
    5 ~ mix ecto.migrate
    6 ~ iex -S mix phx.server 

## Check the directory to test the application locally.

### open any file in these folders and view the @doc """..."""

    |_apps
        |_ banking_api
            |_ lib
                |_ banking_api
                    |_ accounts
                    |_ users

## For postman or others.

### POST User

    http://localhost:4000/api/users/register
    {
        "name": "name", 
        "surname": "surname",
        "email": "email", 
        "password": "password" 
    }

## PATCH Withdraw

    http://localhost:4000/api/accounts/insert_id_of_account_here/withdraw
    {
        "id": "15bd914d-dc6b-49ec-a148-826ce5a38c5a",
        "value": "1"
    }

## PATCH Transaction

    http://localhost:4000/api/accounts/transaction
    {
        "from": "115bd581-bb8f-4a29-9fe0-7375069676e1",
        "to": "c0775d87-6bef-45e2-b051-d5715d81c689",
        "value": "1"
    }