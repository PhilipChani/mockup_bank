defmodule MockupBankWeb.Components.Utilities.MainMenu do
  alias MockupBankWeb.Components.Utilities.{AdminMenu, AgentMenu}

  def get_menu(user_rights \\ %{user_type: "ADMIN"}) do
    user_rights.user_type
    |> case  do
        "AGENT"  -> AgentMenu.render_menu(user_rights)
        _ ->
          AdminMenu.render_menu(user_rights)
       end
  end
end
