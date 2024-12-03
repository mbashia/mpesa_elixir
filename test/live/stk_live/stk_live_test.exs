defmodule MpesaWeb.StkLiveTest do
  @moduledoc false
  use MpesaWeb.ConnCase

  import Phoenix.LiveViewTest

  describe "STK Live" do
    test "page renders correctly", %{conn: conn} do
      {:ok, live_view, html} = live(conn, ~p"/stk-test")
      assert html =~ "Hello use this page to test Mpesa Stk(Sim tool kit) push"
      assert has_element?(live_view, "input[name='stk_form[Phone_number]']")
      assert has_element?(live_view, "input[name='stk_form[amount]']")
      assert has_element?(live_view, "button", "Pay")
    end
  end
end
