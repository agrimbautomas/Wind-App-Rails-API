class GetWindguruData < Interactor
  include ApplicationHelper
  SCRAPE_INTENTS = 8

  def self.default
    endpoint = 'iapi.php'
    scrape_wind_data = new endpoint: endpoint
    scrape_wind_data.execute
  end

  def initialize(endpoint:)
    @endpoint = endpoint
    @intents_counter = 1
    @intent_hour_counter = 0
    @intent_day_counter = 0
  end

  def execute
    @logs = get_wind_logs
    write_to_console 'SUCCESS' if @logs['fcst'].present?
    @logs
  end

  private

  def get_wind_logs
    SCRAPE_INTENTS.times do
      @response = GetRequest.to(uri: uri, params: params, headers: headers)
      break if @response['fcst'].present?

      @intents_counter += 1
    end

    clean_response @response
  end

  def uri
    'https://www.windguru.net/int/' + @endpoint
  end

  def params
    query = '?q=forecast'
    query += '&id_model=29'
    query += '&initstr=' + initstr
    query += '&id_spot=261'
    query += '&WGCACHEABLE=21600'
    query += '&cachefix=-34.58x-58.4x30'
    query
  end

  def initstr
    # Today and yesterday
    day_matches = [0, -1]
    hour_matches = %w(00 06 12 18)

    day = DateTime.now + day_matches[@intent_day_counter]
    match = day.strftime('%Y%m%d') + hour_matches[@intent_hour_counter]

    @intent_day_counter += 1 if @intents_counter == 4
    @intent_hour_counter = @intents_counter == 4 ? 0 : @intent_hour_counter += 1

    match
  end

  def headers
    {'Content-Type' => 'application/x-www-form-urlencoded'}
  end

  def clean_response response
    JSON.parse(response)
  end

end