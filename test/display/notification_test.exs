defmodule NotificationTest do
  use ExUnit.Case
  alias Display.Notifications

  test "shows possible koans when a koan can not be found" do
    message = Notifications.invalid_koan(SampleKoan, [PassingKoan])
    assert message == "Did not find koan SampleKoan in PassingKoan"
  end
end
