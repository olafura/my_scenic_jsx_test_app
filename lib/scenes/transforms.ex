defmodule MyScenicApp.Scene.Transforms do
  use Scenic.Scene
  alias Scenic.Graph

  import Scenic.Primitives
  import Scenic.Components

  alias MyScenicApp.Component.Nav
  alias MyScenicApp.Component.Notes

  require ScenicJsx
  import ScenicJsx

  @notes """
    \"Transforms\" demonstrates using transforms to position, rotate and scale.
    The upper sliders apply transforms to the group containing the inset UI.
    The lower slider rotates the quad independantly of the upper sliders.
  """

  @start_x 150
  @start_y 300
  @start_scale 1.0

  @graph ~z(
    <font=#{:roboto} font_size=#{20} theme=#{:dark}>
      <translate=#{{0, 70}}>
        <id=#{:something} translate=#{{60, 20}} text_align=#{:right}>
          <text>X</text>
          <text translate=#{{0, 20}}>Y</text>
          <text translate=#{{0, 40}}>Scale</text>
          <text translate=#{{0, 60}}>Angle</text>
        </>
        <translate=#{{70, 6}}>
          <slider id=#{:pos_x}>#{{{00, 500}, @start_x}}</slider>
          <slider id=#{:pos_y} translate=#{{0, 20}}>#{{{180, 400}, @start_y}}</slider>
          <slider id=#{:scale} translate=#{{0, 40}}>#{{{0.2, 3.0}, @start_scale}}</slider>
          <slider id=#{:rotate_ui} translate=#{{0, 60}}>#{{{-1.5708, 1.5708}, 0}}</slider>
        </>
      </>
      <translate=#{{@start_x, @start_y}} pin=#{{100, 25}} id=#{:ui_group}>
        <text translate=#{{0, 30}}>Inner UI group</text>
        <quad id=#{:quad} fill=#{{:linear, {0, 0, 40, 40, :yellow, :purple}}} stroke=#{{2, :khaki}} translate=#{{140, 0}} scale=#{1.4}>
        #{{{0, 20}, {30, 0}, {36, 26}, {25, 40}}}
        </quad>
        <slider id=#{:rotate_quad} translate=#{{0, 50}} width=#{200}>#{{{-1.5708, 1.5708}, 0}}</slider>
      </>
      <Nav>#{__MODULE__}</Nav>
      <Notes>#{@notes}</Notes>
    </>
  )
  # ============================================================================
  # setup

  # --------------------------------------------------------
  def init(_, _opts) do
    push_graph(@graph)

    state = %{
      graph: @graph,
      x: @start_x,
      y: @start_y
    }

    {:ok, state}
  end

  # --------------------------------------------------------
  def filter_event(
        {:value_changed, :pos_x, x},
        _,
        %{
          graph: graph,
          y: y
        } = state
      ) do
    graph =
      graph
      |> Graph.modify(:ui_group, &update_opts(&1, translate: {x, y}))
      |> push_graph()

    {:stop, %{state | graph: graph, x: x}}
  end

  # --------------------------------------------------------
  def filter_event(
        {:value_changed, :pos_y, y},
        _,
        %{
          graph: graph,
          x: x
        } = state
      ) do
    graph =
      graph
      |> Graph.modify(:ui_group, &update_opts(&1, translate: {x, y}))
      |> push_graph()

    {:stop, %{state | graph: graph, y: y}}
  end

  # --------------------------------------------------------
  def filter_event({:value_changed, :scale, scale}, _, %{graph: graph} = state) do
    graph =
      graph
      |> Graph.modify(:ui_group, &update_opts(&1, scale: scale))
      |> push_graph()

    {:stop, %{state | graph: graph}}
  end

  # --------------------------------------------------------
  def filter_event({:value_changed, :rotate_ui, angle}, _, %{graph: graph} = state) do
    graph =
      graph
      |> Graph.modify(:ui_group, &update_opts(&1, rotate: angle))
      |> push_graph()

    {:stop, %{state | graph: graph}}
  end

  # --------------------------------------------------------
  def filter_event({:value_changed, :rotate_quad, angle}, _, %{graph: graph} = state) do
    graph =
      graph
      |> Graph.modify(:quad, &update_opts(&1, rotate: angle))
      |> push_graph()

    {:stop, %{state | graph: graph}}
  end
end
