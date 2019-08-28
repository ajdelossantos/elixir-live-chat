defmodule LiveChatWeb.ConnectLiveTest do
  use LiveChatWeb.ConnCase
  import Phoenix.LiveViewTest

  describe "static mount" do
    test "shows the form", %{conn: conn} do
      conn = get(conn, "/")
      html = html_response(conn, 200)

      assert html =~ "Enter a name"
      assert html =~ "Enter an email"
    end
  end

  describe "connected mount" do
    test "shows the form", %{conn: conn} do
      {:ok, _view, html} = live(conn, "/")

      assert html =~ "Enter a name"
      assert html =~ "Enter an email"
    end
  end

  describe "form submission" do
    test "requires all fields to be filled", %{conn: conn} do
      {:ok, view, _html} = live(conn, "/")

      form = %{"user" => %{"name" => "", "email" => ""}}
      html = render_submit(view, "join", form)

      result_name = Floki.find(html, ".text-field-error[data-field=name]")
      assert length(result_name) == 1
      assert Floki.text(result_name) =~ "can't be blank"

      result_email = Floki.find(html, ".text-field-error[data-field=email]")
      assert length(result_email) == 1
      assert Floki.text(result_email) =~ "can't be blank"
    end

    test "shows welcome text when valid", %{conn: conn} do
      {:ok, view, _html} = live(conn, "/")

      form = %{"user" => %{"name" => "alvin", "email" => "alvin.delossantos@rstor.io"}}
      html = render_submit(view, "join", form)

      result_name = Floki.find(html, ".text-field-error") == []
      # `render(view)` also valid
      assert render(view) =~ "Welcome, alvin"

    end
  end
end
