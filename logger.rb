# frozen_string_literal: true

module Logger
  extend ActiveSupport::Concern

  private

  def logger_filename
    @logger_filename ||= begin
      logs_dir = 'log/classes'
      FileUtils.mkdir_p(logs_dir) unless File.exist?(logs_dir)

      self.class.to_s.gsub('::', '_').downcase
    end
  end

  def logger(message)
    _logger.info "-----: #{message}".blue
  end

  def time_logger(message)
    start_time = Time.now

    yield

    end_time = Time.now

    total_s = end_time - start_time
    total_ms = total_s * 1000

    time_block = 'Total time:'.blue << " #{total_s} sec (#{total_ms} ms)".red
    _logger.info "#{message}: Done: (#{time_block})"
  end

  def _logger
    @_logger ||= ::Logger.new("log/classes/#{logger_filename}.log")
  end
end
  
