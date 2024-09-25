defmodule MockupBankWeb.Components.Utilities.AgentMenu do
  def render_menu(user_rights \\ %{}) do
    [
      dashboard(user_rights),
      transactions(user_rights),
      sales(user_rights),
      commissions(user_rights),
    ]
  end

  defp dashboard(_user_rights) do
    %{
      id: 0,
      title: "Dashboard",
      icon: "home",
      href: "/home",
      user_access: {:miscellaneous, :dashboard},
      type: :link
    }
  end

  defp transactions(user_rights) do
    %{
      id: 20,
      title: "Services",
      icon: "aperture",
      user_access: {:settings, :view},
      type: :dropdown,
      options: [
        deposit(user_rights),
        withdraw(user_rights),
        transfer(user_rights)
      ]
    }
  end




  defp deposit(_user_rights) do
    %{
      id: 0,
      title: "Cash Deposit",
      icon: "chevrons-right",
      href: "/services/deposit",
      user_access: {:users, :view},
      type: :link
    }
  end
  defp withdraw(_user_rights) do
    %{
      id: 2,
      title: "Cash Withdraw",
      icon: "chevrons-right",
      href: "/services/withdraw",
      user_access: {:users, :view},
      type: :link
    }
  end
  defp transfer(_user_rights) do
    %{
      id: 3,
      title: "Cash Transfer",
      icon: "chevrons-right",
      href: "/services/transfer",
      user_access: {:users, :view},
      type: :link
    }
  end



  defp sales(_user_rights) do
    %{
      id: 0,
      title: "Trasactions",
      icon: "activity",
      href: "/transactions",
      user_access: {:agents, :view},
      type: :link
    }
  end
  defp commissions(_user_rights) do
    %{
      id: 1,
      title: "Commissions",
      icon: "zap",
      href: "/agentsManagement",
      user_access: {:agents, :view},
      type: :link
    }
  end



end
