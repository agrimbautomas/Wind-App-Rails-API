class CreateWindAvgs < Interactor
  include StationsHelper

  AVGS_PER_HOUR = 5

  def self.default
    scrape_wind_data = new
    scrape_wind_data.execute
  end

  def initialize

  end

  def execute
    for i in 1..AVGS_PER_HOUR
      get_avg_by_hour i
    end
  end

  private


  def get_avg_by_hour previous_hours
    @hours_before_min = rounded_time previous_hours
    @hours_before_max = rounded_time(previous_hours - 1)

    if wind_logs.any?
      create_norden_avg
    else
      create_windguru_avg
    end
  end

  def create_norden_avg
    speed_avg = avg_by(:speed)
    gust_avg = wind_logs.average(:gust).to_f
    direction_avg = wind_logs.average(:direction).to_f
    source = 'norden'

    save_avg speed_avg, gust_avg, direction_avg, @hours_before_min, source unless speed_avg.nil?
  end

  def create_windguru_avg
    wind_log = windguru_logs.where('extract(hour from registered_date) = ?', @hours_before_min.hour).first
    speed_avg = wind_log.speed unless wind_log.nil?
    gust_avg = wind_log.gust unless wind_log.nil?
    direction_avg = wind_log.direction unless wind_log.nil?
    source = 'windguru'

    save_avg speed_avg, gust_avg, direction_avg, @hours_before_min, source unless speed_avg.nil?
  end

  def save_avg speed, gust, direction, date, source
    WindAvg.create!(
        speed: speed,
        gust: gust,
        direction: direction,
        registered_date: date,
        source: source
    ) unless WindAvg.exists?(registered_date: date)
  end

  def rounded_time previous_hours
    (DateTime.now.in_time_zone - previous_hours.hours).change({min: 0})
  end

  def wind_logs
    WindLog.where('station_id = ? AND registered_date > ? AND registered_date < ?', norden, @hours_before_min, @hours_before_max)
  end

  def avg_by column
    wind_logs.average(column).to_f
  end


end
