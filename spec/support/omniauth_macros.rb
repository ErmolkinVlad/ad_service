module OmniauthMacros
  def mock_auth_hash
    # The mock_auth configuration allows you to set per-provider (or default)
    # authentication hashes to return during integration testing.
    OmniAuth.config.mock_auth[:twitter] = OmniAuth::AuthHash.new({
      'provider' => 'twitter',
      'uid' => '123545',
      'info' => {
        'email' => 'mock@gmail.com',
        'image' => ''
      },
      'credentials' => {
        'token' => 'mock_token',
        'secret' => 'mock_secret'
      }
    })

    OmniAuth.config.mock_auth[:facebook] = OmniAuth::AuthHash.new({
      'provider' => 'facebook',
      'uid' => '123545',
      'info' => {
        'email' => 'mock@gmail.com',
        'image' => ''
      },
      'credentials' => {
        'token' => 'mock_token',
        'secret' => 'mock_secret'
      }
    })

    OmniAuth.config.mock_auth[:vkontakte] = OmniAuth::AuthHash.new({
      'provider' => 'vkontakte',
      'uid' => '123545',
      'info' => {
        'email' => 'mock@gmail.com',
        'image' => ''
      },
      'credentials' => {
        'token' => 'mock_token',
        'secret' => 'mock_secret'
      }
    })
  end
end