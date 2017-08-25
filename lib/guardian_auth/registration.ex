defmodule GuardianAuth.Registration do

  def create(changeset, repo) do
    changeset
    |> repo.insert()  # this inserts user into database and returns {:ok,user}
  end
end
