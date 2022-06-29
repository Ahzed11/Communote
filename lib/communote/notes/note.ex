defmodule Communote.Notes.Note do
  use Ecto.Schema
  import Ecto.Changeset
  alias Communote.Accounts.User
  alias Communote.Courses.Course
  alias Communote.Years.Year
  alias Communote.Notes

  schema "notes" do
    field :description, :string
    field :slug, :string
    field :small_description, :string
    field :title, :string
    field :course_search, :string, virtual: true
    belongs_to(:user, User)
    belongs_to(:course, Course)
    belongs_to(:year, Year)

    timestamps()
  end

  @doc false
  def changeset(note, attrs) do
    note
    |> cast(attrs, [:title, :description, :small_description, :user_id, :course_id, :year_id, :course_search])
    |> generate_slug()
    |> validate_required([:title, :description, :small_description, :slug, :user_id, :course_id, :year_id])
    |> unique_constraint(:slug)
  end

  def generate_slug(changeset) do
    case get_field(changeset, :id) do
      nil -> case get_field(changeset, :title) do
        nil -> add_error(changeset, :slug, "No title")
        title -> slug = Slug.slugify(title, truncate: 30)
          note = Notes.list_notes_by_slug(slug)
          case note do
            [] -> put_change(changeset, :slug, slug)
            [e] -> parsed = Integer.parse(String.last(e.slug))
              case parsed do
                {x, ""} -> put_change(changeset, :slug, slug<>Integer.to_string(x+1))
                _ -> put_change(changeset, :slug, slug<>"-"<>Integer.to_string(1))
              end
          end
        end
      id -> prev_slug = Notes.get_note!(id).slug
        put_change(changeset, :slug, prev_slug)
    end
  end

end
