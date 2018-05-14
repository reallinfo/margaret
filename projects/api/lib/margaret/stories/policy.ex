defmodule Margaret.Stories.Policy do
  @moduledoc """
  Policy module for Stories.
  """

  @behaviour Bodyguard.Policy

  alias Margaret.{
    Accounts
  }

  alias Accounts.User

  @impl Bodyguard.Policy
  def authorize(_action, %User{is_admin: true}, _story), do: :ok
end
