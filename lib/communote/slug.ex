defmodule Communote.Slug do
  import Ecto.Changeset

  def generate_slug(changeset, text, list_function, get_function) do
    case get_field(changeset, :id) do
      nil -> case text do
        nil -> add_error(changeset, :slug, "Text to slugify is empty")
        text -> slug = Slug.slugify(text, truncate: 30)
          elements = list_function.(slug)
          case elements do
            [] -> put_change(changeset, :slug, slug)
            [e] -> parsed = Integer.parse(String.last(e.slug))
              case parsed do
                {x, ""} -> put_change(changeset, :slug, slug<>Integer.to_string(x+1))
                _ -> put_change(changeset, :slug, slug<>"-"<>Integer.to_string(1))
              end
          end
        end
      id -> prev_slug = get_function.(id).slug
        put_change(changeset, :slug, prev_slug)
    end
  end
end
