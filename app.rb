class Car
  def initialize
    @speed = 10
  end
  def start_engine
       puts "Wroom"
  end
  def beep
    puts "beep"
  end
  def stop
    @speed = 0
  end
  def go
    @speed = 50
  end
  def current_speed
    puts @speed
  end
end
