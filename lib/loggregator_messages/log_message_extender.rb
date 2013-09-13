class LogMessage
  def message_type_name
    {MessageType::OUT => 'STDOUT', MessageType::ERR => 'STDERR'}[message_type]
  end

  def source_type_name
    {SourceType::CLOUD_CONTROLLER => 'CF[CC]',
     SourceType::ROUTER => 'CF[Router]',
     SourceType::UAA => 'CF[UAA]',
     SourceType::DEA => 'CF[DEA]',
     SourceType::WARDEN_CONTAINER => 'App',}[source_type]
  end

  def timestamp=(timestamp)
    timestamp ||= Time.now
    t = timestamp.is_a?(Time) ? timestamp : Time.at(timestamp.to_f)
    @timestamp = (t.tv_sec * 1000000000) + t.tv_nsec
  end

  def time
    num_secs = @timestamp / 1000000000
    fractional_usecs = (@timestamp % 1000000000).to_f / 1000
    Time.at(num_secs, fractional_usecs)
  end
end
