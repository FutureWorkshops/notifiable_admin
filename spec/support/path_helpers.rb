module PathHelpers
  def user_api_v1_device_tokens_path
    "#{user_api_v1_notifiable_path}/device_tokens"
  end

  def user_api_v1_device_token_path(device_token)
    "#{notifiable_device_tokens_path}/#{device_token.id}"
  end
end
