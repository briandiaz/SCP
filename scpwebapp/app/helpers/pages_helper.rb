module PagesHelper

  def group_object_by_month(object)
    object.order("created_at ASC").group_by { |value| value.created_at.beginning_of_month }
  end

  def group_by_month_yearly_data(object)
    logs_months = group_object_by_month(object)
    monthly_logs = [[1,0],[2,0],[3,0],[4,0],[5,0],[6,0],[7,0],[8,0],[9,0],[10,0],[11,0],[12,0]]
    logs_months.sort.each do |month, tasks|
      monthly_logs.each do |value|  
        value[1] = tasks.count if value[0] == month.strftime('%-m').to_i
      end
    end 
    monthly_logs
  end

  def current_month_object_data(object,data)
    data[Time.now.strftime('%-m').to_i-1][1]
  end

  def last_month_object_data(object,data)
    data[Time.now.strftime('%-m').to_i-2][1]
  end

  def get_percentage(current,old)
    if current == old
      0
    else
      if old > 0
        (100*(old-current) / old).abs
      else
        100
      end
    end
  end

  def get_percentage_icon(left,right)
    left >= right ? "up" : "down"
  end

  def get_percentage_span(left,right)
    left >= right ? t("layout.dashboard.higher") : t("layout.dashboard.lower")
  end

  def get_object_dashboard_data(object)
    monthly = group_by_month_yearly_data(object)
    current_month = current_month_object_data(object,monthly)
    last_month = last_month_object_data(object,monthly)
    {
      "monthly_data"        =>  monthly,
      "current_month_value" =>  current_month,
      "last_month"          =>  last_month,
      "percentage"          =>  get_percentage(current_month,last_month),
      "percentage_icon"     =>  get_percentage_icon(current_month,last_month),
      "percentage_span"     =>  get_percentage_span(current_month,last_month),
      "count"               =>  object.count
      }
  end

end
