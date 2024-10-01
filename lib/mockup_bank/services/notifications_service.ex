defmodule MockupBank.Services.NotificationsService do
  def notify(user, message) do
    user
    |> push_notifications(message)
    |> notify_sms(message)
    |> notify_email(message)
  end

  def notify_sms(user, message) do
    Task.start(fn ->
      if user.notify_sms do
        # Insert code to send SMS here
        IO.puts("SMS sent to #{user.phone} with message: #{message}")
      else
        IO.puts("User has opted out of SMS notifications.")
      end
    end)

    user
  end

  def notify_email(user, message) do
    Task.start(fn ->
      if user.notify_email do
        # Insert code to send Email here
        IO.puts("Email sent to #{user.email} with message: #{message}")
      else
        IO.puts("User has opted out of Email notifications.")
      end
    end)

    user
  end

  def push_notifications(user, message) do
    Task.start(fn ->
      if user.push_notifications do
        # Insert code to send Push Notification here
        IO.puts("Push notification sent to #{user.name} with message: #{message}")
      else
        IO.puts("User has opted out of Push notifications.")
      end
    end)

    user
  end
end
