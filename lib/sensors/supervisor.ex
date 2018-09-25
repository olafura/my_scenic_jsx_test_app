# a simple supervisor that starts up the Scenic.SensorPubSub server
# and any set of other sensor processes

defmodule MyScenicApp.Sensor.Supervisor do
  use Supervisor

  alias MyScenicApp.Sensor.Temperature

  def start_link() do
    Supervisor.start_link(__MODULE__, :ok)
  end

  def init(:ok) do
    children = [
      {Scenic.Sensor, nil},
      {Temperature, nil}
    ]

    Supervisor.init(children, strategy: :one_for_one)
  end
end
