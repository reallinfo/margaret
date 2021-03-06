defmodule MargaretWeb.Router do
  use MargaretWeb, :router
  use Plug.ErrorHandler
  use Sentry.Plug

  pipeline :api do
    plug(:accepts, ["json"])
  end

  pipeline :graphql do
    plug(MargaretWeb.AuthPipeline)
    plug(MargaretWeb.Context)
  end

  scope "/auth", MargaretWeb do
    pipe_through(:api)

    post("/refresh", AuthController, :refresh)

    get("/:provider", AuthController, :request)
    get("/:provider/callback", AuthController, :callback)
  end

  scope "/" do
    pipe_through(:graphql)

    forward(
      "/graphql",
      Absinthe.Plug,
      schema: MargaretWeb.Schema,
      analyze_complexity: true,
      max_complexity: 50
    )

    forward(
      "/graphiql",
      Absinthe.Plug.GraphiQL,
      schema: MargaretWeb.Schema,
      interface: :playground
    )
  end
end
