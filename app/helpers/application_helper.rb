module ApplicationHelper
  def translate_time(time)
    time.strftime("%B %d, %Y %I:%M:%S%p")
  end
end
