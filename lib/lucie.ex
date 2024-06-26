defmodule Lucie do
  @moduledoc """
  Lucie keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """

  def schema do
    quote do
      use Ecto.Schema
      import Ecto.Changeset
      import LucieWeb.Gettext
    end
  end

  def context do
    quote do
      import Ecto.Query
      alias Lucie.Repo
    end
  end

  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end
end
