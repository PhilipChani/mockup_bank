defmodule MockupBankWeb.Utilities.Utils do
  @integers ~w(0 1 2 3 4 5 6 7 8 9)s
  @cap_char ~w(A B C D E F G H I J K L M N O P Q R S T U V W X Y Z)s
  @specials ~w(! ? @ # $ % ^ & * _)s
  # "2017-06-01T08:30"
  def now, do: Timex.now("Africa/Lusaka")
  def year, do: now().year
  def month, do: now().month
  def day, do: now().day
  def hour, do: now().hour
  def minute, do: now().minute
  def second, do: now().second
  def custom_datetime, do: "#{year()}#{month()}#{day()}#{hour()}#{minute()}#{second()}"

  def custom_datetime2,
    do: "#{year()}-#{padding(month())}-#{padding(day())}T#{padding(hour())}:#{padding(minute())}"

  def format_date(date), do: Timex.format!(date, "%A, %d %B %Y  -  %H:%M", :strftime)
  def format_date1(date), do: Timex.format!(date, "%A, %d %B %Y  -  %H:%M:%S:%M", :strftime)
  def display_date_time(), do: Timex.format!(Timex.now(), "%A, %d %B %Y", :strftime)
  def date_url, do: "/images/Uploads/#{year()}/#{month()}/#{day()}/#{hour()}"
  def date_doc_url, do: "/Uploads/#{year()}/#{month()}/#{day()}/#{hour()}"

  def app_docs_assets, do: Path.join(app_dir(), "")

  defp padding(value) do
    to_string(value)
    |> String.pad_leading(2, "0")
  end

  def password() do
    ints = Enum.random(@integers)
    cap_char = Enum.random(@cap_char)
    "#{random_string(12)}#{Enum.random(@specials)}#{cap_char}#{Enum.random(@specials)}#{ints}"
  end

  def traverse_errors(errors),
    do: for({key, {msg, _opts}} <- errors, do: "#{key} #{msg}") |> List.first()

  def remote_ip(socket), do: socket.remote_ip |> :inet.ntoa() |> to_string()

  def random_string(length),
    do: :crypto.strong_rand_bytes(length) |> Base.url_encode64() |> binary_part(0, length)

  def read_file(name) do
    File.read!(Path.expand(name))
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(&String.split(&1, "\t"))
    |> Enum.map(fn [a, b] -> {a, b} end)
  end

  def sort_by_date(data, order) do
    data
    |> Enum.sort_by(& &1.inserted_at, order)
  end

  def app_dir, do: File.cwd!()
  def app_assets, do: Path.join(app_dir(), "/priv/static")

  def complete_transaction_handler({:ok, _txn} = txn), do: txn
  def complete_transaction_handler({:error, _fail} = db_txn), do: db_txn
  def complete_transaction_handler({:error, _, changeset, _ch}), do: error_msg_handler(changeset)

  def complete_transaction_handler(_errors) do
    {:error, "Unknown Error"}
  end

  def error_msg_handler(changeset) when is_binary(changeset) do
    {:error, changeset}
  end

  def error_msg_handler(changeset) do
    try do
      reason =
        traverse_errors(changeset)
        |> List.first()

      {:error, reason}
    rescue
      _ ->
        error_messages =
          changeset.errors
          |> Enum.map(&extract_error_message/1)
          |> List.first()

        {:error, error_messages}
    end
  end

  def extract_error_explanation({:error, _, changeset, _}) do
    error_messages =
      changeset.errors
      |> Enum.map(&extract_error_message/1)

    {changeset.valid?, error_messages}
  end

  defp extract_error_message({field, {message, _options}}) do
    field_err =
      if is_atom(field) do
        Atom.to_string(field)
      else
        field
      end

    "#{String.capitalize(field_err)} #{message}"
  end

  def set_brn_totals(_), do: [[]]

  def set_column(val) do
    [
      val || :empty,
      border: [
        bottom: [style: :thin, color: "#ebe8e8"],
        top: [style: :thin, color: "#ebe8e8"],
        right: [style: :thin, color: "#ebe8e8"],
        left: [style: :thin, color: "#ebe8e8"]
      ],
      row_heights: %{8 => 25}
    ]
  end

  def set_amt_column(val) do
    [
      val || :empty,
      align_horizontal: :right,
      num_format: "0.00",
      border: [
        bottom: [style: :thin, color: "#ebe8e8"],
        top: [style: :thin, color: "#ebe8e8"],
        right: [style: :thin, color: "#ebe8e8"],
        left: [style: :thin, color: "#ebe8e8"]
      ]
    ]
  end

  def set_centered_column(val) do
    [
      val || :empty,
      align_horizontal: :center,
      border: [
        bottom: [style: :thin, color: "#ebe8e8"],
        top: [style: :thin, color: "#ebe8e8"],
        right: [style: :thin, color: "#ebe8e8"],
        left: [style: :thin, color: "#ebe8e8"]
      ]
    ]
  end

  def empty_columns(max) do
    List.duplicate(
      [
        :empty,
        bold: false,
        border: [
          bottom: [style: :thin, color: "#ebe8e8"],
          top: [style: :thin, color: "#ebe8e8"],
          right: [style: :thin, color: "#ebe8e8"],
          left: [style: :thin, color: "#ebe8e8"]
        ]
      ],
      max
    )
  end

  def gen_page_numbers(pages, current_page) do
    page = current_page - 3

    results =
      1..pages
      |> Enum.to_list()

    if Enum.count(results) > 5 do
      Enum.take(results, current_page + 3)
      |> Enum.map(fn item ->
        if item == current_page || (item > page && item <= pages) do
          item
        else
          nil
        end
      end)
      |> Enum.reject(&(&1 == nil))
    else
      results
    end
  end

  def generate_pagination_details(data) do
    try do
      %{
        page_number: data.page_number || 1,
        page_size: data.page_size || 1,
        total_entries: data.total_entries || 1,
        total_pages: data.total_pages || 1
      }
    rescue
      _ ->
        %{
          page_number: 1,
          page_size: 1,
          total_entries: 1,
          total_pages: 1
        }
    end
  end

  def status_reverse("INACTIVE"), do: "ACTIVE"
  def status_reverse(_), do: "INACTIVE"

  def convert_struct_to_map(struct) do
    struct
    |> Map.from_struct()
  end

  def extract_value(struct, key) do
    if struct && is_struct(struct) do
      convert_struct_to_map(struct)[key]
    else
      ""
    end
  end

  def action_reverse(nil), do: :new
  def action_reverse(_), do: :edit

  def render_parent(data) do
    if data && data.parent do
      data.parent.name
    else
      "-"
    end
  rescue
    _ ->
      "-"
  end

  def render_maker(data) do
    if data && data.maker do
      data.maker.email
    else
      "-"
    end
  rescue
    _ ->
      "-"
  end

  def render_checker(data) do
    if data && data.checker do
      data.checker.email
    else
      "-"
    end
  rescue
    _ ->
      "-"
  end

  def render_user_role(data) do
    if data && data.role do
      data.role.name
    else
      "-"
    end
  rescue
    _ ->
      "-"
  end

  def render_user(data) do
    if data && data.user do
      data.user.email
    else
      "-"
    end
  rescue
    _ ->
      "-"
  end

  def render_customer(data) do
    if data && data.customer do
      data.customer.email
    else
      "-"
    end
  rescue
    _ ->
      "-"
  end

  def render_contact(data) do
    if data && data.contact do
      data.contact.email
    else
      "-"
    end
  rescue
    _ ->
      "-"
  end

  def render_group(data) do
    if data && data.group do
      data.group.name
    else
      "-"
    end
  rescue
    _ ->
      "-"
  end

  def render_category(data) do
    if data && data.category do
      data.category.name
    else
      "-"
    end
  rescue
    _ ->
      "-"
  end

  def render_issue(data) do
    if data && data.issue do
      data.issue.name
    else
      "-"
    end
  rescue
    _ ->
      "-"
  end

  def render_name(data) do
    if data do
      data.name
    else
      "-"
    end
  rescue
    _ ->
      "-"
  end

  def data_by_id(data, ids), do: Enum.filter(data, &Enum.any?(ids, fn i -> &1.id == i end))

  def show_options() do
    [
      "10",
      "20",
      "50",
      "100",
      "500",
      "1000"
    ]
  end

  def default_params do
    %{
      "page" => 1,
      "sort_field" => "inserted_at",
      "sort_order" => "desc",
      "search" => "",
      "date" => "",
      "page_size" => 10
    }
  end

  def selected_column, do: "inserted_at"

  def status(state) do
    if state in ~w(active ACTIVE Active)s do
      """
       <span class="c-pill c-pill--success" >active</span>
      """
    else
      """
       <span class="c-pill c-pill--warning">inactive</span>
      """
    end
  end

  def txn_status(state) do
    if state in ~w(complete COMPLETE success SUCCESS)s do
      """
       <span class="c-pill c-pill--success" >#{String.downcase(state)}</span>
      """
    else
      if state in ~w(PENDING pending)s do
        """
         <span class="c-pill c-pill--warning">#{String.downcase(state)}</span>
        """
      else
        """
         <span class="c-pill c-pill--danger">#{String.downcase(state)}</span>
        """
      end
    end
  end

  def toggle_status(state) do
    if state in ~w(active ACTIVE Active)s do
      "inactive"
    else
      "active"
    end
  end

  def statuses() do
    [
      {"Inactive", "inactive"},
      {"Active", "active"}
    ]
  end



  def extract_email(data) do
    if is_nil(data) == false and is_nil(data.account_users) == false do
      data.account_users.email
    else
      "-"
    end
  end
end
