require 'rest-client'
require 'json'

module SimplecastHelper
  SIMPLECAST_ID = '1200'

  def simplecast_episode_list
    JSON.parse(episode_list_json)
  end

  def simplecast_episode(episode_id)
    JSON.parse(episode_json(episode_id))
  end

  private

  def url_base
    "https://api.simplecast.fm/v1/podcasts/"
  end

  def auth_params
    "api_key=#{ENV['SIMPLECAST_API_KEY']}"
  end

  def episode_list_json
    RestClient.get("#{url_base}#{SIMPLECAST_ID}/episodes.json?#{auth_params}")
  end

  def episode_json(episode_id)
    RestClient.get("#{url_base}#{SIMPLECAST_ID}/episodes/#{episode_id}.json?#{auth_params}")
  end
end