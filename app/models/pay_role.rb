# require "date"

class PayRole < ApplicationRecord
  belongs_to :employee

  def punch_in_date
    self.punch_in.strftime("%a %b %d, %Y %I:%M%p")
  end
  def punch_out_date
    self.punch_out.strftime("%a %b %d, %Y %I:%M%p")
  end
  def day_name
    self.punch_in.strftime("%a")
  end
#   def punch_in_month
#     self.punch_in.split(" ")[1].to_i
#   end

#   def punch_out_month
#     self.punch_out.split(" ")[1].to_i
#   end
  def weekly_hours
    worked_hours
  end
  def punch_in_day
    self.punch_in.strftime("%d").to_i
  end

  def punch_out_day
    self.punch_out.strftime("%d").to_i
  end

  def punch_in_hour
    self.punch_in.strftime("%H").to_i
  end

  def punch_out_hour
    self.punch_out.strftime("%H").to_i
  end

   def punch_in_minute
    self.punch_in.strftime("%M").to_i
   end

   def punch_out_minute
    self.punch_out.strftime("%M").to_i
   end


  def hours  
        if punch_in_day == punch_out_day 
            hours = punch_out_hour - punch_in_hour 
            if punch_in_minute > punch_out_minute
               hours - 1
            else
               hours
            end
        else 
            24 - punch_in_hour + punch_out_hour 
        end
  end

  def minutes
    if punch_in_hour == punch_out_hour
       minutes = punch_out_minute - punch_in_minute
    elsif punch_in_minute < punch_out_minute
        minutes =  punch_out_minute - punch_in_minute
    elsif punch_in_minute > punch_out_minute
        minutes =  60 - (punch_in_minute - punch_out_minute)
    end
  end

  def worked_hours
    if punch_out 
        "#{hours}:#{minutes}"
    else
        "Must punch out to see hours"
    end
  end


def format_convert(time)  
    if time[:punch_in_date]   
        if !time[:punch_in_date].empty? && !time[:punch_in_time].empty?
            date = time[:punch_in_date].split("-")
            time = time[:punch_in_time].split(":")
            day =  Time.new(date.first, date[1], date.last).strftime("%A")
            month = Date::MONTHNAMES[date[1].to_i]
            self.update(punch_in: "#{day} #{month} #{date[2]} #{time[0].to_i}:#{time[1]}:00 #{date.first}")  
        else
          "No date or time was enter"
        end
    elsif time[:punch_out_date]
        if !time[:punch_out_date].empty? && !time[:punch_out_time].empty?
            date = time[:punch_out_date].split("-")
            time = time[:punch_out_time].split(":")
            day =  Time.new(date.first, date[1], date.last).strftime("%A")
            month = Date::MONTHNAMES[date[1].to_i]
            self.update(punch_out: "#{day} #{month} #{date[2]} #{time[0].to_i}:#{time[1]}:00 #{date.first}")  
        else
          "No date or time was enter"
        end
    end
end




end


