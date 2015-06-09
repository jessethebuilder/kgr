require 'rest-client'
require 'json'

module SimplecastHelper
  SIMPLECAST_ID = '1200'

  def simplecast_episodes
    # RestClient.get("#{url_base}/#{SIMPLECAST_ID}/episodes.json", auth_params)
    RestClient.get("#{url_base}/#{SIMPLECAST_ID}/episodes.json?api_key=#{ENV['SIMPLECAST_API_KEY']}")

  end

  def simplecast_episode(episode_id)
    RestClient.get("#{url_base}/podcasts/#{SIMPLECAST_ID}/episodes/#{episode_id}.json", auth_params)

  end

  private

  def url_base
    "https://api.simplecast.fm/v1"
  end

  def auth_params
    {'u' => ENV['SIMPLECAST_API_KEY']}
  end
end