defmodule Communote.Repo.Migrations.CreateCoursesFTS do
  use Ecto.Migration

  def up do
    execute """
      ALTER TABLE courses
        ADD COLUMN document tsvector
    """
    execute """
      CREATE FUNCTION courses_tsvector_trigger() RETURNS trigger AS $$
      begin
        new.document := setweight(to_tsvector(new.code), 'A')
                        || setweight(to_tsvector('english', new.title) || to_tsvector('french', new.title), 'B');
        return new;
      end
      $$ LANGUAGE plpgsql
    """
    execute """
      CREATE TRIGGER tsvectorupdate BEFORE INSERT OR UPDATE
      ON courses FOR EACH ROW EXECUTE PROCEDURE courses_tsvector_trigger()
    """
    execute """
      CREATE INDEX document_index
        ON courses
        USING GIN (document)
    """
  end

  def down do
    execute """
        DROP INDEX document_index
    """

    execute """
        DROP TRIGGER tsvectorupdate on courses
    """

    execute """
        DROP FUNCTION courses_tsvector_trigger()
    """

    execute """
      ALTER TABLE courses
        DROP COLUMN document
    """
  end

end
