defmodule Issues.GithubIssues do
@user_agent [{"User-agent", "Elixir dave@pragprog.com"}]

  def fetch(user,project) do
    issues_url(user,project)
    |> HTTPoison.get(@user_agent)
    |> handle_response
  end    

  def handle_response( { :ok, %{ status_code: 200 , body: body } } ) do
	{ :ok, Poison.Parser.parse!(body) }
  end

  def handle_response( { :error, %{ status_code: _ , body: body } } ) do
	{ :error, Poison.Parser.parse!(body) }
  end

  # use a module attr to fetch the env vlaue at compile time
  @github_url Application.get_env(:issues, :github_url)

  def issues_url(user, project) do
    "#{@github_url}/repos/#{user}/#{project}/issues"
  end

end