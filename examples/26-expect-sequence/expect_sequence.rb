group "Learn about expect_sequence" do
  target "Expect sequence OK"
  run "cat /etc/hosts"

  expect_sequence do
    find "127.0.0.1"
    next_with "# fallback"
    find "# special"
    next_with "::1"
  end

  expect_sequence do
    move 19
    find "ff00::0"
    next_with "ff02::1"
    next_with "ff02::2"
    next_with "ff02::3"
  end
end
