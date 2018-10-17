defmodule MyScenicApp.Scene.Sensor do
  use Scenic.Scene

  alias Scenic.Graph
  alias Scenic.ViewPort
  alias Scenic.Sensor

  import Scenic.Primitives
  import Scenic.Components

  require ScenicJsx
  import ScenicJsx

  alias MyScenicApp.Component.Nav
  alias MyScenicApp.Component.Notes

  @body_offset 80
  @font_size 160
  @degrees "°"

  @notes """
    \"Sensor\" is a simple scene that displays data from a simulated sensor.
    The sensor is in /lib/sensors/temperature and uses Scenic.Sensor
    The buttons are placeholders showing custom alignment.
  """

  # ============================================================================
  # setup

  # --------------------------------------------------------
  def init(_, opts) do
    {:ok, %ViewPort.Status{size: {vp_width, _}}} =
      opts[:viewport]
      |> ViewPort.info()

    col = vp_width / 6

    # build the graph
    graph = ~z(
        <font=#{:roboto} font_size=#{16} theme=#{:dark}>
          <translate=#{{0, @body_offset}}>
            <text id=#{:temperature} text_align=#{:center} font_size=#{@font_size} translate=#{{vp_width / 2, @font_size}}/>
            <translate=#{{col, @font_size + 60}} button_font_size=#{24}>
              <button width=#{col * 4} height=#{46} theme=#{:primary}>"Calibrate"</button>
              <button width=#{col * 2 - 6} height=#{46} theme=#{:secondary} translate=#{{0, 60}}>
                Maintenance
              </button>
              <button width=#{col * 2 - 6} height=#{46} theme=#{:secondary} translate=#{{col * 2 + 6, 60}}>
                Settings
              </button>
            </>
          </>
          <Nav>#{__MODULE__}</Nav>
          <Notes>#{@notes}</Notes>
        </>
      )
      |> push_graph()

    # subscribe to the simulated temperature sensor
    Sensor.subscribe(:temperature)

    {:ok, graph}
  end

  # --------------------------------------------------------
  # receive updates from the simulated temperature sensor
  def handle_info({:sensor, :data, {:temperature, kelvin, _}}, graph) do
    # fahrenheit
    temperature =
      (9 / 5 * (kelvin - 273) + 32)
      # temperature = kelvin - 273                      # celcius
      |> :erlang.float_to_binary(decimals: 1)

    graph
    # center the temperature on the viewport
    |> Graph.modify(:temperature, &text(&1, temperature <> @degrees))
    |> push_graph()

    {:noreply, graph}
  end
end
