Time::DATE_FORMATS.merge!(
  :default => lambda { |time| time.today? ? time.strftime("%H:%m") : time.strftime("#{time.day.ordinalize} %h, %H:%m") },
  :seconds => lambda { |time| time.today? ? time.strftime("%H:%m:%S") : time.strftime("#{time.day.ordinalize} %h, %H:%m:%S") }
)