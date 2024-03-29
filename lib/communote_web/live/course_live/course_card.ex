defmodule CommunoteWeb.Live.CourseLive.CourseCard do
    use CommunoteWeb, :live_component

    def render(assigns) do
      ~L"""
      <li class=""
        id={"course-#{course.id}"}
        >
            <%= live_redirect to: Routes.note_index_path(@socket, :index, assigns.course.code), class: "w-full p-8 inline-block rounded-lg shadow overflow-hidden h-full hover:shadow-lg transform hover:scale-105 transition duration-300
            bg-white dark:bg-gray-800 dark:text-white" do %>
                <div class="h-full flex flex-col justify-between">
                    <h2 class="text-2xl font-bold"><%= assigns.course.title %></h2>
                    <div class="flex justify-between text-sm font-semibold mt-2 text-purple-800 dark:text-green-600">
                        <p>
                            <i class="fas fa-book"></i>
                            <span><%= assigns.course.code %></span>
                        </p>
                        <p>
                            <%= assigns.course.note_count %> note<%= if assigns.course.note_count > 1 do "s" end %>
                        </p>
                    </div>
                </div>
            <% end %>
        </li>
      """
    end
end
