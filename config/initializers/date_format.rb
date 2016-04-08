Time::DATE_FORMATS.merge!(
  :default => lambda { |time| time.today? ? time.strftime("%H:%M") : time.strftime("#{time.day.ordinalize} %h, %H:%M") },
  :seconds => lambda { |time| time.today? ? time.strftime("%H:%M:%S") : time.strftime("#{time.day.ordinalize} %h, %H:%M:%S") }
)