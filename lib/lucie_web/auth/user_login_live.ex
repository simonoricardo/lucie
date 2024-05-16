defmodule LucieWeb.UserLoginLive do
  use LucieWeb, :live_view

  def render(assigns) do
    ~H"""
    <div class="mx-auto max-w-sm">
      <.header class="text-center">
        <%= dgettext("auth", "Log in to account") %>
        <:subtitle>
          <%= dgettext("auth", "Don't have an account") %>
          <.link navigate={~p"/register"} class="font-semibold text-brand hover:underline">
            <%= dgettext("auth", "Sign up") %>
          </.link>
          <%= dgettext("auth", "for an account now.") %>
        </:subtitle>
      </.header>

      <.simple_form for={@form} id="login_form" action={~p"/login"} phx-update="ignore">
        <.input field={@form[:email]} type="email" label={dgettext("auth", "Email")} required />
        <.input
          field={@form[:password]}
          type="password"
          label={dgettext("auth", "Password")}
          required
        />

        <:actions>
          <.input
            field={@form[:remember_me]}
            type="checkbox"
            label={dgettext("auth", "Keep me logged in")}
          />
          <.link href={~p"/reset_password"} class="text-sm font-semibold">
            <%= dgettext("auth", "Forgot your password?") %>
          </.link>
        </:actions>
        <:actions>
          <.button phx-disable-with="Logging in..." class="w-full">
            <%= dgettext("auth", "Log in") %> <span aria-hidden="true">→</span>
          </.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  def mount(_params, _session, socket) do
    email = Phoenix.Flash.get(socket.assigns.flash, :email)
    form = to_form(%{"email" => email}, as: "user")
    {:ok, assign(socket, form: form), temporary_assigns: [form: form]}
  end
end
