defmodule MockupBankWeb.CoreComponents.Utilities.CustomTableComponents do
  use Phoenix.Component
  alias MockupBankWeb.Utilities.Pagination
  alias MockupBankWeb.Utilities.Sorting
  import MockupBankWeb.Gettext
  import MockupBankWeb.Utilities.Utils
  import MockupBankWeb.Utilities.Extractors
  @query_params Application.compile_env(:app, :query_params)
  @operators []

  attr :id, :string, required: true
  attr :filter_params, :map, default: @query_params
  attr :pagination, :map
  attr :selected_column, :string, default: "inserted_at"
  attr :list_of_operators, :list, default: @operators
  attr :operator, :string, default: ""
  attr :query_fields_list, :list, default: []
  attr :rows, :list, required: true
  attr :row_id, :any, default: nil, doc: "the function for generating the row id"
  attr :row_click, :any, default: nil, doc: "the function for handling phx-click on each row"

  attr :row_item, :any,
    default: &Function.identity/1,
    doc: "the function for mapping each row before calling the :col and :action slots"

  slot :col, required: true do
    attr :label, :string
    attr :filter_item, :string
  end

  slot :action, doc: "the slot for showing user actions in the last table column"

  def tabular_table(assigns) do
    assigns =
      with %{rows: %Phoenix.LiveView.LiveStream{}} <- assigns do
        assign(assigns, row_id: assigns.row_id || fn {id, _item} -> id end)
      end

    ~H"""
    <!-- BEGIN: HTML Table Data -->
    <div class="intro-y box mt-5 p-5">
      <%= render_tbl_options(assigns) %>
      <div class="scrollbar-hidden overflow-x-auto">
        <div class="overflow-y-auto px-4 sm:overflow-visible sm:px-0">
          <table class="w-[40rem] mt-11 sm:w-full">
            <thead class="text-sm text-left uppercase font-bold bg-secondary/20 leading-6 text-zinc-500">
              <tr>
                <th :for={col <- @col} class="p-3 pb-4 pr-6 font-normal">
                  <span>
                    <a
                      class="flex flex-col sm:flex-row sm:items-end xl:items-start"
                      href={Sorting.table_link_encode_url(@filter_params, col[:filter_item])}
                      data-phx-link="redirect"
                      data-phx-link-state="push"
                    >
                      <span class="sm:mr-auto xl:flex"><%= col[:label] %></span> <%= Phoenix.HTML.raw(
                        icon_def(@filter_params, col[:filter_item], @selected_column)
                      ) %>
                    </a>
                  </span>
                </th>
                
                <th :if={@action != []} class="relative p-0 pb-4">
                  <span class="sr-only"><%= gettext("Actions") %></span>
                </th>
              </tr>
            </thead>
            
            <tbody
              id={@id}
              phx-update={match?(%Phoenix.LiveView.LiveStream{}, @rows) && "stream"}
              class="relative divide-y divide-zinc-100 border-t border-zinc-200 text-sm leading-6 text-zinc-700"
              >
              <tr
                :for={row <- @rows}
                id={@row_id && @row_id.(row)}
                class="group my-1 shadow-inner hover:bg-zinc-50 "
              >
                <td
                  :for={{col, i} <- Enum.with_index(@col)}
                  phx-click={@row_click && @row_click.(row)}
                  class={["relative py-0 px-4", @row_click && "hover:cursor-pointer"]}
                >
                  <div class="block py-4 pr-6">
                    <span class="absolute -inset-y-px right-0 -left-4 group-hover:bg-zinc-50 sm:rounded-l-xl" />
                    <span class={["relative", i == 0 && "font-semibold text-zinc-900"]}>
                      <%= render_slot(col, @row_item.(row)) %>
                    </span>
                  </div>
                </td>
                
                <td :if={@action != []} class="relative w-14 p-0">
                  <div class="relative whitespace-nowrap py-0 text-right text-sm font-medium">
                    <span class="absolute -inset-y-px -right-4 left-0 group-hover:bg-zinc-50 sm:rounded-r-xl" />
                    <span
                      :for={action <- @action}
                      class="relative ml-4 font-semibold leading-6 text-zinc-900 hover:text-zinc-700"
                    >
                      <%= render_slot(action, @row_item.(row)) %>
                    </span>
                  </div>
                </td>
              </tr>
            </tbody>
          </table>
           <%= render_pagination(assigns) %>
        </div>
      </div>
    </div>
    <!-- END: HTML Table Data -->
    """
  end



  attr :id, :string, required: true
  attr :filter_params, :map, default: @query_params
  attr :pagination, :map
  attr :selected_column, :string, default: "inserted_at"
  attr :list_of_operators, :list, default: @operators
  attr :operator, :string, default: ""
  attr :query_fields_list, :list, default: []
  attr :rows, :list, required: true
  attr :row_id, :any, default: nil, doc: "the function for generating the row id"
  attr :row_click, :any, default: nil, doc: "the function for handling phx-click on each row"

  attr :row_item, :any,
    default: &Function.identity/1,
    doc: "the function for mapping each row before calling the :col and :action slots"

  slot :col, required: true do
    attr :label, :string
    attr :filter_item, :string
  end

  slot :action, doc: "the slot for showing user actions in the last table column"

  def tabular_table2(assigns) do
      assigns =
        with %{rows: %Phoenix.LiveView.LiveStream{}} <- assigns do
          assign(assigns, row_id: assigns.row_id || fn {id, _item} -> id end)
        end
        ~H"""
          <div class="mt-5 grid grid-cols-12 gap-6">
            <%= render_tbl_options2(assigns) %>
            <!-- BEGIN: Data List -->
            <div class="intro-y col-span-12 overflow-auto lg:overflow-visible">
                <table data-tw-merge="" class="w-full text-left -mt-2 border-separate border-spacing-y-[10px]">
                    <thead data-tw-merge="" class="">
                        <tr data-tw-merge="" class="">
                          <th :for={col <- @col} class="font-medium px-5 py-3 dark:border-darkmode-300 whitespace-nowrap border-b-0">
                            <span>
                              <a
                                class="flex flex-col sm:flex-row sm:items-end xl:items-start"
                                href={Sorting.table_link_encode_url(@filter_params, col[:filter_item])}
                                data-phx-link="redirect"
                                data-phx-link-state="push"
                              >
                                <span class="sm:mr-auto xl:flex"><%= col[:label] %></span> <%= Phoenix.HTML.raw(
                                  icon_def(@filter_params, col[:filter_item], @selected_column)
                                ) %>
                              </a>
                            </span>
                          </th>
                        </tr>
                    </thead>
                    <tbody id={@id}
                      phx-update={match?(%Phoenix.LiveView.LiveStream{}, @rows) && "stream"} >
                        <tr 
                            :for={row <- @rows}
                            id={@row_id && @row_id.(row)} data-tw-merge="" class="intro-x">
                            <td 
                              :for={{col, _i} <- Enum.with_index(@col)}
                              phx-click={@row_click && @row_click.(row)}
                              class={["px-5 py-3 w-40 border border-l-0 border-r-0 border-slate-200 bg-white shadow-[20px_3px_20px_#0000000b] first:rounded-l-[0.6rem] first:border-l last:rounded-r-[0.6rem] last:border-r dark:border-darkmode-600 dark:bg-darkmode-600", @row_click && "hover:cursor-pointer"]}
                              data-tw-merge="" >
                              <a class="whitespace-nowrap font-medium" href="">
                                <%= render_slot(col, @row_item.(row)) %>
                              </a>
                            </td>
                            <td :if={@action != []} class="relative w-14 p-0">
                                <div class="relative whitespace-nowrap py-0 text-right text-sm font-medium">
                                  <span class="absolute -inset-y-px -right-4 left-0 group-hover:bg-zinc-50 sm:rounded-r-xl" />
                                  <span
                                    :for={action <- @action}
                                    class="relative ml-4 font-semibold leading-6 text-zinc-900 hover:text-zinc-700"
                                  >
                                    <%= render_slot(action, @row_item.(row)) %>
                                  </span>
                                </div>
                            </td>
                        </tr>
                    </tbody>
                </table>
                <%= render_pagination(assigns) %>

            </div>
            <!-- END: Data List -->

          </div>
        """ 
  end









  attr :id, :string, required: true
  attr :filter_params, :map, default: @query_params
  attr :pagination, :map
  attr :selected_column, :string, default: "inserted_at"
  attr :list_of_operators, :list, default: @operators
  attr :operator, :string, default: ""
  attr :query_fields_list, :list, default: []
  attr :rows, :list, required: true
  attr :row_id, :any, default: nil, doc: "the function for generating the row id"
  attr :row_click, :any, default: nil, doc: "the function for handling phx-click on each row"

  attr :row_item, :any,
       default: &Function.identity/1,
       doc: "the function for mapping each row before calling the :col and :action slots"

  slot :col, required: true do
    attr :label, :string
    attr :filter_item, :string
  end

  slot :action, doc: "the slot for showing user actions in the last table column"

  def tabular_table3(assigns) do
    assigns =
      with %{rows: %Phoenix.LiveView.LiveStream{}} <- assigns do
        assign(assigns, row_id: assigns.row_id || fn {id, _item} -> id end)
      end
    ~H"""
      <div class="mt-5 grid grid-cols-12 gap-6">
        <%= render_tbl_options2(assigns) %>
        <!-- BEGIN: Data List -->
        <div class="intro-y col-span-12 overflow-auto lg:overflow-visible">
            <table data-tw-merge="" class="w-full text-left -mt-2 border-separate border-spacing-y-[10px]">
                <thead data-tw-merge="" class="">
                    <tr data-tw-merge="" class="">
                      <th :for={col <- @col} class="font-medium px-5 py-3 dark:border-darkmode-300 whitespace-nowrap border-b-0">
                        <span>
                          <a
                            class="flex flex-col sm:flex-row sm:items-end xl:items-start"
                            href={Sorting.table_link_encode_url(@filter_params, col[:filter_item])}
                            data-phx-link="redirect"
                            data-phx-link-state="push"
                          >
                            <span class="sm:mr-auto xl:flex"><%= col[:label] %></span> <%= Phoenix.HTML.raw(
                              icon_def(@filter_params, col[:filter_item], @selected_column)
                            ) %>
                          </a>
                        </span>
                      </th>
                    </tr>
                </thead>
                <tbody id={@id}
                  phx-update={match?(%Phoenix.LiveView.LiveStream{}, @rows) && "stream"} >
                    <tr
                        :for={row <- @rows}
                        id={@row_id && @row_id.(row)} data-tw-merge="" class="intro-x">
                        <td
                          :for={{col, _i} <- Enum.with_index(@col)}
                          phx-click={@row_click && @row_click.(row)}
                          class={["px-5 py-3 w-40 border border-l-0 border-r-0 border-slate-200 bg-white shadow-[20px_3px_20px_#0000000b] first:rounded-l-[0.6rem] first:border-l last:rounded-r-[0.6rem] last:border-r dark:border-darkmode-600 dark:bg-darkmode-600", @row_click && "hover:cursor-pointer"]}
                          data-tw-merge="" >
                          <a class="whitespace-nowrap font-medium" href="">
                            <%= render_slot(col, @row_item.(row)) %>
                          </a>
                        </td>
                        <td :if={@action != []} class="relative w-14 p-0">
                            <div class="relative whitespace-nowrap py-0 text-right text-sm font-medium">
                              <span class="absolute -inset-y-px -right-4 left-0 group-hover:bg-zinc-50 sm:rounded-r-xl" />
                              <span
                                :for={action <- @action}
                                class="relative ml-4 font-semibold leading-6 text-zinc-900 hover:text-zinc-700"
                              >
                                <%= render_slot(action, @row_item.(row)) %>
                              </span>
                            </div>
                        </td>
                    </tr>
                </tbody>
            </table>
            <%= render_pagination(assigns) %>

        </div>
        <!-- END: Data List -->

      </div>
    """
  end










  attr :id, :string, required: true
  attr :filter_params, :map, default: @query_params
  attr :selected_column, :string, default: "inserted_at"
  attr :list_of_operators, :list, default: @operators
  attr :operator, :string, default: ""
  attr :query_fields_list, :list, default: []

  defp render_tbl_options(assigns) do
    ~H"""
    <div class="flex flex-col sm:flex-row sm:items-end xl:items-start">
      <form phx-submit="run_query_filter" class="sm:mr-auto xl:flex" id="tabulator-html-filter-form">
        <div class="items-center sm:mr-4 sm:flex">
          <label class="mr-2 w-12 flex-none xl:w-auto xl:flex-initial">
            Field
          </label>
          
          <select
            data-tw-merge=""
            name="query_field"
            id="tabulator-html-filter-field"
            class="disabled:bg-slate-100 disabled:cursor-not-allowed disabled:dark:bg-darkmode-800/50 [&[readonly]]:bg-slate-100 [&[readonly]]:cursor-not-allowed [&[readonly]]:dark:bg-darkmode-800/50 transition duration-200 ease-in-out w-full text-sm border-slate-200 shadow-sm rounded-md py-2 px-3 pr-8 focus:ring-4 focus:ring-primary focus:ring-opacity-20 focus:border-primary focus:border-opacity-40 dark:bg-darkmode-800 dark:border-transparent dark:focus:ring-slate-700 dark:focus:ring-opacity-50 group-[.form-inline]:flex-1 mt-2 sm:mt-0 sm:w-auto 2xl:w-full"
          >
            <%= for item <- @query_fields_list do %>
              <%= if get_query_field(@filter_params) == item do %>
                <option value={item} selected><%= item %></option>
              <% else %>
                <option value={item}><%= item %></option>
              <% end %>
            <% end %>
          </select>
        </div>
        
        <div class="mt-2 items-center sm:mr-4 sm:flex xl:mt-0">
          <label class="mr-2 w-12 flex-none xl:w-auto xl:flex-initial">
            Type
          </label>
          
          <select
            data-tw-merge=""
            name="operator"
            id="tabulator-html-filter-type"
            class="disabled:bg-slate-100 disabled:cursor-not-allowed disabled:dark:bg-darkmode-800/50 [&[readonly]]:bg-slate-100 [&[readonly]]:cursor-not-allowed [&[readonly]]:dark:bg-darkmode-800/50 transition duration-200 ease-in-out w-full text-sm border-slate-200 shadow-sm rounded-md py-2 px-3 pr-8 focus:ring-4 focus:ring-primary focus:ring-opacity-20 focus:border-primary focus:border-opacity-40 dark:bg-darkmode-800 dark:border-transparent dark:focus:ring-slate-700 dark:focus:ring-opacity-50 group-[.form-inline]:flex-1 mt-2 sm:mt-0 sm:w-auto"
          >
            <%= for item <- @list_of_operators do %>
              <%= if get_operator(@filter_params) == item do %>
                <option value={item} selected><%= item %></option>
              <% else %>
                <option value={item}><%= item %></option>
              <% end %>
            <% end %>
          </select>
        </div>
        
        <div class="mt-2 items-center sm:mr-4 sm:flex xl:mt-0">
          <label class="mr-2 w-12 flex-none xl:w-auto xl:flex-initial">
            Value
          </label>
          
          <input
            data-tw-merge=""
            name="query_search"
            value={get_query_search(@filter_params)}
            id="tabulator-html-filter-value"
            type="text"
            placeholder="Search..."
            class="disabled:bg-slate-100 disabled:cursor-not-allowed dark:disabled:bg-darkmode-800/50 dark:disabled:border-transparent [&[readonly]]:bg-slate-100 [&[readonly]]:cursor-not-allowed [&[readonly]]:dark:bg-darkmode-800/50 [&[readonly]]:dark:border-transparent transition duration-200 ease-in-out w-full text-sm border-slate-200 shadow-sm rounded-md placeholder:text-slate-400/90 focus:ring-4 focus:ring-primary focus:ring-opacity-20 focus:border-primary focus:border-opacity-40 dark:bg-darkmode-800 dark:border-transparent dark:focus:ring-slate-700 dark:focus:ring-opacity-50 dark:placeholder:text-slate-500/80 [&[type='file']]:border file:mr-4 file:py-2 file:px-4 file:rounded-l-md file:border-0 file:border-r-[1px] file:border-slate-100/10 file:text-sm file:font-semibold file:bg-slate-100 file:text-slate-500/70 hover:file:bg-200 group-[.form-inline]:flex-1 group-[.input-group]:rounded-none group-[.input-group]:[&:not(:first-child)]:border-l-transparent group-[.input-group]:first:rounded-l group-[.input-group]:last:rounded-r group-[.input-group]:z-10 mt-2 sm:mt-0 sm:w-40 2xl:w-full"
          />
        </div>
        
        <div class="mt-2 xl:mt-0">
          <button
            data-tw-merge=""
            id="tabulator-html-filter-go"
            type="button"
            class="transition duration-200 border shadow-sm inline-flex items-center justify-center py-2 px-3 rounded-md font-medium cursor-pointer focus:ring-4 focus:ring-primary focus:ring-opacity-20 focus-visible:outline-none dark:focus:ring-slate-700 dark:focus:ring-opacity-50 [&:hover:not(:disabled)]:bg-opacity-90 [&:hover:not(:disabled)]:border-opacity-90 [&:not(button)]:text-center disabled:opacity-70 disabled:cursor-not-allowed bg-primary border-primary text-white dark:border-primary w-full sm:w-16"
          >
            Go
          </button>
        </div>
      </form>
      
      <div class="mt-5 flex sm:mt-0">
        <button
          data-tw-merge=""
          id="tabulator-print"
          class="transition duration-200 border shadow-sm inline-flex items-center justify-center py-2 px-3 rounded-md font-medium cursor-pointer focus:ring-4 focus:ring-primary focus:ring-opacity-20 focus-visible:outline-none dark:focus:ring-slate-700 dark:focus:ring-opacity-50 [&:hover:not(:disabled)]:bg-opacity-90 [&:hover:not(:disabled)]:border-opacity-90 [&:not(button)]:text-center disabled:opacity-70 disabled:cursor-not-allowed border-secondary text-slate-500 dark:border-darkmode-100/40 dark:text-slate-300 [&:hover:not(:disabled)]:bg-secondary/20 [&:hover:not(:disabled)]:dark:bg-darkmode-100/10 mr-2 w-1/2 sm:w-auto"
        >
          <i data-tw-merge="" data-lucide="printer" class="stroke-[1] mr-2 h-4 w-4"></i> Print
        </button>
        <div data-tw-merge="" data-tw-placement="bottom-end" class="dropdown relative w-1/2 sm:w-auto">
          <button
            data-tw-merge=""
            data-tw-toggle="dropdown"
            aria-expanded="false"
            class="transition duration-200 border shadow-sm inline-flex items-center justify-center py-2 px-3 rounded-md font-medium cursor-pointer focus:ring-4 focus:ring-primary focus:ring-opacity-20 focus-visible:outline-none dark:focus:ring-slate-700 dark:focus:ring-opacity-50 [&:hover:not(:disabled)]:bg-opacity-90 [&:hover:not(:disabled)]:border-opacity-90 [&:not(button)]:text-center disabled:opacity-70 disabled:cursor-not-allowed border-secondary text-slate-500 dark:border-darkmode-100/40 dark:text-slate-300 [&:hover:not(:disabled)]:bg-secondary/20 [&:hover:not(:disabled)]:dark:bg-darkmode-100/10 w-full sm:w-auto"
          >
            <i data-tw-merge="" data-lucide="file-text" class="stroke-[1] mr-2 h-4 w-4"></i>
            Export
            <i data-tw-merge="" data-lucide="chevron-down" class="stroke-[1] ml-auto h-4 w-4 sm:ml-2">
            </i>
          </button>
          <div
            data-transition=""
            data-selector=".show"
            data-enter="transition-all ease-linear duration-150"
            data-enter-from="absolute !mt-5 invisible opacity-0 translate-y-1"
            data-enter-to="!mt-1 visible opacity-100 translate-y-0"
            data-leave="transition-all ease-linear duration-150"
            data-leave-from="!mt-1 visible opacity-100 translate-y-0"
            data-leave-to="absolute !mt-5 invisible opacity-0 translate-y-1"
            class="dropdown-menu absolute z-[9999] hidden"
          >
            <div
              data-tw-merge=""
              class="dropdown-content rounded-md border-transparent bg-white p-2 shadow-[0px_3px_10px_#00000017] dark:border-transparent dark:bg-darkmode-600 w-40"
            >
              <a
                id="tabulator-export-csv"
                class="cursor-pointer flex items-center p-2 transition duration-300 ease-in-out rounded-md hover:bg-slate-200/60 dark:bg-darkmode-600 dark:hover:bg-darkmode-400 dropdown-item"
              >
                <i data-tw-merge="" data-lucide="file-text" class="stroke-[1] mr-2 h-4 w-4"></i>
                Export CSV
              </a>
              <a
                id="tabulator-export-json"
                class="cursor-pointer flex items-center p-2 transition duration-300 ease-in-out rounded-md hover:bg-slate-200/60 dark:bg-darkmode-600 dark:hover:bg-darkmode-400 dropdown-item"
              >
                <i data-tw-merge="" data-lucide="file-text" class="stroke-[1] mr-2 h-4 w-4"></i>
                Export
                JSON
              </a>
              <a
                id="tabulator-export-xlsx"
                class="cursor-pointer flex items-center p-2 transition duration-300 ease-in-out rounded-md hover:bg-slate-200/60 dark:bg-darkmode-600 dark:hover:bg-darkmode-400 dropdown-item"
              >
                <i data-tw-merge="" data-lucide="file-text" class="stroke-[1] mr-2 h-4 w-4"></i>
                Export
                XLSX
              </a>
              <a
                id="tabulator-export-html"
                class="cursor-pointer flex items-center p-2 transition duration-300 ease-in-out rounded-md hover:bg-slate-200/60 dark:bg-darkmode-600 dark:hover:bg-darkmode-400 dropdown-item"
              >
                <i data-tw-merge="" data-lucide="file-text" class="stroke-[1] mr-2 h-4 w-4"></i>
                Export
                HTML
              </a>
            </div>
          </div>
        </div>
      </div>
    </div>
    """
  end

  attr :id, :string, required: true
  attr :filter_params, :map, default: @query_params
  attr :selected_column, :string, default: "inserted_at"
  attr :list_of_operators, :list, default: @operators
  attr :operator, :string, default: ""
  attr :query_fields_list, :list, default: []

  defp render_tbl_options2(assigns) do
    ~H"""
            <div class="intro-y col-span-12 mt-2 flex flex-wrap items-center sm:flex-nowrap">
                      <div data-tw-merge="" data-tw-placement="bottom-end" class="dropdown relative"><button data-tw-merge="" data-tw-toggle="dropdown" aria-expanded="false" class="transition duration-200 border shadow-sm inline-flex items-center justify-center py-2 rounded-md font-medium cursor-pointer focus:ring-4 focus:ring-primary focus:ring-opacity-20 focus-visible:outline-none dark:focus:ring-slate-700 dark:focus:ring-opacity-50 [&:hover:not(:disabled)]:bg-opacity-90 [&:hover:not(:disabled)]:border-opacity-90 [&:not(button)]:text-center disabled:opacity-70 disabled:cursor-not-allowed box px-2"><span class="flex h-5 w-5 items-center justify-center">
                                  <i data-tw-merge="" data-lucide="plus" class="stroke-[1] h-4 w-4"></i>
                              </span></button>
                          <div data-transition="" data-selector=".show" data-enter="transition-all ease-linear duration-150" data-enter-from="absolute !mt-5 invisible opacity-0 translate-y-1" data-enter-to="!mt-1 visible opacity-100 translate-y-0" data-leave="transition-all ease-linear duration-150" data-leave-from="!mt-1 visible opacity-100 translate-y-0" data-leave-to="absolute !mt-5 invisible opacity-0 translate-y-1" class="dropdown-menu absolute z-[9999] hidden">
                              <div data-tw-merge="" class="dropdown-content rounded-md border-transparent bg-white p-2 shadow-[0px_3px_10px_#00000017] dark:border-transparent dark:bg-darkmode-600 w-44">
                                  <a class="cursor-pointer flex items-center p-2 transition duration-300 ease-in-out rounded-md hover:bg-slate-200/60 dark:bg-darkmode-600 dark:hover:bg-darkmode-400 dropdown-item"><i data-tw-merge="" data-lucide="printer" class="stroke-[1] mr-2 h-4 w-4"></i>
                                      Print</a>
                                  <a class="cursor-pointer flex items-center p-2 transition duration-300 ease-in-out rounded-md hover:bg-slate-200/60 dark:bg-darkmode-600 dark:hover:bg-darkmode-400 dropdown-item"><i data-tw-merge="" data-lucide="file-text" class="stroke-[1] mr-2 h-4 w-4"></i>
                                      Export to Excel</a>
                                  <a class="cursor-pointer flex items-center p-2 transition duration-300 ease-in-out rounded-md hover:bg-slate-200/60 dark:bg-darkmode-600 dark:hover:bg-darkmode-400 dropdown-item"><i data-tw-merge="" data-lucide="file-text" class="stroke-[1] mr-2 h-4 w-4"></i>
                                      Export to PDF</a>
                              </div>
                          </div>
                      </div>
                      <div class="mx-auto hidden text-slate-500 md:block">Showing 1 to 10 of 150 entries</div>
                      <div class="mt-3 w-full sm:ml-auto sm:mt-0 sm:w-auto md:ml-0">
                          <div class="relative w-56 text-slate-500">
                              <input data-tw-merge="" type="text" placeholder="Search..." class="disabled:bg-slate-100 disabled:cursor-not-allowed dark:disabled:bg-darkmode-800/50 dark:disabled:border-transparent [&[readonly]]:bg-slate-100 [&[readonly]]:cursor-not-allowed [&[readonly]]:dark:bg-darkmode-800/50 [&[readonly]]:dark:border-transparent transition duration-200 ease-in-out text-sm border-slate-200 shadow-sm rounded-md placeholder:text-slate-400/90 focus:ring-4 focus:ring-primary focus:ring-opacity-20 focus:border-primary focus:border-opacity-40 dark:bg-darkmode-800 dark:border-transparent dark:focus:ring-slate-700 dark:focus:ring-opacity-50 dark:placeholder:text-slate-500/80 [&[type='file']]:border file:mr-4 file:py-2 file:px-4 file:rounded-l-md file:border-0 file:border-r-[1px] file:border-slate-100/10 file:text-sm file:font-semibold file:bg-slate-100 file:text-slate-500/70 hover:file:bg-200 group-[.form-inline]:flex-1 group-[.input-group]:rounded-none group-[.input-group]:[&:not(:first-child)]:border-l-transparent group-[.input-group]:first:rounded-l group-[.input-group]:last:rounded-r group-[.input-group]:z-10 box w-56 pr-10">
                              <i data-tw-merge="" data-lucide="search" class="stroke-[1] absolute inset-y-0 right-0 my-auto mr-3 h-4 w-4"></i>
                          </div>
                      </div>
            </div>
    """
  end

  defp render_pagination(assigns) do
    ~H"""
    <!-- BEGIN: Pagination -->
    <div class="intro-y mb-12 mt-5 flex flex-wrap items-center sm:flex-row sm:flex-nowrap">
      <nav class="w-full ml-2 sm:mr-auto sm:w-auto">
        <ul class="flex w-full mr-0 sm:mr-auto sm:w-auto">
          <%= if @pagination[:page_number] > 1 do %>
            <li class="flex-1 sm:flex-initial">
              <a
                href={Pagination.get_priv_pagination_link(@pagination, @filter_params)}
                data-phx-link="redirect"
                data-phx-link-state="push"
                data-tw-merge=""
                class="transition duration-200 border items-center justify-center py-2 rounded-md cursor-pointer focus:ring-4 focus:ring-primary focus:ring-opacity-20 focus-visible:outline-none dark:focus:ring-slate-700 dark:focus:ring-opacity-50 [&:hover:not(:disabled)]:bg-opacity-90 [&:hover:not(:disabled)]:border-opacity-90 [&:not(button)]:text-center disabled:opacity-70 disabled:cursor-not-allowed min-w-0 sm:min-w-[40px] shadow-none font-normal flex border-transparent text-slate-800 sm:mr-2 dark:text-slate-300 px-1 sm:px-3"
              >
                <svg
                  xmlns="http://www.w3.org/2000/svg"
                  fill="none"
                  viewBox="0 0 24 24"
                  stroke-width="1.5"
                  stroke="currentColor"
                  class="size-4"
                >
                  <path
                    stroke-linecap="round"
                    stroke-linejoin="round"
                    d="m18.75 4.5-7.5 7.5 7.5 7.5m-6-15L5.25 12l7.5 7.5"
                  />
                </svg>
              </a>
            </li>
          <% end %>
          
          <%= for number <- gen_page_numbers(@pagination.total_pages, @pagination.page_number) do %>
            <%= if @pagination[:page_number] == number do %>
              <li class="flex-1 sm:flex-initial">
                <a
                  data-tw-merge=""
                  class="transition duration-200 border items-center justify-center py-2
                                             rounded-md cursor-pointer focus:ring-4 focus:ring-primary focus:ring-opacity-20 focus-visible:outline-none
                                              dark:focus:ring-slate-700 dark:focus:ring-opacity-50 [&:hover:not(:disabled)]:bg-opacity-90
                                               [&:hover:not(:disabled)]:border-opacity-90 [&:not(button)]:text-center disabled:opacity-70 
                                               disabled:cursor-not-allowed min-w-0 sm:min-w-[40px] shadow-none font-normal flex 
                                               border-transparent text-slate-800 sm:mr-2 dark:text-slate-300 px-1 sm:px-3 !box dark:bg-darkmode-400"
                >
                  <%= number %>
                </a>
              </li>
            <% else %>
              <li class="flex-1 sm:flex-initial">
                <a
                  href={Pagination.get_number_pagination_link(number, @filter_params)}
                  data-phx-link="redirect"
                  data-phx-link-state="push"
                  data-tw-merge=""
                  class="transition duration-200 border items-center justify-center py-2 rounded-md cursor-pointer focus:ring-4 focus:ring-primary focus:ring-opacity-20 focus-visible:outline-none dark:focus:ring-slate-700 dark:focus:ring-opacity-50 [&:hover:not(:disabled)]:bg-opacity-90 [&:hover:not(:disabled)]:border-opacity-90 [&:not(button)]:text-center disabled:opacity-70 disabled:cursor-not-allowed min-w-0 sm:min-w-[40px] shadow-none font-normal flex border-transparent text-slate-800 sm:mr-2 dark:text-slate-300 px-1 sm:px-3"
                >
                  <%= number %>
                </a>
              </li>
            <% end %>
          <% end %>
          
          <%= if @pagination[:page_number] < @pagination.total_pages do %>
            <li class="flex-1 sm:flex-initial">
              <a
                href={Pagination.get_next_pagination_link(@pagination, @filter_params)}
                data-phx-link="redirect"
                data-phx-link-state="push"
                data-tw-merge=""
                class="transition duration-200 border items-center justify-center py-2 rounded-md cursor-pointer focus:ring-4 focus:ring-primary focus:ring-opacity-20 focus-visible:outline-none dark:focus:ring-slate-700 dark:focus:ring-opacity-50 [&:hover:not(:disabled)]:bg-opacity-90 [&:hover:not(:disabled)]:border-opacity-90 [&:not(button)]:text-center disabled:opacity-70 disabled:cursor-not-allowed min-w-0 sm:min-w-[40px] shadow-none font-normal flex border-transparent text-slate-800 sm:mr-2 dark:text-slate-300 px-1 sm:px-3"
              >
                <svg
                  xmlns="http://www.w3.org/2000/svg"
                  fill="none"
                  viewBox="0 0 24 24"
                  stroke-width="1.5"
                  stroke="currentColor"
                  class="size-4"
                >
                  <path
                    stroke-linecap="round"
                    stroke-linejoin="round"
                    d="m5.25 4.5 7.5 7.5-7.5 7.5m6-15 7.5 7.5-7.5 7.5"
                  />
                </svg>
              </a>
            </li>
          <% end %>
        </ul>
      </nav>
      
      <form>
        <select
          name="page_size"
          phx-change="page_size"
          data-tw-merge=""
          class="disabled:bg-slate-100 disabled:cursor-not-allowed disabled:dark:bg-darkmode-800/50 [&[readonly]]:bg-slate-100 [&[readonly]]:cursor-not-allowed [&[readonly]]:dark:bg-darkmode-800/50 transition duration-200 ease-in-out text-sm border-slate-200 shadow-sm rounded-md py-2 px-3 pr-8 focus:ring-4 focus:ring-primary focus:ring-opacity-20 focus:border-primary focus:border-opacity-40 dark:bg-darkmode-800 dark:border-transparent dark:focus:ring-slate-700 dark:focus:ring-opacity-50 group-[.form-inline]:flex-1 !box mt-3 w-20 sm:mt-0"
        >
          <%= for size <- show_options() do %>
            <%= if size == @filter_params["page_size"] do %>
              <option selected><%= size %></option>
            <% else %>
              <option><%= size %></option>
            <% end %>
          <% end %>
        </select>
      </form>
    </div>
    <!-- END: Pagination -->
    """
  end

  defp icon_def(filter_params, filter_item, selected_column) do
    if filter_item == selected_column do
      if filter_params["sort_order"] == "asc" do
        ~s(
                <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-6 h-6 p-1 text-black">
                  <path stroke-linecap="round" stroke-linejoin="round" d="m4.5 15.75 7.5-7.5 7.5 7.5" />
                </svg>
                )
      else
        ~s(<svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-6 h-6 p-1 text-black">
                <path stroke-linecap="round" stroke-linejoin="round" d="m19.5 8.25-7.5 7.5-7.5-7.5" />
              </svg>
              )
      end
    else
      ~s(
          <div class="text-zinc-200">
            <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-6 h-6">
              <path stroke-linecap="round" stroke-linejoin="round" d="M8.25 15 12 18.75 15.75 15m-7.5-6L12 5.25 15.75 9" />
            </svg>
          </div>)
    end
  end
end
