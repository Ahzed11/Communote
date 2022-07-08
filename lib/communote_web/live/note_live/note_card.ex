defmodule CommunoteWeb.Live.NoteLive.NoteCard do
  use CommunoteWeb, :live_component

  def render(%{note: note} = assigns) do
    ~L"""
    <li class="rounded-lg shadow overflow-hidden h-full hover:shadow-lg transform hover:scale-105 transition duration-300
           bg-white dark:bg-gray-800">
        <%= live_redirect to: Routes.note_show_path(@socket, :show, note.slug), class: "h-full" do %>
            <div class="p-8 flex flex-col justify-between h-full">
                <div>
                    <h2 class="text-2xl font-bold truncate"><%= note.title %>z</h2>
                    <div class="text-purple-800 dark:text-green-600 text-sm font-medium flex mb-4">
                        <span>
                            <%= note.user.first_name %> <%= note.user.last_name %>
                        </span>
                    </div>
                </div>

                <p class="break-words text-justify">
                    <%= note.small_description %>
                </p>

                <div class="mt-10 flex justify-between items-center">
                    <span class="mr-4 text-purple-800 dark:text-green-600">
                        <i class="fas fa-clock mr-1"></i>
                        <%= note.inserted_at |> Timex.from_now %>
                    </span>
                </div>
            </div>
        <% end %>
    </li>
    """
  end
end
