defmodule MyScenicApp.Component.Nav do
  use Scenic.Component
  require ScenicJsx
  import ScenicJsx

  alias Scenic.ViewPort

  import Scenic.Primitives, only: [{:text, 3}, {:rect, 3}]
  import Scenic.Components, only: [{:dropdown, 3}]
  import Scenic.Clock.Components

  # import IEx

  @height 60

  # --------------------------------------------------------
  def verify(scene) when is_atom(scene), do: {:ok, scene}
  def verify({scene, _} = data) when is_atom(scene), do: {:ok, data}
  def verify(_), do: :invalid_data

  # ----------------------------------------------------------------------------
  def init(current_scene, opts) do
    styles = opts[:styles] || %{}

    # Get the viewport width
    {:ok, %ViewPort.Status{size: {width, _}}} =
      opts[:viewport]
      |> ViewPort.info()

    graph =
      ~z(
        <styles=#{styles} font_size=#{20}>
          <rect fill=#{{48, 48, 48}}>#{{width, @height}}</rect>
          <text translate=#{{14, 35}} align=#{:right}>Scene:</text>
          <dropdown id=#{:nav} translate=#{{70, 15}}>#{
            {[
              {"Sensor", MyScenicApp.Scene.Sensor},
              {"Primitives", MyScenicApp.Scene.Primitives},
              {"Components", MyScenicApp.Scene.Components},
              {"Transforms", MyScenicApp.Scene.Transforms}
            ], current_scene}
          }
          </dropdown>
          <digital_clock text_align=#{:right} translate=#{{width - 20, 35}}/>
        </>
      )
      |> push_graph()

    {:ok, %{graph: graph, viewport: opts[:viewport]}}
  end

  # ----------------------------------------------------------------------------
  def filter_event({:value_changed, :nav, scene}, _, %{viewport: vp} = state)
      when is_atom(scene) do
    ViewPort.set_root(vp, {scene, nil})
    {:stop, state}
  end

  # ----------------------------------------------------------------------------
  def filter_event({:value_changed, :nav, scene}, _, %{viewport: vp} = state) do
    ViewPort.set_root(vp, scene)
    {:stop, state}
  end
end
