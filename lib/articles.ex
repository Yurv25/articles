defmodule Articles do
  @moduledoc """
  Documentation for Articles.
  """
  #This program runs an api which contains articles and display its details. 
  @doc """
  Hello world.

  ## Examples

      iex> Articles.hello()
      :world

  """
  def read_articles do
    try do
      key = "32d5a5dd7349284c35bf1b78a3151a07"
      token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczovL2FwcC5lbGV2aW8tc3RhZ2luZy5jb20iLCJzdWIiOiI1ZDEyY2JjMDg4ODM1IiwiZXhwIjozMTM4NDQzMjM0LCJpYXQiOjE1NjE2NDMyMzQsImp0aSI6IjE2ZmtpY2pjam10ZGNiZW9mdHQ2NW1sZDlqZnNoYWZyIiwKICAidXNlck5hbWUiIDogInl1cmlhbGVqYW5kcm8udmFsdmVyZGVAZ21haWwuY29tIiwKICAidXNlcklkIiA6IDEzMDM1LAogICJzY29wZSIgOiBbICJyZWFkOmFydGljbGUiIF0KfQ.f-bmbNOkdlCmck0nUrjmjnqLNrSuro4C55H-qLtNlZA"
      url = "https://api.elevio-staging.com/v1/articles?page=1&status=published"
      headers = ["Authorization": "Bearer #{token}", "Accept": "Application/json; Charset=utf-8", "x-api-key": "#{key}"]
      
      IO.puts("********** Page number: 1 *************")
      
      response = HTTPoison.get!(url,headers);
      req = Poison.decode!(response.body)
      total_pages = req["total_pages"]
      articles= (req["articles"])
      IO.inspect(articles)
      #Paginate through all the pages
      if total_pages > 1 do
        Enum.each(2..total_pages, fn(x) ->
          IO.puts("********** Page number: #{x} *************")
          response = HTTPoison.get!("https://api.elevio-staging.com/v1/articles?page=#{x}&status=published",headers);
          req = Poison.decode!(response.body)
          articles= (req["articles"])
          IO.inspect(articles)
        end)
      end 
      #ask for input from the user and search for the article
      input = IO.gets("Enter a keyword to search and press ENTER: ")
      keyword = String.replace(input,"\n","")
      search_url =  "https://api.elevio-staging.com/v1/search/en?query=#{keyword}"
      srch_resp =HTTPoison.get!(search_url,headers);
      srch_req = Poison.decode!(srch_resp.body)
      results = (srch_req["results"])
      IO.inspect (results)
      IO.puts "Final Results"
      
      raise "Article can't be read!"
    rescue
      e in RuntimeError -> IO.puts("An error occurred: " <> e.message)
    end
  end

  #Display a single article details
  def single_article(id) do
    key = "32d5a5dd7349284c35bf1b78a3151a07"
    token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczovL2FwcC5lbGV2aW8tc3RhZ2luZy5jb20iLCJzdWIiOiI1ZDEyY2JjMDg4ODM1IiwiZXhwIjozMTM4NDQzMjM0LCJpYXQiOjE1NjE2NDMyMzQsImp0aSI6IjE2ZmtpY2pjam10ZGNiZW9mdHQ2NW1sZDlqZnNoYWZyIiwKICAidXNlck5hbWUiIDogInl1cmlhbGVqYW5kcm8udmFsdmVyZGVAZ21haWwuY29tIiwKICAidXNlcklkIiA6IDEzMDM1LAogICJzY29wZSIgOiBbICJyZWFkOmFydGljbGUiIF0KfQ.f-bmbNOkdlCmck0nUrjmjnqLNrSuro4C55H-qLtNlZA"
    url = "https://api.elevio-staging.com/v1/articles/#{id}"
    headers = ["Authorization": "Bearer #{token}", "Accept": "Application/json; Charset=utf-8", "x-api-key": "#{key}"]
    response = HTTPoison.get!(url,headers);
    req = Poison.decode!(response.body)
    IO.puts("Article with id: #{id}")
    IO.inspect(req["article"])
    IO.puts("****************************")
  end
end
