# Banking API


An Umbrella project developed with the purpose of studying elixir and phoenix.

## Necessary Tools

    Docker
    Docker-compose
    Elixir
    Erlang

## First run

### Run these commands
    1 ~ mix deps.get
    2 ~ mix compile
    3 ~ docker-compose up -d
    4 ~ mix ecto.create
    5 ~ mix ecto.migrate
    6 ~ iex -S mix phx.server 

## Check the directory to test the application locally

### open any file in these folders and view the @doc """
    |_apps
        |_ banking_api
            |_ lib
                |_ banking_api
                    |_ accounts
                    |_ users

## For postman tests go to the link
    