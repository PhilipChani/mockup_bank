defmodule MockupBankWeb.Components.Utilities.AdminMenu do
  def render_menu(user_rights \\ %{user_type: "ADMIN"}) do
    [
      dashboard(user_rights),
      balance_inquiry(user_rights),
      cw(user_rights),
      cd(user_rights),
      report(user_rights),
      lookup_acc(user_rights),
      create_acc(user_rights),
      transfer(user_rights),
      transactions(user_rights),
      bank_accounts(user_rights),
      account_holders(user_rights),
      # accounts(user_rights),
      # maintenance(user_rights)
    ]
  end

  defp dashboard(_user_rights) do
    %{
      id: 0,
      title: "Dashboard",
      icon: "home",
      href: "/Main",
      user_access: {:miscellaneous, :dashboard},
      type: :link
    }
  end

  defp bank_accounts(_user_rights) do
    %{
      id: 2,
      title: "Bank Accounts",
      icon: "home",
      href: "/BankAccounts",
      user_access: {:miscellaneous, :dashboard},
      type: :link
    }
  end


  defp account_holders(_user_rights) do
    %{
      id: 2,
      title: "Account Holders",
      icon: "home",
      href: "/AccountHolders",
      user_access: {:miscellaneous, :dashboard},
      type: :link
    }
  end


  defp balance_inquiry(_user_rights) do
    %{
      id: 2,
      title: "Balance Iquiry",
      icon: "home",
      href: "/Main/balanceInqiry",
      user_access: {:miscellaneous, :dashboard},
      type: :link
    }
  end


  defp accounts(_user_rights) do
    %{
      id: 2,
      title: "Account Types",
      icon: "home",
      href: "/account_types",
      user_access: {:miscellaneous, :dashboard},
      type: :link
    }
  end

  defp cw(_user_rights) do
    %{
      id: 2,
      title: "Cash Withdraw",
      icon: "home",
      href: "/Main/cashWithdraw",
      user_access: {:miscellaneous, :dashboard},
      type: :link
    }
  end

  defp cd(_user_rights) do
    %{
      id: 2,
      title: "Cash Deposit",
      icon: "home",
      href: "/Main/CashDeposit",
      user_access: {:miscellaneous, :dashboard},
      type: :link
    }
  end

  defp report(_user_rights) do
    %{
      id: 2,
      title: "Transactions Report",
      icon: "home",
      href: "/Main/listAllTransactions",
      user_access: {:miscellaneous, :dashboard},
      type: :link
    }
  end

  defp lookup_acc(_user_rights) do
    %{
      id: 2,
      title: "Account lookup",
      icon: "home",
      href: "/Main/LookupAccount",
      user_access: {:miscellaneous, :dashboard},
      type: :link
    }
  end

  defp create_acc(_user_rights) do
    %{
      id: 2,
      title: "Create Account",
      icon: "home",
      href: "/Main/AccountCreation",
      user_access: {:miscellaneous, :dashboard},
      type: :link
    }
  end


  defp transfer(_user_rights) do
    %{
      id: 2,
      title: "Fund Transfer",
      icon: "home",
      href: "/Main/Transfer",
      user_access: {:miscellaneous, :dashboard},
      type: :link
    }
  end

  defp transactions(_user_rights) do
    %{
      id: 2,
      title: "Transactions",
      icon: "home",
      href: "/Transactions",
      user_access: {:miscellaneous, :dashboard},
      type: :link
    }
  end






  # defp maintenance(user_rights) do
  #   %{
  #     id: 20,
  #     title: "Maintenance",
  #     icon: "settings",
  #     user_access: {:settings, :view},
  #     type: :dropdown,
  #     options: [
  #       user_management(user_rights),
  #       system_services(user_rights)
  #     ]
  #   }
  # end

  # defp user_management(user_rights) do
  #   %{
  #     id: 20,
  #     title: "User Management",
  #     icon: "users",
  #     user_access: {:user_management, :view},
  #     type: :dropdown,
  #     options: [
  #       system_users(user_rights),
  #       agents(user_rights),
  #       user_rights(user_rights)
  #     ]
  #   }
  # end

  # defp system_users(_user_rights) do
  #   %{
  #     id: 0,
  #     title: "System Users",
  #     icon: "users",
  #     href: "/userManagement",
  #     user_access: {:users, :view},
  #     type: :link
  #   }
  # end

  # defp agents(_user_rights) do
  #   %{
  #     id: 1,
  #     title: "Agents",
  #     icon: "user",
  #     href: "/agentsManagement",
  #     user_access: {:agents, :view},
  #     type: :link
  #   }
  # end

  # defp user_rights(_user_rights) do
  #   %{
  #     id: 2,
  #     title: "User Roles & Rights",
  #     icon: "unlock",
  #     href: "/user_roles",
  #     user_access: {:user_roles, :view},
  #     type: :link
  #   }
  # end

  # defp system_services(user_rights) do
  #   %{
  #     id: 20,
  #     title: "Catalog",
  #     icon: "server",
  #     user_access: {:services, :view},
  #     type: :dropdown,
  #     options: [
  #       services(user_rights),
  #       banks(user_rights),
  #       locations(user_rights),
  #       commissions(user_rights),
  #     ]
  #   }
  # end

  # defp services(_user_rights) do
  #   %{
  #     id: 2,
  #     title: "Services",
  #     icon: "zap",
  #     href: "/services",
  #     user_access: {:user_roles, :view},
  #     type: :link
  #   }
  # end
  # defp banks(_user_rights) do
  #   %{
  #     id: 2,
  #     title: "Banks",
  #     icon: "zap",
  #     href: "/banks",
  #     user_access: {:user_roles, :view},
  #     type: :link
  #   }
  # end
  # defp locations(_user_rights) do
  #   %{
  #     id: 2,
  #     title: "Locations",
  #     icon: "zap",
  #     href: "/locations",
  #     user_access: {:user_roles, :view},
  #     type: :link
  #   }
  # end
  # defp commissions(_user_rights) do
  #   %{
  #     id: 2,
  #     title: "Commissions",
  #     icon: "zap",
  #     href: "/commissions",
  #     user_access: {:user_roles, :view},
  #     type: :link
  #   }
  # end
end
